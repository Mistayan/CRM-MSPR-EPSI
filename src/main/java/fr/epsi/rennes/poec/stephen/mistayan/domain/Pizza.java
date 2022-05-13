package fr.epsi.rennes.poec.stephen.mistayan.domain;

import java.util.List;

/**
 * Author: Stephen Mistayan
 * Created on : 5/9/2022 : 7:30 AM:28
 * IDE : IntelliJ IDEA
 * $
 **/
public class Pizza {

    private int id;

    private String label;
    // private List<Ingredient> ingredients;
    private List<Ingredient> ingredients;
    private double prix;
    private int calories;


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

    public List<Ingredient> getIngredients() {
        return ingredients;
    }

    public void setIngredients(List<Ingredient> ingredients) {
        this.ingredients = ingredients;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }

    public int getCalories() {
        return calories;
    }

    public void setCalories(int calories) {
        this.calories = calories;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("{\"Nom\" : \"" + this.label + "\", ")
                .append(String.format("\"Ingredient\" : \"%s\"", ingredients)).append("\", ")
                .append(String.format("\"Prix\" : %f\n}", prix))
                .append(String.format("\"Nb_Calories\" : %d\n}", calories));

        return sb.toString();
    }

}
