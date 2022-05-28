package fr.epsi.rennes.poec.evoli.mspr.service;

import fr.epsi.rennes.poec.evoli.mspr.dao.PanierDAO;
import fr.epsi.rennes.poec.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.evoli.mspr.domain.Panier;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static org.eclipse.jdt.internal.compiler.codegen.ConstantPool.GetClass;

/**
 * Author : Stephen Mistayan
 * Created on : 5/12/2022 : 11:24 AM:25
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.service
 * Project name : Evoli-Acme
 **/

@Service
public class PanierService {
    private static final Logger logger = LogManager.getLogger(GetClass);
    private final PanierDAO panierDAO;
    private final ArticleService articleService;

    @Autowired
    public PanierService(PanierDAO panierDAO, ArticleService articleService) {
        this.panierDAO = panierDAO;
        this.articleService = articleService;
    }

    public int addArticle(Article article, int panierId) {
        //fonction pour ajouter article au panier.
        boolean exists = panierDAO.doesPanierExist(panierId);
        if (!exists) {
            // vérifier que le panier existe avant d'en créer un
            panierId = panierDAO.CreatePanier();
        }
        panierDAO.addArticle(article, panierId);
        return panierId;
    }


    @Transactional
    public int remArticle(int articleId, int panierId) {
        boolean exists = panierDAO.doesPanierExist(panierId);
        // vérifie que le panier existe avant action
        if (!exists) {
            return -1;
        }
        panierDAO.removeArticle(articleId, panierId);
        return panierId;
    }

    @Transactional(readOnly = true)
    public Panier getPanierById(int panierId) {
        /**
         * @return: panierId.exists() ? panier : new Panier();
         */
        logger.info("getPanierById(" + panierId + ")");
        boolean exists = panierDAO.doesPanierExist(panierId);
        // vérifie que le panier existe avant action
        if (!exists) {
            panierId = panierDAO.CreatePanier();
        }
        logger.info("getPanierById ? " + exists + " : " + panierId);
        return panierDAO.getPanierById(panierId);
    }

}