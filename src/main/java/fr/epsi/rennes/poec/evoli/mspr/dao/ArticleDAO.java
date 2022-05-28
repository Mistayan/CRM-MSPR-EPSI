package fr.epsi.rennes.poec.evoli.mspr.dao;

import fr.epsi.rennes.poec.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.evoli.mspr.exception.TechnicalException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * Author: Stephen Mistayan
 * Created on : 5/5/2022 : 12:30 AM:11
 * IDE : IntelliJ IDEA
 * $
 **/
@Repository
public class ArticleDAO {
    private final DataSource ds;

    @Autowired
    public ArticleDAO(DataSource ds) {this.ds = ds;}

    /**
     * int id;
     * String label;
     * List<Property> ingredients;
     * double prix;
     * int nb_calories;
     *
     * @throws TechnicalException
     */

    public int createArticle(String label, double prix, int categoryId, String codeArticle, String description) throws TechnicalException {
        final DecimalFormat df = new DecimalFormat("0.00");
        String sql = "INSERT INTO article (label, prix, category_id, code_article, description) values (?, ?, ?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, label);
            ps.setDouble(2, Double.parseDouble(df.format(prix))); // transformation double au format 0.00
            ps.setInt(3, categoryId);
            ps.setString(4, codeArticle);
            ps.setString(5, "'" + description + "'");
            int ctrl = ps.executeUpdate();
            if (ctrl != 1) throw new SQLException("Error while inserting article");
            ResultSet rs = ps.getGeneratedKeys();
            conn.close();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (TechnicalException | SQLException e) {
            throw new TechnicalException(e);
        }
        return -1;
    }

    // 	id 	label 	prix    nb_calories
    public List<Article> getAll() throws TechnicalException {
        String sql = "SELECT * "
                + "FROM article, category " +
                "where article.category_id = category.category_id";
        List<Article> articles = new ArrayList<>();
        try (Connection conn = ds.getConnection()) {
            ResultSet rs = conn.createStatement().executeQuery(sql);
            conn.close();
            while (rs.next()) {
                Article article = new Article();
                article.setId(rs.getInt("article_id"));
                article.setCodeArticle(rs.getString("code_article"));
                article.setLabel(rs.getString("label"));
                article.setPrix(rs.getDouble("prix"));
                article.setDateCreated(rs.getString("date_created"));
                article.setDescription(rs.getString("description"));
                article.setCategory(rs.getString("category.label"));
                article.setCategoryId(rs.getInt("article.category_id"));
                articles.add(article);
            }
            return articles;
            //if (ctrl != 1) throw new BusinessException(e);
        } catch (TechnicalException | SQLException e) {
            throw new TechnicalException(e);
        }
    }
}