package fr.epsi.rennes.poec.stephen.mistayan.Controller;

import fr.epsi.rennes.poec.stephen.mistayan.domain.Panier;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Pizza;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Response;
import fr.epsi.rennes.poec.stephen.mistayan.service.PanierService;
import fr.epsi.rennes.poec.stephen.mistayan.service.PizzaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Author: Stephen Mistayan
 * Created on : 5/4/2022 : 5:02 PM:51
 * IDE : IntelliJ IDEA
 * $
 **/

@RestController
public class IndexController {
    @Autowired
    private PizzaService pizzaService;
    @Autowired
    private PanierService panierService;

//    @GetMapping("/user/pizza")
//    public Response<List<Pizza>> getAllPizzas() {
//        List<Pizza> pizzas = pizzaService.getAllPizzas();
//        Response<List<Pizza>> response = new Response<>();
//        response.setData(pizzas);
//        return response;
//    }

    @GetMapping("/public/pizza")
    public Response<List<Pizza>> getAllPizzasPublic() {
        List<Pizza> pizzas = pizzaService.getAllPizzas();
        Response<List<Pizza>> response = new Response<>();
        response.setData(pizzas);
        return response;
    }

    @PostMapping("/public/panier/pizza")
    public Response<Integer> actionPizza(
            @RequestParam int pizza_id,
            @RequestParam int panier_id,
            @RequestParam int action) {
        Response<Integer> response = new Response<>();
        if (action == 1) {
            Pizza pizza = new Pizza();
            pizza.setId(pizza_id);
            panier_id = panierService.addPizza(pizza, panier_id);
        } else { //pizza_id + 1 car index commence à 0 en json
            panier_id = panierService.remPizza(pizza_id, panier_id);
        }
        response.setData(panier_id);
        return response;
    }

    @GetMapping("/public/panier")
    public Response<Panier> getPanier(@RequestParam int panier_id) {
        Panier panier = panierService.getPanierById(panier_id);

        Response<Panier> response = new Response<>();
        response.setData(panier);
        return response;
    }
}