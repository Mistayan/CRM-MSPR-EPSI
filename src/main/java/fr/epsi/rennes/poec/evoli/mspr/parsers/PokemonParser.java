package fr.epsi.rennes.poec.evoli.mspr.parsers;

import fr.epsi.rennes.poec.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.evoli.mspr.domain.ArticleCategory;
import fr.epsi.rennes.poec.evoli.mspr.domain.PokemonProperties;
import fr.epsi.rennes.poec.evoli.mspr.domain.PokemonStats;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Author : Stephen Mistayan
 * Created on : 6/11/2022 : 11:43 PM:57
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.parsers
 * Project name : acme MSPR
 **/

public class PokemonParser {
    public Article parsePokemon(ResultSet rs) throws SQLException {
        try {
            Article article = new Article();                                    //Article
            if (rs != null) {
                article.setId(rs.getInt("article_id"));
                article.setCodeArticle(rs.getString("code_article"));
                article.setLabel(rs.getString("label"));
                article.setPrix(rs.getDouble("prix"));
                article.setDateCreated(rs.getString("date"));
                article.setDescription(rs.getString("description"));
                article.setStatus(rs.getBoolean("enabled"));
                ArticleCategory cat = new ArticleCategory();                      // category
                // style : id:label:taxe
                String[] cats = rs.getString("category").split(":");
                cat.setId(Integer.parseInt(cats[0]));
                cat.setLabel(cats[1]);
                cat.setTaxes(Double.parseDouble(cats[2]));
                article.setCategory(cat);
                String[] splitted = rs.getString("props").split("/");   // separation props/stats
                PokemonProperties props = new PokemonProperties(splitted[0]);   // Properties
                PokemonStats stats = new PokemonStats(splitted[1]);             // stats
                article.setStats(stats);                      // adding stats to articlePokemon
                article.setProperties(props);               // adding properties to articlePokemon
            }
            return article;
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }
}