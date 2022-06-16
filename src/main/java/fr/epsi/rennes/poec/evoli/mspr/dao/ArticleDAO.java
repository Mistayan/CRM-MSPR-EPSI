package fr.epsi.rennes.poec.evoli.mspr.dao;

import fr.epsi.rennes.poec.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.evoli.mspr.domain.ArticleCategory;
import fr.epsi.rennes.poec.evoli.mspr.domain.PokemonProperties;
import fr.epsi.rennes.poec.evoli.mspr.domain.PokemonStats;
import fr.epsi.rennes.poec.evoli.mspr.exception.TechnicalException;
import fr.epsi.rennes.poec.evoli.mspr.parsers.PokemonParser;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.time.LocalDateTime;
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
    private static final Logger logger = LogManager.getLogger(ArticleDAO.class);
    private final DataSource ds;

    @Autowired
    public ArticleDAO(DataSource ds) {this.ds = ds;}

    /**
     * Creates an article, properties ,
     *
     * @return articleId
     * @throws TechnicalException "could not insert article"
     */
    public int insertArticle(String label, double prix, int categoryId, String codeArticle, String description,
                             PokemonProperties properties, PokemonStats stats) throws TechnicalException {
        logger.debug("creating article :\n");
        String sql = "INSERT INTO article (label, prix, category_id, code_article, description, property_id) " +
                "values (?, ?, ?, ?, ?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, label);
            ps.setDouble(2, prix);
            ps.setInt(3, categoryId);
            ps.setString(4, codeArticle);
            ps.setString(5, description);
            int propId = this.insertArticleProperties(properties, stats);
            ps.setInt(6, propId);
            int ctrl = ps.executeUpdate();
            if (ctrl != 1) throw new SQLException("Error while inserting article : ");
            ResultSet rs = ps.getGeneratedKeys();
            conn.close();
            if (rs.next()) {
                int articleId = rs.getInt(1);
                this.insertArticleHasProperty(articleId, propId);
                return articleId;
            }
            conn.rollback();
        } catch (TechnicalException | SQLException e) {
            throw new TechnicalException(e);
        }
        return -1;
    }

    void insertArticleHasProperty(int aId, int pId) {
        String sql = "INSERT INTO article_has_props (article_id, property_id) VALUES (?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, aId);
            ps.setInt(2, pId);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                conn.rollback();
            }
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }

    private int insertArticleProperties(PokemonProperties prop, PokemonStats stats) throws TechnicalException {
        String sql = "insert into " +
                "pokemon_properties (type, taille, poids, Level, Exp, ATK, DEF, SPD, ATKSPE, DEFSPE, PV, PP)" +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, prop.getLabel());
            ps.setDouble(2, prop.getTaille());
            ps.setDouble(3, prop.getPoids());
            ps.setInt(4, prop.getLvl());
            ps.setInt(5, prop.getExp());
            ps.setInt(6, stats.getAtk());
            ps.setInt(7, stats.getDef());
            ps.setInt(8, stats.getSpd());
            ps.setInt(9, stats.getAtkspe());
            ps.setInt(10, stats.getDefspe());
            ps.setInt(11, stats.getPv());
            ps.setInt(12, stats.getPp());
            int check = ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
            conn.rollback();
            throw new SQLException("failed");
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }

    public List<Article> getAllPokemons() throws TechnicalException {
        String sql = "SELECT a.article_id as article_id, a.label as label, a.prix as prix," +
                " a.description as description, a.code_article as code_article, a.date_created as date," +
                " a.enabled as enabled, " +
                " GROUP_CONCAT(pokemon_properties.prop_id, ':', pokemon_properties.type," +         // properties
                " ':', pokemon_properties.taille, ':', pokemon_properties.poids," +
                " ':', pokemon_properties.Level, ':', pokemon_properties.Exp," +
                /*split -> */" '/', pokemon_properties.ATK, ':', pokemon_properties.DEF," +                      // props.stats
                " ':', pokemon_properties.SPD," +
                " ':', pokemon_properties.ATKSPE, ':', pokemon_properties.DEFSPE," +
                " ':', pokemon_properties.PV, ':', pokemon_properties.PP) as props," +
                " GROUP_CONCAT(category.category_id, ':', category.label, ':', category.taxes) as category" +                  // category
                " FROM article as a " +
                " RIGHT JOIN article_has_props ON article_has_props.article_id = a.article_id" +    // properties
                " LEFT JOIN pokemon_properties ON pokemon_properties.prop_id = a.property_id" +         //
                " LEFT JOIN category ON category.category_id = 1" +                                 // category 1 = pokemon
                " WHERE enabled is true" +
                " GROUP BY a.article_id" +
                " ;";

        try (Connection conn = ds.getConnection()) {
            ResultSet rs = conn.createStatement().executeQuery(sql);
            conn.close();
            PokemonParser parser = new PokemonParser();
            List<Article> articles = new ArrayList<>();
            while (rs.next()) {
                articles.add(parser.parsePokemon(rs));
            }
            return articles;
        } catch (TechnicalException | SQLException e) {
            throw new TechnicalException(e);
        }
    }

    public List<Article> getAllPokemonsAdmin() throws TechnicalException {
        String sql = "SELECT a.article_id as article_id, a.label as label, a.prix as prix," +
                " a.description as description, a.code_article as code_article, a.date_created as date," +
                " a.enabled as enabled, " +
                " GROUP_CONCAT(pokemon_properties.prop_id, ':', pokemon_properties.type," +         // properties
                " ':', pokemon_properties.taille, ':', pokemon_properties.poids," +
                " ':', pokemon_properties.Level, ':', pokemon_properties.Exp," +
                /*split -> */" '/', pokemon_properties.ATK, ':', pokemon_properties.DEF," +                      // props.stats
                " ':', pokemon_properties.SPD," +
                " ':', pokemon_properties.ATKSPE, ':', pokemon_properties.DEFSPE," +
                " ':', pokemon_properties.PV, ':', pokemon_properties.PP) as props," +
                " GROUP_CONCAT(category.category_id, ':', category.label, ':', category.taxes) as category" +                  // category
                " FROM article as a " +
                " RIGHT JOIN article_has_props ON article_has_props.article_id = a.article_id" +    // properties
                " LEFT JOIN pokemon_properties ON pokemon_properties.prop_id = a.property_id" +         //
                " LEFT JOIN category ON category.category_id = 1" +                                 // category 1 = pokemon
                " GROUP BY a.article_id" +
                " ;";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            conn.close();
            PokemonParser parser = new PokemonParser();
            List<Article> articles = new ArrayList<>();
            while (rs.next()) {
                switch (rs.getString("category").split(":")[0]) {
                    case "1": {
                        articles.add(parser.parsePokemon(rs));
//                    }
//                    case "2" :{
//                        //TBD
//                    }
//                    case "3" :{
//                        //TBD
//                    }
//                    case "4" :{
//                        //TBD
//                    }
//                    case "5" :{
//                        //TBD
                    }
                }
            }
            return articles;
        } catch (TechnicalException | SQLException e) {
            throw new TechnicalException(e);
        }
    }

    public List<ArticleCategory> getAllCategories() throws TechnicalException {
        String sql = "SELECT * FROM category ";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            conn.close();
            List<ArticleCategory> cats = new ArrayList<>();
            while (rs.next()) {
                ArticleCategory cat = new ArticleCategory();
                cat.setId(rs.getInt(1)); // id
                cat.setLabel(rs.getString(2)); // label
                cat.setTaxes(rs.getDouble(3)); // Taxes
                cats.add(cat);
            }
            return cats;
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }

    public boolean switchArticle(int id, boolean mode) {
        String sql = "UPDATE article SET enabled = ? WHERE article_id = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setBoolean(2, mode);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.first();
            }
            return false;
        } catch (SQLException e) {
            throw new TechnicalException(new SQLException(e));
        }
    }

    public boolean modifyArticle(Article article) {
        String sql = "UPDATE article SET " +
                "description = ?, " +       // desc : 1
                "prix = ?, " +              // prix : 2
                "label = ?, " +             // label : 3
                "last_modified = ? " +      // lm : 4
                "WHERE article_id = ?";     // aId : 5
        logger.warn("modifyArticle ::: %d\n%s\n%f\n%s"
                .formatted(article.getId(), article.getDescription(), article.getPrix(), article.getLabel()));
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            conn.setAutoCommit(false);
            ps.setString(1, "\'%s\'".formatted(article.getDescription()));
            ps.setDouble(2, article.getPrix());
            ps.setString(3, article.getLabel());
            ps.setString(4, String.valueOf(LocalDateTime.now()));
            ps.setInt(5, article.getId());
            int ctrl = ps.executeUpdate();
            if (ctrl == 1) {
                return this.updatePokemonProperties(conn, article);
            }
            logger.fatal("modifyArticle ::: rolling back (Error Value = %d)".formatted(ctrl));
            conn.rollback();
            return false;
        } catch (SQLException e) {
            throw new TechnicalException(new SQLException(e));
        }
    }

    private boolean updatePokemonProperties(Connection conn, Article article) throws TechnicalException {
        String sql = "UPDATE pokemon_properties SET " +
                "type = ?, " +
                "taille = ?, " +
                "poids = ?, " +
                "Level = ?, " +
                "Exp = ?, " +
                "PV = ?, " +
                "PP = ?, " +
                "ATK = ?, " +
                "DEF = ?, " +
                "SPD = ?, " +
                "ATKSPE = ?, " +
                "DEFSPE = ? " +
                "WHERE prop_id = ?";
        logger.warn("modifyPokemonProperties ::: ");
        PokemonProperties props = article.getProperties();

        PokemonStats stats = article.getStats();

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            int prop_id = this.getPropertyIdFromArticleId(article.getId());
            if (prop_id == -1) {
                logger.fatal("modifyPokemonProperties ::: rolling back");
                throw new TechnicalException(new SQLException(
                        "invalid connection between prop_id %d and article.prop_id %d"
                                .formatted(prop_id, article.getProperties().getId())));
            }
            ps.setString(1, props.getLabel());
            ps.setDouble(2, props.getTaille());
            ps.setDouble(3, props.getPoids());
            ps.setInt(4, props.getLvl());
            ps.setInt(5, props.getExp());
            ps.setInt(6, stats.getPv());
            ps.setInt(7, stats.getPp());
            ps.setInt(8, stats.getAtk());
            ps.setInt(9, stats.getDef());
            ps.setInt(10, stats.getSpd());
            ps.setInt(11, stats.getAtkspe());
            ps.setInt(12, stats.getDefspe());
            ps.setInt(13, prop_id);
            int ctrl = ps.executeUpdate();
            if (ctrl != 1) {
                logger.fatal("rolling Back on modifyPokemonProperties ");
                conn.rollback();
                return false;
            }
            conn.setAutoCommit(true);
            conn.commit();
            conn.close();
            return true;
        } catch (SQLException e) {
            throw new TechnicalException(new SQLException(e));
        }
    }

    public int getPropertyIdFromArticleId(int article_id) throws SQLException {
        String sql = "SELECT property_id FROM article WHERE article_id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, article_id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            conn.rollback();
            return -1;
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }

}