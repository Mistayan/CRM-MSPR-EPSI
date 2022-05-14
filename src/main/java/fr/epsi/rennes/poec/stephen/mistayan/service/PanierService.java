package fr.epsi.rennes.poec.stephen.mistayan.service;

import fr.epsi.rennes.poec.stephen.mistayan.dao.PanierDAO;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Panier;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Pizza;
import org.springframework.stereotype.Service;

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

    public PanierService(PanierDAO panierDAO) {this.panierDAO = panierDAO;}

    public int addPizza(Pizza pizza, int panier_id) {
        //fonction pour ajouter pizza au panier.
        boolean exists = panierDAO.doesPanierExist(panier_id);
        if (!exists) {
            // vérifie que le panier existe avant d'en créer un
            panier_id = panierDAO.CreatePanier();
        }
        panierDAO.addPizza(pizza, panier_id);
        return panier_id;
    }

    public int remPizza(int pizza_id, int panier_id) {
        /**
         * Supprimer une pizza du panier
         * @Return: l'id du panier affecté (-1 si erreur)
         */
        boolean exists = panierDAO.doesPanierExist(panier_id);
        // vérifie que le panier existe avant action
        if (!exists) {
            return -1;
        }
        panierDAO.removePizza(pizza_id, panier_id);
        return panier_id;
    }

    public Panier getPanierById(int panierId) {
        return panierDAO.getPanierById(panierId);
    }
}
