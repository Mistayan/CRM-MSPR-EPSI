package fr.epsi.rennes.poec.stephen.mistayan.domain;

import java.util.List;

/**
 * Author : Stephen Mistayan
 * Created on : 5/10/2022 : 9:24 AM:23
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.stephen.mistayan.domain
 * Project name : pizzaHut
 **/

public class Panier {
    private int panierId;
    private List<Pizza> pizzas;
    private int totalCalories;
    private int totalPrix;

    public int getId() {
        return panierId;
    }
    public List<Pizza> getPizzas() {
        return pizzas;
    }
    public int getTotalCalories() {
        return totalCalories;
    }
    public int getTotalPrix() {
        return totalPrix;
    }
    public void setId(int id) {
        this.panierId = id;
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
    public void setPizzas(List<Pizza> pizzas) {
        this.pizzas = pizzas;
    }

}
