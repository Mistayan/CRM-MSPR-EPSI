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
    private int customerId;
    private List<Article> articles;
    private double TVA;
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

    public void setTotalPrix(double totalPrix) {
        this.totalPrix = totalPrix;
    }

    public void setTotalPrix() {
        totalPrix = 0;
        for (Article article : articles) {
            totalPrix += article.getPrix();
        }
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public double calc_TVA() {
        double TVA = 0;
        double TTC = 0;
        double HT = 0;

        for (Article article : articles) {
            TVA = article.getCategory().getTaxes();
            double price = article.getPrix();
            TTC += price;
            HT += price / (1 + (TVA / 100));
        }
        return TTC - HT;
    }

    public void setTVA() {
        TVA = calc_TVA();
    }

    public double getTVA() {
        return TVA;
    }
}
