package fr.epsi.rennes.poec.stephen.mistayan.service;

import fr.epsi.rennes.poec.stephen.mistayan.dao.PanierDAO;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Panier;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Pizza;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import static org.eclipse.jdt.internal.compiler.codegen.ConstantPool.GetClass;

/**
 * Author : Stephen Mistayan
 * Created on : 5/12/2022 : 11:24 AM:25
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.stephen.mistayan.service
 * Project name : pizzaHut
 **/

@Service
public class PanierService {
    private static final Logger logger = LogManager.getLogger(GetClass);
    private final PanierDAO panierDAO;
    private final PizzaService pizzaService;

    @Autowired
    public PanierService(PanierDAO panierDAO, PizzaService pizzaService) {
        this.panierDAO = panierDAO;
        this.pizzaService = pizzaService;
    }

    public int addPizza(Pizza pizza, int panierId) {
        //fonction pour ajouter pizza au panier.
        boolean exists = panierDAO.doesPanierExist(panierId);
        if (!exists) {
            // vérifier que le panier existe avant d'en créer un
            panierId = panierDAO.CreatePanier();
        }
        panierDAO.addPizza(pizza, panierId);
        return panierId;
    }

    public int remPizza(int pizza_id, int panierId) {
        boolean exists = panierDAO.doesPanierExist(panierId);
        // vérifie que le panier existe avant action
        if (!exists) {
            return -1;
        }
        panierDAO.removePizza(pizza_id, panierId);
        return panierId;
    }

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
