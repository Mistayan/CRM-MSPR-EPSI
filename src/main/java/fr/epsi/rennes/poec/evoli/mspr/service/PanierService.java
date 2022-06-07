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

    @Autowired
    public PanierService(PanierDAO panierDAO) {
        this.panierDAO = panierDAO;
    }

    public int addArticle(int articleId, int panierId) {
        logger.info("adding article %d to panier %d".formatted(articleId, panierId));
        panierDAO.addArticle(articleId, panierId);
        return panierId;
    }


    @Transactional
    public int remArticle(int articleId, int panierId) {
        logger.info("removing article %d from panier %d".formatted(articleId, panierId));
        panierDAO.removeArticle(articleId, panierId);
        return panierId;
    }

    @Transactional(readOnly = true)
    public Panier getPanierByCustomerId(int customerId) {
        logger.debug("getPanierByCustomerId(" + customerId + ")");
        // vérifie que le newPanier existe avant action
        Panier newPanier = panierDAO.doesPanierExist(customerId);
        int panierId = newPanier.getId();
        if (panierId == -1) {
            logger.info("createPanier(" + customerId + ")");
             panierId = panierDAO.CreatePanier(customerId);
        }
        logger.debug("getPanierById ? " + newPanier + " : " + panierId);
        Panier testPanier = panierDAO.getPanierById(panierId);
        return testPanier.getId() > 1? testPanier : newPanier; // Afin d'eviter un pannier de type erroné
    }
}
