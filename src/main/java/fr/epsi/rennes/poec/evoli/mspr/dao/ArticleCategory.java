package fr.epsi.rennes.poec.evoli.mspr.dao;

/**
 * Author : Stephen Mistayan
 * Created on : 5/29/2022 : 12:06 PM:55
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.dao
 * Project name : acme MSPR
 **/

public class ArticleCategory {

    private int id;
    private String label;
    private double taxes;

    // ================================== BUILDER ==================================

    private ArticleCategory(int id, String label, double taxes) {
        this.id = id;
        this.label = label;
        this.taxes = taxes;
    }

    public ArticleCategory() {
    }

    // ================================== GETTERS ==================================

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLabel() {
        return label;
    }

    // ================================== SETTERS ==================================

    public void setLabel(String label) {
        this.label = label;
    }

    public double getTaxes() {
        return taxes;
    }

    public void setTaxes(double taxes) {
        this.taxes = taxes;
    }

    // ================================== SHOW ==================================

    // ================================== OVERRIDES ==================================
}
