package fr.epsi.rennes.poec.evoli.mspr.dao;

import fr.epsi.rennes.poec.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.evoli.mspr.domain.Panier;
import fr.epsi.rennes.poec.evoli.mspr.exception.TechnicalException;
import fr.epsi.rennes.poec.evoli.mspr.service.ArticleService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Author : Stephen Mistayan
 * Created on : 5/12/2022 : 11:14 AM:20
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.dao
 * Project name : Evoli-Acme
 **/

@Repository
public class PanierDAO {
    private static final Logger logger = LogManager.getLogger(PanierDAO.class);
    private final DataSource ds;
    private final ArticleService articleService;


    @Autowired
    public PanierDAO(DataSource ds, ArticleService articleService) {
        this.ds = ds;
        this.articleService = articleService;
    }

    @Async
    public void addArticle(Article article, int panierId) {
        String sql = "insert into cart_has_article"
                + "(cart_id, article_id) values (?,?)";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (panierId >= 1) {
                ps.setInt(1, panierId);
            } else {
                ps.setInt(1, 0);
            }
            ps.setInt(2, article.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("could not add article to DB :: Panier: " + panierId + " & pizzaId: " + article.getId());
        }
    }

    public boolean doesPanierExist(int panierId) {
        String sql = "select cart_id from cart where cart_id = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, panierId);

            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }

    //Créer un panier => service et controller
    public int CreatePanier() {
        String sql = "insert into cart () values()";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
            return -1;
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }

    public Panier getPanierById(int panierId) {
        String sql = "select "
                + "cart.cart_id as panier_id, "
//                + "cart.date_created as panier_date, "
                + "group_concat(article.article_id) as articles "
                + "from cart "
                + "right join cart_has_article as panier_ "
                + "on panier_.cart_id = cart.cart_id "
                + "left join article "
                + "on panier_.article_id = article.article_id "
                + "where cart.cart_id = ? ";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, panierId);
            ResultSet rs = ps.executeQuery();
            conn.close();
            if (rs.next()) {
                Panier panier = new Panier();
                panier.setId(rs.getInt("panier_id"));
                String articles = rs.getString("articles");

                List<Article> articleRepo = articleService.getAllArticles();
                List<Article> articleList = new ArrayList<>();
                if (articles != null) {
                    for (String articleId : articles.split(",")) {
                        for (Article article_ : articleRepo) {
                            if (article_.getId() == Integer.parseInt(articleId)) {
                                articleList.add(article_);
                            }
                        }
                    }
                    panier.setArticles(articleList);
                    panier.setTotalPrix();
                }
                return panier;
            }
            return null;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void removeArticle(int articleId, int panierId) {
        String sql = "DELETE FROM cart_has_article" +
                "    WHERE cart_id = ?" +
                "    AND article_id = ?" +
                "    LIMIT 1;";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, Math.max(panierId, 0));
            ps.setInt(2, Math.max(articleId, 0));
            ps.executeQuery();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void truncate(int panierId) {
        String sql = "DELETE FROM cart_has_article" +
                "    WHERE cart_id = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, Math.max(panierId, 0));
            ps.executeQuery();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}