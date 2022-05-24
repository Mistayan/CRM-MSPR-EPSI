package fr.epsi.rennes.poec.stephen.mistayan.Controller;

import fr.epsi.rennes.poec.stephen.mistayan.domain.Panier;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Pizza;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Response;
import fr.epsi.rennes.poec.stephen.mistayan.service.PanierService;
import fr.epsi.rennes.poec.stephen.mistayan.service.PizzaService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static org.eclipse.jdt.internal.compiler.codegen.ConstantPool.GetClass;

/**
 * Author: Stephen Mistayan
 * Created on : 5/4/2022 : 5:02 PM:51
 * IDE : IntelliJ IDEA
 * $
 **/

@RestController
public class IndexController {
    private static final Logger logger = LogManager.getLogger(GetClass);
    @Autowired
    private PizzaService pizzaService;
    @Autowired
    private PanierService panierService;

    @GetMapping("/public/pizza")
    public Response<List<Pizza>> getAllPizzasPublic() {
        List<Pizza> pizzas = pizzaService.getAllPizzas();
        Response<List<Pizza>> response = new Response<>();
        response.setData(pizzas);
        return response;
    }

    @PostMapping("/public/panier/pizza")
    public Response<Integer> actionPizza(
            @RequestParam int pizzaId,
            @RequestParam int panierId,
            @RequestParam int action) {
        Response<Integer> response = new Response<>();
        if (action == 1) {
            logger.info("##User Action :: /public/panier/pizza/? " + pizzaId + " & " + panierId + " & " + action);
            Pizza pizza = new Pizza();
            pizza.setId(pizzaId);
            panierId = panierService.addPizza(pizza, panierId);
        } else {
            panierId = panierService.remPizza(pizzaId, panierId);
        }
        response.setData(panierId);
        return response;
    }

    @GetMapping("/public/panier")
    public Response<Panier> getPanier(@RequestParam int panierId) {
        Panier panier = panierService.getPanierById(panierId);

        Response<Panier> response = new Response<>();
        response.setData(panier);
        return response;
    }
}