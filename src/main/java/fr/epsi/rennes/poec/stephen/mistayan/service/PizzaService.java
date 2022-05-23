package fr.epsi.rennes.poec.stephen.mistayan.service;

import fr.epsi.rennes.poec.stephen.mistayan.dao.pizzaDAO;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Ingredient;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Pizza;
import fr.epsi.rennes.poec.stephen.mistayan.exception.BusinessException;
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
 * Original package : fr.epsi.rennes.poec.stephen.mistayan.service
 * Project name : pizzaHut
 **/

@Service
@Repository
public class PizzaService {
    private static final Logger logger = LogManager.getLogger(PizzaService.class);

    @Autowired
    private pizzaDAO pizzadao;

    @Transactional
    public void createPizza(Pizza pizza) throws BusinessException {
        if (pizza.getLabel() == null) {
            throw new BusinessException("pizza.label.null");
        }
        for (Ingredient ingredient : pizza.getIngredients()) {

        }
        if (pizza.getIngredients() == null || pizza.getIngredients().size() < 3) {
            throw new BusinessException("pizza.ingredients.invalides");
        }
        int pizzaId = pizzadao.createPizza(pizza.getLabel());
        for (int i = 0; i < pizza.getIngredients().size(); i++) {
            int ingredientId = pizza.getIngredients().get(i).getId();
            pizzadao.addIngredientToPizza(pizzaId, ingredientId);
        }
    }

    public void addIngredientToPizza(int pizzaId, int ingredientsId) throws BusinessException {
        if (pizzaId < 0 || ingredientsId < 0) {
            throw new BusinessException("addingredient.value.invalid");
        }
        pizzadao.addIngredientToPizza(pizzaId, ingredientsId);
    }

    public List<Pizza> getAllPizzas() {
        return pizzadao.getAll();

    }


}
