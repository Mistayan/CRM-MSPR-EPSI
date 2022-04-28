package fr.epsi.rennes.poec.group.evoli.mspr.controller;

import fr.epsi.rennes.poec.group.evoli.mspr.domain.Article;
import fr.epsi.rennes.poec.group.evoli.mspr.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    @GetMapping("/public/articles")
    public List<Article> getList() {
        return articleService.getList();
    }

    @PostMapping("/user/article")
    public void addArticle (@RequestBody Article article) {
        articleService.addArticle(article);
    }
}
