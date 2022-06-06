package fr.epsi.rennes.poec.evoli.mspr.Controller;

import fr.epsi.rennes.poec.evoli.mspr.dao.ArticleCategory;
import fr.epsi.rennes.poec.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.evoli.mspr.domain.PokemonProperties;
import fr.epsi.rennes.poec.evoli.mspr.domain.Response;
import fr.epsi.rennes.poec.evoli.mspr.exception.BusinessException;
import fr.epsi.rennes.poec.evoli.mspr.service.ArticleService;
import fr.epsi.rennes.poec.evoli.mspr.service.PropertiesService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
    private static final Logger logger = LogManager.getLogger(AdminController.class);
    private final ArticleService articleService;
    private final PropertiesService propertiesService;

    @Autowired
    public AdminController(ArticleService articleService, PropertiesService propertiesService) {
        this.articleService = articleService;
        this.propertiesService = propertiesService;
    }

//    @GetMapping("/admin/properties")
//    public Response<List<PokemonProperties>> getAllProperties() {
//        List<PokemonProperties> properties = propertiesService.getAllPokemonsProperties();
//        for (PokemonProperties PokemonProperties : properties) {
//            logger.debug(PokemonProperties.getLabel()); //should filter every strings
//        }
//
//        Response<List<PokemonProperties>> response = new Response<>();
//        response.setData(properties);
//        return response;
//    }

    @GetMapping("/admin/article")
    public Response<List<Article>> getAllArticles() {
        List<Article> articles = articleService.getAllPokemons();

        Response<List<Article>> response = new Response<>();
        response.setData(articles);

        return response;
    }

    @PostMapping("/admin/article/new")
    public Response<Void> newArticle(@RequestBody Article newArticle) throws BusinessException {
        if (newArticle == null) {
            throw new BusinessException("newArticle.param.null");
        }
        articleService.createArticle(newArticle);
        Response<Void> ret = new Response<>();
        ret.setSuccess(true);
        return ret;
    }

    @GetMapping("/admin/categories")
    public Response<List<ArticleCategory>> getArticlesCategories() throws BusinessException {
        Response<List<ArticleCategory>> response = new Response<>();
        List<ArticleCategory> categories = articleService.getAllCategories();
        if (categories == null) {
            response.setSuccess(false);
            throw new BusinessException("getArticlesService : : : could not retrieve categories");
        }
        response.setData(categories);
        response.setSuccess(true);
        return response;
    }

    @PostMapping("/admin/article/disable")
    public Response<Void> removeArticle(@RequestBody Article newArticle) throws BusinessException {
        if (newArticle == null) {
            throw new BusinessException("newArticle.param.null");
        }
        articleService.removeArticle(newArticle.getId());
        Response<Void> ret = new Response<>();
        ret.setSuccess(true);
        return ret;
    }

    @PostMapping("/admin/article/modify")
    public Response<Void> modifyArticle(@RequestBody Article newArticle) throws BusinessException {
        Response<Void> ret = new Response<>();
        if (newArticle == null) {
            throw new BusinessException("newArticle.param.null");
        }
        logger.trace("Admin/article/modify");
        try {
            articleService.modifyArticle(newArticle);
            ret.setSuccess(true);
        } catch (BusinessException e) {
            ret.setSuccess(false);
            throw new BusinessException("newArticle.modify.failed");
        }
        return ret;
    }
}