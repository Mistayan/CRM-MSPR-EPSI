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

    public void setId(int id) {
        this.panierId = id;
    }

    public void setPizzas(List<Pizza> pizzas) {
        this.pizzas = pizzas;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public void setTotalCalories(int totalCalories) {
        this.totalCalories = totalCalories;
    }

    public void setTotalPrix(int totalPrix) {
        this.totalPrix = totalPrix;
    }

    public int getId() {
        return panierId;
    }

    public List<Pizza> getPizzas() {
        return pizzas;
    }

    public double getTotal() {
        return total;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public int getTotalCalories() {
        return totalCalories;
    }

    public int getTotalPrix() {
        return totalPrix;
    }
}
