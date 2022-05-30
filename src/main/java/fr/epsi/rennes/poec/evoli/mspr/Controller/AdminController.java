package fr.epsi.rennes.poec.evoli.mspr.Controller;

import fr.epsi.rennes.poec.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.evoli.mspr.domain.PokemonProperties;
import fr.epsi.rennes.poec.evoli.mspr.domain.Response;
import fr.epsi.rennes.poec.evoli.mspr.exception.BusinessException;
import fr.epsi.rennes.poec.evoli.mspr.service.ArticleService;
import fr.epsi.rennes.poec.evoli.mspr.service.PropertiesService;
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

    private final ArticleService articleService;
    private final PropertiesService propertiesService;
    private final Logger logger;

    @Autowired
    public AdminController(ArticleService articleService, PropertiesService propertiesService, Logger logger) {
        this.articleService = articleService;
        this.propertiesService = propertiesService;
        this.logger = logger;
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

}