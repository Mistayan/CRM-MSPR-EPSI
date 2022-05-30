package fr.epsi.rennes.poec.evoli.mspr.domain;

import fr.epsi.rennes.poec.evoli.mspr.dao.ArticleCategory;

import java.text.DecimalFormat;

/**
 * Author: Stephen Mistayan
 * Created on : 5/9/2022 : 7:30 AM:28
 * IDE : IntelliJ IDEA
 * $
 * int id,
 * String label,
 * double prix
 **/


public class Article {

    private static final DecimalFormat df = new DecimalFormat("0.00");
    private int id;
    private String codeArticle;
    private String label;
    private double prix;
    private String dateCreated;
    private ArticleCategory category;
    private PokemonProperties properties;
    private String description;

    public String getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(String dateCreated) {
        this.dateCreated = dateCreated;
    }

    public ArticleCategory getCategory() {
        return category;
    }

    public void setCategory(ArticleCategory category) {
        this.category = category;
    }

    public PokemonProperties getProperties() {
        return properties;
    }

    public void setProperties(PokemonProperties properties) {
        this.properties = properties;
    }

    public String getCodeArticle() {
        return codeArticle;
    }

    public void setCodeArticle(String codeArticle) {
        this.codeArticle = codeArticle;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }

    @Override
    public String toString() {
        return "{\"Nom\": \"" + this.label + "\", " +
                String.format("\"Prix\": %f\n}", prix);
    }

}
