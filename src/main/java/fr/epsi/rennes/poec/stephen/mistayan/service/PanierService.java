package fr.epsi.rennes.poec.stephen.mistayan.service;

import fr.epsi.rennes.poec.stephen.mistayan.dao.PanierDAO;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Panier;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Pizza;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Author : Stephen Mistayan
 * Created on : 5/12/2022 : 11:24 AM:25
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.stephen.mistayan.service
 * Project name : pizzaHut
 **/

@Service
public class PanierService {

    private final PanierDAO panierDAO;

    @Autowired
    public PanierService(PanierDAO panierDAO) {this.panierDAO = panierDAO;}

    @Transactional
    public int addPizza(Pizza pizza, int panier_id) {
        //fonction pour ajouter pizza au panier.
        boolean exists = panierDAO.doesPanierExist(panier_id);
        if (!exists) {
            // vérifier que le panier existe avant d'en créer un
            panier_id = panierDAO.CreatePanier();
        }
        panierDAO.addPizza(pizza, panier_id);
        return panier_id;
    }

    public int remPizza(int pizza_id, int panier_id) {
        boolean exists = panierDAO.doesPanierExist(panier_id);
        // vérifie que le panier existe avant action
        if (!exists) {
            return -1;
        }
        panierDAO.removePizza(pizza_id, panier_id);
        return panier_id;
    }

    public Panier getPanierById(int panier_id) {
        /**
         * @return: panier_id.exists() ? panier : null
         */
        boolean exists = panierDAO.doesPanierExist(panier_id);
        // vérifie que le panier existe avant action
        if (!exists) {
            return null;
        }
        return panierDAO.getPanierById(panier_id);
    }
}
