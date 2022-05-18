package fr.epsi.rennes.poec.stephen.mistayan.domain;

import java.text.DecimalFormat;
import java.util.List;

/**
 * Author : Stephen Mistayan
 * Created on : 5/10/2022 : 9:24 AM:23
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.stephen.mistayan.domain
 * Project name : pizzaHut
 **/

public class Panier {
    private static final DecimalFormat df = new DecimalFormat("0.00");

    private int panierId;
    private List<Pizza> pizzas;
    private double totalCalories;
    private double totalPrix;

    public int getId() {
        return panierId;
    }

    public void setId(int id) {
        this.panierId = id;
    }

    public List<Pizza> getPizzas() {
        return pizzas;
    }

    public void setPizzas(List<Pizza> pizzas) {
        this.pizzas = pizzas;
    }

    public double getTotalCalories() {
        return totalCalories;
    }

    public double getTotalPrix() {
        return totalPrix;
    }

    public void setTotalCalories() {
        totalCalories = 0;
        for (Pizza pizza : pizzas) {
            totalCalories += pizza.getCalories();
        }
    }

    public void setTotalPrix() {
        totalPrix = 0;
        for (Pizza pizza : pizzas) {
            totalPrix += pizza.getPrix();
        }
    }

    @Override
    public final String toString() {
        StringBuilder sb = new StringBuilder();
        for (Pizza pizza : pizzas) {
//            sb.append("\"pizza\": \"").append(pizza.getLabel()).append("\",");
//            sb.append("\"prix\": \"").append(pizza.getPrix()).append("\",");
            sb.append(pizza.getLabel()).append(", ");
        }
        // Substring to skip last coma and \n, then add JSON_End_Of_Object
        return sb.substring(0, sb.length() - 2);
    }

    public Double getTVA() {
        double TVA = 5.5;
        double TTC = getTotalPrix();
        double HT = TTC / (1 + (TVA / 100));
        return Double.parseDouble(df.format(TTC - HT));
    }
}
