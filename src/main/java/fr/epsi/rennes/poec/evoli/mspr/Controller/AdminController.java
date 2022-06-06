package fr.epsi.rennes.poec.evoli.mspr.Controller;

import fr.epsi.rennes.poec.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.evoli.mspr.domain.PokemonProperties;
import fr.epsi.rennes.poec.evoli.mspr.domain.Response;
import fr.epsi.rennes.poec.evoli.mspr.domain.User;
import fr.epsi.rennes.poec.evoli.mspr.exception.BusinessException;
import fr.epsi.rennes.poec.evoli.mspr.exception.TechnicalException;
import fr.epsi.rennes.poec.evoli.mspr.service.ArticleService;
import fr.epsi.rennes.poec.evoli.mspr.service.PropertiesService;
import fr.epsi.rennes.poec.evoli.mspr.service.UserService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Author: Stephen Mistayan
 * Created on : 5/8/2022 : 1:34 PM:20
 * IDE : IntelliJ IDEA
 * $
 **/

@RestController
public class AdminController {
private static final Logger logger = LogManager.getLogger(AdminController.class);
    private final ArticleService articleService;
    private final PropertiesService propertiesService;
    private final UserService userService;

    @Autowired
    public AdminController(ArticleService articleService, PropertiesService propertiesService, UserService userService) {
        this.articleService = articleService;
        this.propertiesService = propertiesService;
        this.userService = userService;
    }

    @GetMapping("/admin/properties")
    public Response<List<PokemonProperties>> getAllProperties() {
        List<PokemonProperties> properties = propertiesService.getAllPokemonsProperties();
        for (PokemonProperties PokemonProperties : properties) {
            logger.debug(PokemonProperties.getLabel()); //should filter every strings
        }

        Response<List<PokemonProperties>> response = new Response<>();
        response.setData(properties);
        return response;
    }

    @GetMapping("/admin/article")
    public Response<List<Article>> getAllArticles() {
        List<Article> articles = articleService.getAllPokemons();

        Response<List<Article>> response = new Response<>();
        response.setData(articles);

        return response;
    }

    @PostMapping("/admin/article/new_article")
    public Response<Void> newArticle(@RequestBody Article article) throws BusinessException {
        if (article == null) {
            throw new BusinessException("newArticle.param.null");
        }
        articleService.createArticle(article);
        return new Response<>();
    }

    @PostMapping("/admin/register")
    public void addUser(@RequestBody User user){
        String uName = SecurityContextHolder.getContext().getAuthentication().getName();
        logger.info("userName " + uName + " ajoute un user");

        try {
            //
            logger.debug(user);
            userService.addUser(user);
        } catch (TechnicalException e){
            throw new RuntimeException("admin/register route user.service.addUser failed");
        }
    }

}