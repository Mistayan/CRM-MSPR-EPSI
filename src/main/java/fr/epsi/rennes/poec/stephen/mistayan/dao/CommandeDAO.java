package fr.epsi.rennes.poec.stephen.mistayan.dao;

import fr.epsi.rennes.poec.stephen.mistayan.domain.Panier;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Pizza;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mariadb.jdbc.Statement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Author : Stephen Mistayan
 * Created on : 5/10/2022 : 9:24 AM:34
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.stephen.mistayan.domain
 * Project name : pizzaHut
 **/

@Repository
public class CommandeDAO {


    private static final Logger logger = LogManager.getLogger(CommandeDAO.class);
    @Autowired
    private final PanierDAO panierDAO = new PanierDAO();
    @Autowired
    private UserDAO userDAO;
    @Autowired
    private DataSource ds;

    /**
     * @param userName nom de l'utilisateur
     * @param panierId le panier à commander
     * @return success ? order_id : 0
     */
    @Transactional
    public long order(String userName, int panierId) throws SQLException {
        int userId = userDAO.getUserByName(userName);
        Panier panier = panierDAO.getPanierById(panierId);
        if (panier == null) {
            throw new SQLException("#CommandeDAO##order  ::: panier invalide");
        }
        logger.trace("#CommandeDAO##order  ::: " + userName + " ordered panier : " + panierId);
        String sql = "INSERT INTO order_ " +
                "(mail, TVA, prix_ttc) VALUES " +
                "(?, ?, ?)";
        logger.trace(panier.toString());
        try (PreparedStatement ps = ds.getConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.setDouble(2, panier.getTVA());
            // TAUX TVA ALIMENTAIRE :: 5.5
            ps.setDouble(3, panier.getTotalPrix());

            if (ps.executeUpdate() == 0) {
                logger.warn("#CommandeDAO##order  ::: ps.execute() failed");
                throw new SQLException(sql + userName + ", " + panier.getTVA() + ", " + panier.getTotalPrix());
            }
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int orderId = rs.getInt(1);
                if (newOrderTable(orderId, panier) != orderId) {
                    throw new SQLException("un-Equal orderId from order_article & order");
                }

                logger.debug("newUserOrderTable : " + userName + ", " + orderId);
                if (newUserOrderTable(userId, orderId) == -1) {
                    throw new SQLException("should be rollback");
                }
                if (orderId > 0) {
                    logger.trace("##############\tCommandeDAO :: emptying panier N°" + panierId);
                    panierDAO.truncate(panierId);
                    return orderId;
                }
            }
        } catch (SQLException e) {
            logger.fatal("##############\tCommandeDAO :: " + e);
            throw new SQLException(e);
        }
        return -1;
    }

    private long newUserOrderTable(int userId, int orderId) throws SQLException {
        String sql = "INSERT INTO user_order (user_id, order_id) VALUE (?, ?)";
        logger.debug("newUserOrderTable ");
        try (PreparedStatement ps = ds.getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, orderId);
            if (ps.executeUpdate() == 0) {
                throw new SQLException("##### Cannot insert user_order: " + sql + "\n" + userId + ", " + orderId);
            }
        } catch (SQLException e) {
            throw new SQLException(e);
        }
        return 1L;
    }

    private long newOrderTable(int order_id, Panier panier) throws SQLException {

        logger.debug("newOrderTable ");
        String sql = "INSERT INTO order_articles (order_id, pizza_id) VALUES(?,?)";
        try (PreparedStatement ps = ds.getConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            for (Pizza pizza : panier.getPizzas()) {
                ps.setInt(1, order_id);
                ps.setInt(2, pizza.getId());
                int result = ps.executeUpdate();
                if (result == 0) {
                    logger.warn("###############" + sql + order_id + " : " + panier.getId() + " failed");
                    throw new SQLException(order_id + ", " + pizza.getId());
                }
            }
            logger.warn("created order:" + order_id);
            return order_id;
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }
}
