package fr.epsi.rennes.poec.evoli.mspr.domain;

/**
 * Author : Stephen Mistayan
 * Created on : 6/5/2022 : 12:57 AM:40
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.domain
 * Project name : acme MSPR
 **/

public class CustomerAddress {
    String wayName;
    String city;
    String country;
    String wayType;
    String postalCode;
    int wayNumber;

    public String getWayName() {
        return wayName;
    }

    public void setWayName(String wayName) {
        this.wayName = wayName;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getWayType() {
        return wayType;
    }

    public void setWayType(String wayType) {
        this.wayType = wayType;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public int getWayNumber() {
        return wayNumber;
    }

    public void setWayNumber(int wayNumber) {
        this.wayNumber = wayNumber;
    }
}
