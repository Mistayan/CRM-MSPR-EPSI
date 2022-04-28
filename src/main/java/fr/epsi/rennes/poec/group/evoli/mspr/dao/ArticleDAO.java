package fr.epsi.rennes.poec.group.evoli.mspr.dao;

import fr.epsi.rennes.poec.group.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.group.evoli.mspr.exception.TechnicalException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@Repository
public class ArticleDAO {

    @Autowired
    private DataSource ds;

    public DataSource getDs() {
        return this.ds;
    }

    public List<Article> getList() throws SQLException {
        List<Article> list = new ArrayList<>();

        String sqlSelect = "Select id, label, code FROM articles";
        try (Statement stmt = ds.getConnection().createStatement();
             ResultSet rs = stmt.executeQuery(sqlSelect)) {
            while (rs.next()) {
                Article article = new Article();
                article.setId(rs.getInt(1));
                article.setLabel(rs.getString(2));
                article.setCode(rs.getString(3));
                list.add(article);
            }
        } catch (SQLException e) {
            throw new SQLException(e);
        }

        return list;
    }

    public void addArticle(Article article) throws SQLException {

        String sql = "INSERT INTO articles (code, label) VALUES ('" +
                article.getCode() + "', '" + article.getLabel() + "');";
        try (Statement stmt = ds.getConnection().createStatement()){
            stmt.executeUpdate(sql);
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }
}
