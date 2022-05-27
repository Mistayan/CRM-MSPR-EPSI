package fr.epsi.rennes.poec.stephen.mistayan.dao;

import fr.epsi.rennes.poec.stephen.mistayan.domain.Commande;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Panier;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Pizza;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mariadb.jdbc.Statement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Author : Stephen Mistayan
 * Created on : 5/10/2022 : 9:24 AM:34
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.stephen.mistayan.domain
 * Project name : pizzaHut
 **/

@Repository
@Transactional
public class CommandeDAO {


    private static final Logger logger = LogManager.getLogger(CommandeDAO.class);
    @Autowired
    private PanierDAO panierDAO;
    @Autowired
    private pizzaDAO pizzaDAO;
    @Autowired
    private DataSource ds;

    /**
     * Le but de ces fonctions est de créer une commande. Celles ci ce décompose comme suit:
     * insert into order_ (userId, panierId)
     * FOREACH pizza in panier, insert into order_articles (panierId, pizzaId)
     * insert into user_order (iserId, panierId)
     *
     * @return success ? order_id : -1
     */
    public int order(int userId, int panierId) throws SQLException {
        int orderId = -1;
        Panier panier = panierDAO.getPanierById(panierId);
        if (panier == null) {
            throw new SQLException("#CommandeDAO##order  ::: panier invalide");
        }
        logger.trace("#CommandeDAO##order  ::: " + userId + " ordered panier : " + panierId);
        String sql = "INSERT INTO order_ " +
                "(user_id, TVA, prix_ttc) VALUES " +
                "(?, ?, ?)";
        logger.trace(panier.toString());
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.setDouble(2, panier.getTVA());
            // TAUX TVA ALIMENTAIRE :: 5.5
            ps.setDouble(3, panier.getTotalPrix());

            if (ps.executeUpdate() == 0) {
                logger.warn("#CommandeDAO##order  ::: ps.execute() failed");
                throw new SQLException(sql + userId + ", " + panier.getTVA() + ", " + panier.getTotalPrix());
            }
            ResultSet rs = ps.getGeneratedKeys();
            conn.close();
            if (rs.next()) {
                orderId = rs.getInt(1);
                if (newOrderArticlesTable(orderId, panier) != orderId) {
                    throw new SQLException("un-Equal orderId from order_article & order");
                }

                logger.debug("newUserOrderTable : " + userId + ", " + orderId);
                if (newUserOrderTable(userId, orderId, conn) == -1) {
                    conn.rollback();
                    throw new SQLException("should be rollback : n'a pas pu ajouter dans user_order");
                }
                if (orderId > 0) {
                    logger.trace("##############\tCommandeDAO :: vidange du pannier N°" + panierId);
                    panierDAO.truncate(panierId);
                }
            }
            conn.commit();
            conn.close();
            return rs.getInt(1); //orderId
        } catch (SQLException e) {
            logger.fatal("##############\tCommandeDAO :: " + e);
            throw new SQLException(e);
        }
    }

    private long newUserOrderTable(int userId, int orderId, Connection conn) throws SQLException {
        String sql = "INSERT INTO user_order (user_id, order_id) VALUE (?, ?)";
        logger.debug("newUserOrderTable ");
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, orderId);
            if (ps.executeUpdate() == 0) {
                throw new SQLException("##### Cannot insert user_order: " + sql + "\n" + userId + ", " + orderId);
            }
            conn.close();
        } catch (SQLException e) {
            throw new SQLException(e);
        }
        return 1L;
    }

    /**
     * @param order_id id de la commande en cours
     * @param panier   l'objet panier à commander
     * @return success ? order_id : 0
     */
    private long newOrderArticlesTable(int order_id, Panier panier) throws SQLException {

        logger.debug("newOrderTable ");
        String sql = "INSERT INTO order_articles (order_id, pizza_id) VALUES(?,?)";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            for (Pizza pizza : panier.getPizzas()) {
                ps.setInt(1, order_id);
                ps.setInt(2, pizza.getId());
                int result = ps.executeUpdate();
                if (result == 0) {
                    logger.warn("###############" + sql + order_id + " : " + panier.getId() + " failed");
                    throw new SQLException(order_id + ", " + pizza.getId());
                }
            }
            conn.close();
            logger.info("created order:" + order_id);
            return order_id;
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }

    /**
     * @param userId le userId de l'utilisateur dont on veut querry les commandes
     * @return Une liste des commandes prises par l'utilisateur, avec date, prix ttc, prix ht,
     * numero de commande et son contenu
     */
    public List<Commande> getOrdersFromUserId(int userId) throws SQLException {
        String sql = "select * "
                + "from order_ "
                + "where order_.user_id = ? ";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            conn.close();
            List<Commande> commandeList = new ArrayList<>();
            while (rs.next()) {
                Commande commande = new Commande();
                commande.setOrderId(rs.getInt(1));
                commande.setNumeroCmd(rs.getString(5));
                commande.setPrixHT(rs.getDouble(4) - rs.getInt(3));
                commande.setPrixTTC(rs.getDouble(4));
                commande.setPizzas(this.getArticlesFromOrderId(rs.getInt(1)));
                //TODO GetStatus from id_status
                commandeList.add(commande);
            }
            return commandeList;
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }

    private List<Pizza> getArticlesFromOrderId(int orderId) throws SQLException {
        String sql = "SELECT * " +
                "FROM order_articles " +
                "WHERE order_id = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            conn.close();
            List<Pizza> pizzas = new ArrayList<>();
            List<Pizza> pizzaRepo = pizzaDAO.getAll();
            while (rs.next()) {
                int pid = rs.getInt(2);
                for (int i = 0; i < pizzaRepo.size(); i++) {
                    if (pid == pizzaRepo.get(i).getId()) {
                        pizzas.add(pizzaRepo.get(i));
                    }
                }
            }
            return pizzas;
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }
}
