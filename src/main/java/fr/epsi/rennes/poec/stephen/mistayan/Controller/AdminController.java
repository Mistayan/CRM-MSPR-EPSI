package fr.epsi.rennes.poec.stephen.mistayan.Controller;

import fr.epsi.rennes.poec.stephen.mistayan.domain.Ingredient;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Pizza;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Response;
import fr.epsi.rennes.poec.stephen.mistayan.exception.BusinessException;
import fr.epsi.rennes.poec.stephen.mistayan.service.IngredientService;
import fr.epsi.rennes.poec.stephen.mistayan.service.PizzaService;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Author: Stephen Mistayan
 * Created on : 5/8/2022 : 1:34 PM:20
 * IDE : IntelliJ IDEA
 * $
 **/

@RestController
public class AdminController {

    @Autowired
    private PizzaService pizzaService;
    @Autowired
    private IngredientService ingredientService;
    @Autowired
    private Logger logger;

    @GetMapping("/admin/ingredients")
    public Response<List<Ingredient>> getAllIngredients() {
        List<Ingredient> ingredients = ingredientService.getAllIngredients();
        for (Ingredient ingredient : ingredients) {
            logger.debug(ingredient.getLabel());
        }

        Response<List<Ingredient>> response = new Response<>();
        response.setData(ingredients);
        return response;
    }

    @GetMapping("/admin/pizza")
    public Response<List<Pizza>> getAllPizzas() {
        List<Pizza> pizzas = pizzaService.getAllPizzas();

        Response<List<Pizza>> response = new Response<>();
        response.setData(pizzas);

        return response;
    }

    @PostMapping("/admin/pizza/ingredient")
    public Response<Void> addIngredient(@RequestBody Pizza pizza) throws BusinessException {
        List<Ingredient> listeI = pizza.getIngredients();

        for (Ingredient ingredient : listeI) {
            pizzaService.addIngredientToPizza(pizza.getId(), ingredient.getId());
        }

        return new Response<>();
    }

    @PostMapping("/admin/pizza/new_pizza")
    public Response<Void> newPizza(@RequestBody Pizza pizza) throws BusinessException {
        if (pizza == null) {
            throw new BusinessException("createpizza.param.null");
        }
        pizzaService.createPizza(pizza);
        return new Response<>();
    }

}