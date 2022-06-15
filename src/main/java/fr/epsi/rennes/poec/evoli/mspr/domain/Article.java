package fr.epsi.rennes.poec.evoli.mspr.domain;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

    private int id;
    private String codeArticle;
    private String label;
    private double prix;
    private String description;
    private String dateCreated;
    private ArticleCategory category;
    private PokemonProperties properties;
    private PokemonStats stats;
    private boolean status;

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

    public PokemonStats getStats() {
        return stats;
    }

    public void setStats(PokemonStats stats) {
        this.stats = stats;
    }

    @Override
    public String toString() {
        return "{\"Nom\": \"%s\",\"Prix\": %f}".formatted(label, prix);
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
