package fr.epsi.rennes.poec.evoli.mspr.service;

import fr.epsi.rennes.poec.evoli.mspr.dao.ArticleDAO;
import fr.epsi.rennes.poec.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.evoli.mspr.exception.BusinessException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Author : Stephen Mistayan
 * Created on : 5/9/2022 : 10:57 PM:39
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.service
 * Project name : Evoli-Acme
 **/

@Service
@Repository
public class ArticleService {
    private static final Logger logger = LogManager.getLogger(ArticleService.class);

    private final ArticleDAO articleDAO;

    @Autowired
    public ArticleService(ArticleDAO articleDAO) {this.articleDAO = articleDAO;}

    @Transactional
    public void createArticle(Article article) throws BusinessException {
        if (article.getLabel() == null) {
            throw new BusinessException("article.label.null");
        }
        int articleId = this.articleDAO.createArticle(article.getLabel(), article.getPrix(),
                article.getCategoryId(), article.getCodeArticle(), article.getDescription());

    }

    @Transactional(readOnly = true)
    public List<Article> getAllArticles() {
        return articleDAO.getAll();
    }


}
