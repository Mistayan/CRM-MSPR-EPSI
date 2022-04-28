package fr.epsi.rennes.poec.group.evoli.mspr.service;

import fr.epsi.rennes.poec.group.evoli.mspr.dao.ArticleDAO;
import fr.epsi.rennes.poec.group.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.group.evoli.mspr.exception.TechnicalException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;


import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@Service
public class ArticleService {

    private static final Logger logger = LogManager.getLogger(Article.class.getName());

    @Autowired
    private ArticleDAO dao;


    public List<Article> getList() {
        try {
            return dao.getList();
        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
            throw new TechnicalException(e);
        }
    }


    public void addArticle(Article article) {
        try {
            dao.addArticle(article);
        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
            throw new TechnicalException(e);
        }
    }

}
