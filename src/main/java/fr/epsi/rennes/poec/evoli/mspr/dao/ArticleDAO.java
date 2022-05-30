package fr.epsi.rennes.poec.evoli.mspr.dao;

import fr.epsi.rennes.poec.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.evoli.mspr.domain.PokemonProperties;
import fr.epsi.rennes.poec.evoli.mspr.domain.PokemonStats;
import fr.epsi.rennes.poec.evoli.mspr.exception.TechnicalException;
import org.intellij.lang.annotations.Language;
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
     * List<PokemonProperties> ingredients;
     * double prix;
     * int nb_calories;
     *
     * @throws TechnicalException
     */

    public int createArticle(String label, double prix, ArticleCategory category, String codeArticle, String description,
                             PokemonProperties properties) throws TechnicalException {
        final DecimalFormat df = new DecimalFormat("0.00");
        String sql = "INSERT INTO article (label, prix, category_id, code_article, description) values (?, ?, ?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, label);
            ps.setDouble(2, Double.parseDouble(df.format(prix))); // transformation double au format 0.00
            ps.setInt(3, category.getId());
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

    public List<Article> getAllPokemons() throws TechnicalException {
        @Language("SQL")
        //todo URGENT: split prop.type et prop.label to new tables for SQL enumeration
        String sql = "SELECT a.article_id as article_id, a.label as label, a.prix as prix," +
                " a.description as description, a.code_article as code_article, a.date_created as date," +
                " GROUP_CONCAT(pokemon_properties.prop_id, ':', pokemon_properties.type," +         // properties
                " ':', pokemon_properties.taille, ':', pokemon_properties.poids," +
                " ':', pokemon_properties.Level, ':', pokemon_properties.Exp," +
                /*split n°0-> */" '/', pokemon_properties.ATK, ':', pokemon_properties.DEF," +                      // props.stats
                " ':', pokemon_properties.SPD," +
                " ':', pokemon_properties.ATKSPE, ':', pokemon_properties.DEFSPE," +
                " ':', pokemon_properties.PV, ':', pokemon_properties.PP) as props," +
                " GROUP_CONCAT(category.category_id, ':', category.label, ':', category.taxes) as category" +                  // category
                " FROM article as a " +
                " RIGHT JOIN article_has_props ON article_has_props.article_id = a.article_id" +    // properties
                " LEFT JOIN pokemon_properties ON pokemon_properties.prop_id = a.property_id" +         //
                " LEFT JOIN category ON category.category_id = 1" +                                 // category 1 = pokemons
                " GROUP BY a.article_id;";

        List<Article> articles = new ArrayList<>();
        try (Connection conn = ds.getConnection()) {
            ResultSet rs = conn.createStatement().executeQuery(sql);
            conn.close();
            while (rs.next()) {
                Article article = new Article();                                    //Article
                article.setId(rs.getInt("article_id"));
                article.setCodeArticle(rs.getString("code_article"));
                article.setLabel(rs.getString("label"));
                article.setPrix(rs.getDouble("prix"));
                article.setDateCreated(rs.getString("date"));
                article.setDescription(rs.getString("description"));
                ArticleCategory cat = new ArticleCategory();                      // category
                String[] cats = rs.getString("category").split(":");
                // style : id:label:taxe
                cat.setId(Integer.parseInt(cats[0]));
                cat.setLabel(cats[1]);
                cat.setTaxes(Double.parseDouble(cats[2]));
                article.setCategory(cat);
                String[] splitted = rs.getString("props").split("/");   // separation props/stats
                PokemonProperties props = new PokemonProperties(splitted[0]);   // Properties
                PokemonStats stats = new PokemonStats(splitted[1]);             // props.stats
                props.setStats(stats);                      // adding stats to properties
                article.setProperties(props);               // adding properties to article
                articles.add(article);                      // adding article to the return list
                // NEXT ?
            }
            return articles;
        } catch (TechnicalException | SQLException e) {
            throw new TechnicalException(e);
        }
    }
}