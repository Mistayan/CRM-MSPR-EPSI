package fr.epsi.rennes.poec.evoli.mspr.Controller;

import fr.epsi.rennes.poec.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.evoli.mspr.domain.Panier;
import fr.epsi.rennes.poec.evoli.mspr.domain.Response;
import fr.epsi.rennes.poec.evoli.mspr.service.ArticleService;
import fr.epsi.rennes.poec.evoli.mspr.service.PanierService;
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
    private final ArticleService articleService;
    private final PanierService panierService;

    @Autowired
    public IndexController(ArticleService articleService, PanierService panierService) {
        this.articleService = articleService;
        this.panierService = panierService;
    }


    @GetMapping("/public/article")
    public Response<List<Article>> getAllArticles() {
        List<Article> articles = articleService.getAllArticles();
        Response<List<Article>> response = new Response<>();
        response.setData(articles);
        return response;
    }

    @PostMapping("/public/panier/article")
    public Response<Integer> actionArticle(
            @RequestParam int articleId,
            @RequestParam int panierId,
            @RequestParam int action) {
        Response<Integer> response = new Response<>();
        logger.info("##User Action :: /public/panier/article/? " + articleId + " & " + panierId + " & " + action);
        if (action == 1) {
            Article article = new Article();
            article.setId(articleId);
            panierId = panierService.addArticle(article, panierId);
        } else {
            panierId = panierService.remArticle(articleId, panierId);
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