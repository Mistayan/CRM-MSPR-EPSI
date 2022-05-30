package fr.epsi.rennes.poec.evoli.mspr.domain;

/**
 * Author : Stephen Mistayan
 * Created on : 5/10/2022 : 9:24 AM:55
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.domain
 * Project name : Evoli-Acme
 **/


public class PokemonProperties {
    //todo: faire une classe props plus général, et utiliser (extends / implements) ?
    private int id; //info generale
    private String type; //gen
    private String label; //gen
    private double taille; //gen
    private double poids; //gen
    private int lvl; //specifique à la classe
    private int exp; //...
    private PokemonStats stats; //...

    public PokemonProperties() {
        id = lvl = exp = 0; //gen => appeler super() pour init
        taille = poids = 0; //gen
        type = label = ""; //gen
        stats = null;
    }
    // ======================== SPECIAL DAO (get from DB) ===========================

    /**
     * @param toSplit expected style : "id:label:taille:poids:[class specific: lvl:exp]"
     **/
    public PokemonProperties(String toSplit) {
        String[] propsList = toSplit.split(":");    // properties
        this.setId(Integer.parseInt(propsList[0]));
        this.setLabel(propsList[1]);
        this.setTaille(Double.parseDouble(propsList[2]));
        this.setPoids(Double.parseDouble(propsList[3]));
        this.setLvl(Integer.parseInt(propsList[4]));
        this.setExp(Integer.parseInt(propsList[5]));
    }
    // ================================== GETTERS ==================================

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public double getTaille() {
        return taille;
    }

    public void setTaille(double taille) {
        this.taille = taille;
    }

    // ================================== SETTERS ==================================

    public double getPoids() {
        return poids;
    }

    public void setPoids(double poids) {
        this.poids = poids;
    }

    public int getLvl() {
        return lvl;
    }

    public void setLvl(int lvl) {
        this.lvl = lvl;
    }

    public int getExp() {
        return exp;
    }

    public void setExp(int exp) {
        this.exp = exp;
    }

    public PokemonStats getStats() {
        return stats;
    }

    public void setStats(PokemonStats stats) {
        this.stats = stats;
    }

    @Override
    public String toString() {
        return this.label;
    }
}
