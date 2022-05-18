package fr.epsi.rennes.poec.stephen.mistayan.dao;

import fr.epsi.rennes.poec.stephen.mistayan.domain.Panier;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Pizza;
import fr.epsi.rennes.poec.stephen.mistayan.exception.TechnicalException;
import org.apache.logging.log4j.Level;
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
     * @param userName  nom de l'utilisateur
     * @param panier_id le panier à commander
     * @return success ? order_id : 0
     */
    @Transactional
    public long order(String userName, int panier_id) throws SQLException {

        Panier panier = panierDAO.getPanierById(panier_id);
        if (panier == null) {
            throw new SQLException("panier invalide");
        }
        logger.trace(userName + " ordered panier : " + panier_id);
        String sql = "INSERT INTO order_ " +
                "(mail, TVA, prix_ttc) VALUES " +
                "(?, ?, ?)";
        logger.log(Level.FATAL, panier.toString());
        try (PreparedStatement ps = ds.getConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, userName);
            ps.setDouble(2, panier.getTVA());
            // TAUX TVA ALIMENTAIRE :: 5.5
            ps.setDouble(3, panier.getTotalPrix());

            if (ps.executeUpdate() == 0) {
                logger.debug("ps.execute() failed");
                throw new SQLException(sql + userName + ", " + panier.getTVA() + ", " + panier.getTotalPrix());
            }
            ResultSet rs = ps.getGeneratedKeys();
            logger.debug("if rs.next()");
            if (rs.next()) {
                int order_id = rs.getInt(1);
                logger.debug("rs.next() on : " + order_id);
                if (newOrderTable(order_id, panier) != order_id) {
                    logger.fatal("unEqual order_id from order_article & order");
                }

                logger.debug("newUserOrderTable : " + userName + ", " + order_id);
                if (newUserOrderTable(userName, order_id) == -1) {
                    logger.fatal("should be rollbacked");
                }
                if (order_id > 0) {
                    logger.warn("##############\tCommandeDAO :: removing panier N°" + panier_id);
                    panierDAO.truncate(panier_id);
                    return order_id;
                }
            }
        } catch (SQLException e) {
            logger.fatal("##############\tCommandeDAO :: " + e);
            throw new SQLException(e);
        }
        return -1;
    }

    private long newUserOrderTable(String userName, int order_id) throws SQLException {
        String sql = "INSERT INTO user_order (user_name, order_id) VALUE (?, ?)";
        logger.debug("newUserOrderTable ");

        try (PreparedStatement ps = ds.getConnection().prepareStatement(sql)) {
            ps.setString(1, userName);
            ps.setInt(2, order_id);
            if (ps.executeUpdate() == 0) {
                throw new TechnicalException(
                        new SQLException("##### Cannot insert user_order: " + sql + "\n" + userName + ", " + order_id));
            }
        } catch (SQLException e) {
            throw new SQLException(e);
        }
        return -1L;
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
                    logger.warn("###############" + sql + " failed");
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
