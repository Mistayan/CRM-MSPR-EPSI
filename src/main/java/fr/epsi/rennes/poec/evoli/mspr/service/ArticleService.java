package fr.epsi.rennes.poec.evoli.mspr.service;

import fr.epsi.rennes.poec.evoli.mspr.dao.ArticleCategory;
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
    public void createArticle(Article newArticle) throws BusinessException {
        if (newArticle.getLabel() == null) {
            throw new BusinessException("article.label.null");
        }
        int articleId = this.articleDAO.insertArticle(newArticle.getLabel(), newArticle.getPrix(),
                newArticle.getCategory().getId(), newArticle.getCodeArticle(),
                newArticle.getDescription(), newArticle.getProperties(), newArticle.getStats());
        if (articleId == -1) {
            throw new BusinessException("createArticle ::: Something went wrong, could not add");
        }
    }
    @Transactional(readOnly = true)
    public List<Article> getAllPokemons() {
        return articleDAO.getAllPokemons();
    }
    @Transactional(readOnly = true)
    public List<ArticleCategory> getAllCategories() {
        return articleDAO.getAllCategories();
    }
    @Transactional
    public void removeArticle(int id) throws BusinessException {
        if (!articleDAO.disableArticle(id))
            throw new BusinessException("removeArticle ::: Something went wrong, could not modify enabled status");
    }
    @Transactional
    public void modifyArticle(Article newArticle) throws BusinessException {
        if (!articleDAO.modifyArticle(newArticle)) {
            throw new BusinessException("modifyArticle ::: Something went wrong, could not modify article");
        }
    }
}
