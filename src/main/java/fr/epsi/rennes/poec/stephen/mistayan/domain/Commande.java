package fr.epsi.rennes.poec.stephen.mistayan.domain;

import java.util.List;

/**
 * Author : Stephen Mistayan
 * Created on : 5/10/2022 : 9:24 AM:34
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.stephen.mistayan.domain
 * Project name : pizzaHut
 **/

public class Commande {

    private String numeroCmd;
    private int OrderId;
    private String clientEmail;
    private List<Pizza> pizzas;
    private double prixHT;
    private double prixTTC;

    public String getNumeroCmd() {
        return numeroCmd;
    }

    public void setNumeroCmd(String numeroCmd) {
        this.numeroCmd = numeroCmd;
    }

    public int getOrderId() {
        return OrderId;
    }

    public void setOrderId(int OrderId) {
        this.OrderId = OrderId;
    }

    public String getClientEmail() {
        return clientEmail;
    }

    public void setClientEmail(String clientEmail) {
        this.clientEmail = clientEmail;
    }

    public List<Pizza> getPizzas() {
        return pizzas;
    }

    public void setPizzas(List<Pizza> pizzas) {
        this.pizzas = pizzas;
    }

    public double getPrixHT() {
        return prixHT;
    }

    public void setPrixHT(double prixHT) {
        this.prixHT = prixHT;
    }

    public double getPrixTTC() {
        return prixTTC;
    }

    public void setPrixTTC(double prixTTC) {
        this.prixTTC = prixTTC;
    }
}
