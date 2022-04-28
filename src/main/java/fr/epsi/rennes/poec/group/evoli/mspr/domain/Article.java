package fr.epsi.rennes.poec.group.evoli.mspr.domain;

public class Article {

    private int id;
    private String code;
    private String label;

    // ===================GETTER===================
    public int getId() {
        return id;
    }

    public String getCode() {
        return code;
    }

    public String getLabel() {
        return label;
    }

    // ===================SETTER===================

    public void setId(int id) {
        this.id = id;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public void setLabel(String label) {
        this.label = label;
    }
}
