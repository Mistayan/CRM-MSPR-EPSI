package fr.epsi.rennes.poec.evoli.mspr.service;

import fr.epsi.rennes.poec.evoli.mspr.dao.PanierDAO;
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

    public int addArticle(int articleId, int panierId) {
        //fonction pour ajouter article au panier.
        Panier panier = panierDAO.doesPanierExist(panierId);
        if (panier.getId() == -1) {
            // vérifier que le panier existe avant action
            return -1;
        }
        panierDAO.addArticle(articleId, panierId);
        return panierId;
    }

    @Transactional
    public int remArticle(int articleId, int panierId) {
        Panier panier = panierDAO.doesPanierExist(panierId);
        // vérifie que le panier existe avant action
        if (panier.getId() == -1) {
            return -1;
        }
        panierDAO.removeArticle(articleId, panierId);
        return panier.getId();
    }

    @Transactional(readOnly = true)
    public Panier getPanierById(int panierId, int customerId) {
        /**
         * @return: panierId.panier() ? panier : new Panier();
         */
        logger.info("getPanierById(" + panierId + ")");
        Panier panier = panierDAO.doesPanierExist(panierId);
        // vérifie que le panier existe avant action
        if (panier.getId() == -1) {
            panierId = panierDAO.CreatePanier(customerId);
        }
        logger.info("getPanierById ? " + panier + " : " + panierId);
        return panierDAO.getPanierById(panierId);
    }

}
