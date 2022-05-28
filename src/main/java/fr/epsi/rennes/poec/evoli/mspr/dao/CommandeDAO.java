package fr.epsi.rennes.poec.evoli.mspr.dao;

import fr.epsi.rennes.poec.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.evoli.mspr.domain.Commande;
import fr.epsi.rennes.poec.evoli.mspr.domain.Panier;
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
 * Last modified by:
 * Last modified date:
 * Created on : 5/10/2022 : 9:24 AM:34
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.domain
 * Project name : Evoli-Acme
 **/

@Repository
@Transactional
public class CommandeDAO {
    private static final Logger logger = LogManager.getLogger(CommandeDAO.class);
    private final PanierDAO panierDAO;
    private final ArticleDAO articleDAO;
    private final DataSource ds;

    @Autowired
    public CommandeDAO(PanierDAO panierDAO, ArticleDAO articleDAO, DataSource ds) {
        this.panierDAO = panierDAO;
        this.articleDAO = articleDAO;
        this.ds = ds;
    }

    /**
     * Le but de ces fonctions est de créer une commande. Celles ci ce décompose comme suit:
     * insert into order_ (userId, panierId)
     * pour chaque article dans panier: insert into order_articles (panierId, articleId)
     * insert into user_order (userId, panierId)
     *
     * @return success ? order_id : -1
     */
    @Transactional
    public int order(int userId, int panierId) throws SQLException {

        int orderId = -1;
        Panier panier = panierDAO.getPanierById(panierId);
        if (panier == null) {
            throw new SQLException("#CommandeDAO##order  ::: panier invalide");
        }
        logger.trace("#CommandeDAO##order  ::: " + userId + " ordered panier : " + panierId);
        logger.trace(userId + " ordered panier : " + panierId);
        String sql = "INSERT INTO order_ " +
                "(user_id, TVA, prix_ttc) VALUES " +
                "(?, ?, ?);";
        logger.trace(panier.toString());
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.setDouble(2, panier.getTVA());
            ps.setDouble(3, panier.getTotalPrix());

            try {
                ps.executeUpdate();
            } catch (SQLException e){
                logger.warn("#CommandeDAO##order  ::: ps.execute() failed");
                throw new SQLException(sql + userId + ", " + panier.getTVA() + ", " + panier.getTotalPrix(), e);
            }
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
                if (newOrderArticlesTable(orderId, panier) != orderId) {
                    conn.rollback();
                    throw new SQLException("Rollback : un-Equal orderId from order_article & order");
                }

                logger.debug("newUserOrderTable : " + userId + ", " + orderId);
                if (newUserOrderTable(userId, orderId, conn) == -1) {
                    conn.rollback();
                    throw new SQLException("Rollback : n'a pas pu ajouter dans user_order");
                }
                logger.trace("##############\tCommandeDAO :: vidange du pannier N°" + panierId);
                panierDAO.truncate(panierId);
            } else {
                conn.rollback();
            }
            conn.close();
            return orderId;
        } catch (SQLException e) {
            logger.fatal("##############\tCommandeDAO :: " + e);
            throw new SQLException(e);
        }
    }

    private long newUserOrderTable(int userId, int orderId, Connection conn) throws SQLException {
        String sql = "INSERT INTO user_has_order (user_id, order_id) VALUE (?, ?)";
        logger.trace("newUserOrderTable ");
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
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

    private long newOrderArticlesTable(int order_id, Panier panier) throws SQLException {

        logger.trace("newOrderTable ");
        String sql = "INSERT INTO  order_has_article (order_id, article_id) VALUES(?,?)";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            for (Article article : panier.getArticles()) {
                ps.setInt(1, order_id);
                ps.setInt(2, article.getId());
                int result = ps.executeUpdate();
                if (result == 0) {
                    logger.warn("###############" + sql + order_id + " : " + panier.getId() + " failed");
                    throw new SQLException(order_id + ", " + article.getId());
                }
            }
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
    public List<Commande> getOrdersFromUserId(int userId, int limit) throws SQLException {
        String sql = "select * "
                + "from order_ "
                + "where user_id = ? "
                + "ORDER BY date_created %s ".formatted(limit <= 500 ? "DESC" : "ASC")
                + "LIMIT ? ";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            conn.close();
            List<Commande> commandeList = new ArrayList<>();
            while (rs.next()) {
                Commande commande = new Commande();
                commande.setOrderId(rs.getInt(1));
                commande.setNumeroCmd(rs.getString(2));
                commande.setPrixHT(rs.getDouble(5) - rs.getInt(4));
                commande.setPrixTTC(rs.getDouble(5));
                commande.setArticles(this.getArticlesFromOrderId(rs.getInt(1)));
                //TODO GetStatus from id_status
                commandeList.add(commande);
            }
            return commandeList;
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }

    private List<Article> getArticlesFromOrderId(int orderId) throws SQLException {
        String sql = "SELECT * " +
                "FROM order_has_article " +
                "WHERE order_id = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            conn.close();
            List<Article> articles = new ArrayList<>();
            List<Article> articleRepo = articleDAO.getAll();
            while (rs.next()) {
                int pid = rs.getInt(2);
                for (Article article : articleRepo) {
                    if (pid == article.getId()) {
                        articles.add(article);
                    }
                }
            }
            return articles;
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }

    public Commande getOrderById(int orderId) throws SQLException {
        String sql = "SELECT *, group_concat(order_has_article.article_id) as articles " +
                "FROM order_, order_has_article " +
                "WHERE order_.order_id = ? AND order_has_article.order_id = order_.order_id ";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();
            conn.close();
            Commande commande = new Commande();
            if (rs.next()) {
                commande.setOrderId(rs.getInt("order_.order_id"));
                commande.setNumeroCmd(rs.getString("date_created"));
                commande.setPrixTTC(rs.getDouble("prix_ttc"));
                commande.setPrixHT(rs.getDouble("prix_ttc") - rs.getDouble("TVA"));
                List<Article> articlesREPO = articleDAO.getAll();
                List<Article> articles = new ArrayList<>();
                for (String _tmp : rs.getString("articles").split(",")) {
                    for (Article article : articlesREPO) {
                        if (article.getId() == Integer.parseInt(_tmp)) {
                            articles.add(article);
                        }
                    }
                }
                commande.setArticles(articles);
            }
            return commande;
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }
}
