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
    public String getLabel() {
        return label;
    }

    public List<Ingredient> getIngredients() {
        return ingredients;
    }

    public double getPrix() {
        return prix;
    }

    public int getCalories() {
        return calories;
    }

    public void setId(int id) {
        this.id = id;
    }
    public void setLabel(String label) {
        this.label = label;
    }
    public void setIngredients(List<Ingredient> ingredients) {
        this.ingredients = ingredients;
    }
    public void setPrix() {
        double prix = 1.87;
        for (Ingredient ingredient : this.ingredients) {
            prix += ingredient.getPrix();
        }
        this.prix = prix;
    }

    public void setCalories() {

        int calories = 0;
        for (Ingredient ingredient : this.ingredients) {
            calories += ingredient.getNbCalories();
        }
        this.calories = calories;
    }

    @Override
    public String toString() {
        return "{\"Nom\": \"" + this.label + "\", " +
                String.format("\"Ingredient\": \"%s\"", ingredients) + "\", " +
                String.format("\"Prix\": %f\n}", prix) +
                String.format("\"Nb_Calories\": %d\n}", calories);
    }

}
