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
    private double total;
    private String userEmail;
    private int totalCalories;
    private int totalPrix;

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

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public int getTotalCalories() {
        return totalCalories;
    }

    public void setTotalCalories(int totalCalories) {
        this.totalCalories = totalCalories;
    }

    public int getTotalPrix() {
        return totalPrix;
    }

    public void setTotalPrix(int totalPrix) {
        this.totalPrix = totalPrix;
    }
}
