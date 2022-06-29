package fr.epsi.rennes.poec.evoli.mspr.dao;

import fr.epsi.rennes.poec.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.evoli.mspr.domain.Commande;
import fr.epsi.rennes.poec.evoli.mspr.domain.Panier;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
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

import static org.mariadb.jdbc.Statement.RETURN_GENERATED_KEYS;

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
    private final Logger logger = LogManager.getLogger(CommandeDAO.class);
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
    public int doCustomerOrder(int userId, int panierId) throws SQLException {

        int orderId = -1;
        Panier panier = panierDAO.getPanierById(panierId);
        if (panier == null) {
            throw new SQLException("#CommandeDAO##order  ::: pannier %d invalide".formatted(panierId));
        }
        logger.info("ordering : userId= %d cartId %d, for customerId %d".formatted(userId, panierId, panier.getCustomerId()));
        String sql = "INSERT INTO order_ (customer_id, TVA, prix_ttc) VALUES (?, ?, ?);";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, RETURN_GENERATED_KEYS)) {
            ps.setInt(1, panier.getCustomerId());
            ps.setDouble(2, panier.calc_TVA());
            ps.setDouble(3, panier.getTotalPrix());

            try {
                ps.executeUpdate();
            } catch (SQLException e) {
                logger.error("could not %s\n with userId= %d && cartId= %d".formatted(sql, orderId, panierId));
                conn.rollback();
                throw new SQLException(sql + userId);
            }
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
                try { // Tables de liaisons
                    newOrderArticlesTable(orderId, panier, conn);
                    newCustomerOrderTable(panier.getCustomerId(), orderId, conn);
                } catch (SQLException e) {
                    throw new SQLException(e);
                }

                logger.trace("Vidange du pannier N° %d".formatted(panierId));
                panierDAO.truncate(panierId);
            } else {
                conn.rollback();
            }
            conn.close();
            return orderId;
        } catch (SQLException e) {
            logger.fatal("could not %s\n with customerId= %d".formatted(sql, panier.getCustomerId()));
            throw new SQLException(e);
        }
    }

    private void newCustomerOrderTable(int userId, int orderId, Connection conn) throws SQLException {
        String sql = "INSERT INTO customer_has_order (customer_id, order_id) VALUE (?, ?)";
        logger.debug("newUserOrderTable : uid: %d, order: %d".formatted(userId, orderId));
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            logger.error("could not %s\n with userId= %d && orderId= %d".formatted(sql, orderId, orderId));
            conn.rollback();
            conn.close();
            throw new SQLException(e);
        }
    }

    private long newOrderArticlesTable(int orderId, Panier panier, Connection conn) throws SQLException {

        logger.trace("newOrderTable ");
        String sql = "INSERT INTO  order_has_article (order_id, article_id) VALUES(?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, RETURN_GENERATED_KEYS)) {
            if (panier.getArticles() == null) {
                return -1;
            }
            for (Article article : panier.getArticles()) {
                ps.setInt(1, orderId);
                ps.setInt(2, article.getId());
                ps.executeUpdate();
            }
            logger.info("created order: %d".formatted(orderId));
            return orderId;
        } catch (SQLException e) {
            logger.error("could not %s\n with orderId= %d && panierId= %d".formatted(sql, orderId, panier.getId()));
            conn.rollback();
            conn.close();
            throw new SQLException(e);
        }
    }

    private long newOrderStatusUpdate(int orderId, int statusId, Connection conn) throws SQLException {

        String sql = "INSERT INTO order_has_status VALUES (?,?)";

        try (PreparedStatement ps = conn.prepareStatement(sql, RETURN_GENERATED_KEYS)) {
            ps.setInt(1, orderId);
            ps.setInt(2, statusId);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
            return -1;
        } catch (SQLException e) {
            logger.error("could not %s\n with orderId= %d && statusId= %d".formatted(sql, orderId, statusId));
            conn.rollback();
            conn.close();
            throw new SQLException(e);
        }
    }


    /**
     * @param userId le userId de l'utilisateur dont on veut querry les commandes
     * @return Une liste des commandes prises par l'utilisateur, avec date, prix ttc, prix ht,
     * numero de commande et son contenu
     */

    @Transactional
    public List<Commande> getOrdersFromCustomerId(int userId, int limit) throws SQLException {

        String sql = "select * "
                + "from order_ "
                + "where customer_id = ? "
                + "ORDER BY date_created DESC "
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
                commande.setOrderId(rs.getInt("order_id"));
                commande.setNumeroCmd(rs.getString("date_created"));
                commande.setPrixHT(rs.getDouble("prix_ttc") - rs.getInt("TVA"));
                commande.setPrixTTC(rs.getDouble("prix_ttc"));
                commande.setArticles(this.getArticlesFromOrderId(rs.getInt("order_id")));
                //TODO GetStatus from id_status
                commandeList.add(commande);
            }
            return commandeList;
        } catch (SQLException e) {
            logger.error("could not %s\n with userId= %d".formatted(sql, userId));
            throw new SQLException(e);
        }
    }

    private List<Article> getArticlesFromOrderId(int orderId) throws SQLException {
        String sql = "SELECT * FROM order_has_article WHERE order_id = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            conn.close();
            List<Article> articles = new ArrayList<>();
            List<Article> articleRepo = articleDAO.getAllPokemons();
            while (rs.next()) {
                int articleId = rs.getInt(2);
                for (Article article : articleRepo) {
                    if (articleId == article.getId()) {
                        articles.add(article);
                    }
                }
            }
            return articles;
        } catch (SQLException e) {
            logger.error("could not %s\n with orderId= %d".formatted(sql, orderId));
            throw new SQLException(e);
        }
    }

    public Commande getOrderById(int orderId) throws SQLException {
        String sql = "SELECT *, group_concat(order_has_article.article_id) as articles " +
                "FROM order_, order_has_article WHERE order_.order_id = ? AND order_has_article.order_id = order_.order_id ";

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
                List<Article> articlesRepo = articleDAO.getAllPokemons();
                List<Article> articles = new ArrayList<>();
                for (String _tmp : rs.getString("articles").split(",")) {
                    for (Article article : articlesRepo) {
                        if (article.getId() == Integer.parseInt(_tmp)) {
                            articles.add(article);
                        }
                    }
                }
                commande.setArticles(articles);
            }
            return commande;
        } catch (SQLException e) {
            logger.error("could not %s\n with orderId= %d".formatted(sql, orderId));
            throw new SQLException(e);
        }
    }

    public void addUserOrder(int userId, int orderId) throws SQLException {
        String sql = "INSERT INTO user_has_order (order_id, user_id) VALUES (?,?);";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, userId);

            int ctrl = ps.executeUpdate();
        } catch (SQLException e) {
            logger.error("could not %s with orderId= %d && userId= %d".formatted(sql, orderId, userId));
            throw new SQLException(e);
        }
    }

    public List<Commande> getOrdersFromUserId(int userId, int limit) throws SQLException {
        String sql = "SELECT group_concat(user_has_order.order_id) as orders FROM order_, user_has_order " +
                "WHERE order_.order_id = user_has_order.order_id AND user_has_order.user_id = ?;";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            conn.close();
            List<Commande> orders = new ArrayList<>();
            if (rs.next()) {
                String str = rs.getString("orders");
                if (str != null) {
                    for (String order : str.split(",")) {
                        orders.add(getOrderById(Integer.parseInt(order)));
                    }
                }
            }
            return orders;
        } catch (SQLException e) {
            logger.error("could not %s with userId= %d".formatted(sql, userId));
            throw new SQLException(e);
        }
    }

}
