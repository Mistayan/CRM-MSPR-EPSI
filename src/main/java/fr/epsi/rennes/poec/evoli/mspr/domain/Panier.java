package fr.epsi.rennes.poec.evoli.mspr.domain;

import java.util.List;

/**
 * Author : Stephen Mistayan
 * Created on : 5/10/2022 : 9:24 AM:23
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.domain
 * Project name : Evoli-Acme
 **/

public class Panier {

    private int panierId;
    private List<Article> articles;
    private double totalPrix;

    public int getId() {
        return panierId;
    }

    public void setId(int id) {
        this.panierId = id;
    }

    public List<Article> getArticles() {
        return articles;
    }

    public void setArticles(List<Article> articles) {
        this.articles = articles;
    }

    public double getTotalPrix() {
        return totalPrix;
    }

    public void setTotalPrix() {
        totalPrix = 0;
        for (Article article : articles) {
            totalPrix += article.getPrix();
        }
    }

    public double getTVA() {
        //TODO TAUX TVA  :: Variable selon catégorie
        double TVA = 5.5;
        double TTC = getTotalPrix();
        double HT = TTC / (1 + (TVA / 100));
        return TTC - HT;
    }
}