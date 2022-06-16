package fr.epsi.rennes.poec.evoli.mspr.Controller;

import fr.epsi.rennes.poec.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.evoli.mspr.domain.Customer;
import fr.epsi.rennes.poec.evoli.mspr.domain.Panier;
import fr.epsi.rennes.poec.evoli.mspr.domain.Response;
import fr.epsi.rennes.poec.evoli.mspr.service.ArticleService;
import fr.epsi.rennes.poec.evoli.mspr.service.CustomerService;
import fr.epsi.rennes.poec.evoli.mspr.service.PanierService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
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
    private static final Logger logger = LogManager.getLogger(IndexController.class);
    private final ArticleService articleService;
    private final PanierService panierService;
    private final CustomerService customerService;

    @Autowired
    public IndexController(ArticleService articleService, PanierService panierService, CustomerService customerService) {
        this.articleService = articleService;
        this.panierService = panierService;
        this.customerService = customerService;
    }


    @GetMapping("/public/article")
    public Response<List<Article>> getAllArticles() {
        List<Article> articles = articleService.getAllPokemons();
        Response<List<Article>> response = new Response<>();
        response.setData(articles);
        return response;
    }

    @PostMapping("/user/panier/article")
    public Response<Integer> actionArticle(
            @RequestParam int panierId,
            @RequestParam int articleId,
            @RequestParam int action) {
        Response<Integer> response = new Response<>();
        String uac = "User Action !!! :";
        if (panierId > 0) {
            uac += "%s panierId=%d".formatted(uac, panierId);
            if (action == 1) {
                uac += "adding article %d".formatted(articleId);
                panierId = panierService.addArticle(articleId, panierId);
            } else {
                uac += "removing article %d".formatted(articleId);
                panierId = panierService.remArticle(articleId, panierId);
            }
            logger.debug(uac);
            response.setSuccess(true);
        } else {
            logger.debug("no such cart %d".formatted(panierId));
            response.setSuccess(false);
        }
        logger.debug("return value %d".formatted(panierId));
        response.setData(panierId);
        return response;
    }

    @GetMapping("/user/panier")
    public Response<Panier> getPanierbyCustomerId(@RequestParam int customerId) {
        Response<Panier> response = new Response<>();
        Panier newPanier = panierService.getPanierByCustomerId(customerId);

        response.setData(newPanier);
        return response;
    }

    @GetMapping("/customer/customers")
    public Response<List<Customer>> getCustomers() {
        List<Customer> customers = customerService.getAllCustomersPublic();
        Response<List<Customer>> response = new Response<>();

        response.setData(customers);
        return response;
    }
}