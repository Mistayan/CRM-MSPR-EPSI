package fr.epsi.rennes.poec.stephen.mistayan.service;

import fr.epsi.rennes.poec.stephen.mistayan.dao.IngredientDAO;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Ingredient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Author : Stephen Mistayan
 * Created on : 5/10/2022 : 2:02 PM:56
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.stephen.mistayan.service
 * Project name : pizzaHut
 **/

@Service
public class IngredientService {
    @Autowired
    private IngredientDAO ingredientDAO;

    public List<Ingredient> getAllIngredients() {
        return ingredientDAO.getAllIngredients();
    }
}
