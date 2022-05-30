package fr.epsi.rennes.poec.evoli.mspr.domain;

/**
 * Author : Stephen Mistayan
 * Created on : 5/29/2022 : 2:00 PM:03
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.domain
 * Project name : acme MSPR
 **/

public class PokemonStats {
    private int pv;
    private int pp;
    private int atk;
    private int def;
    private int spd;
    private int atkspe;
    private int defspe;

    public PokemonStats() {
        pv = pp = atk = def = spd = atkspe = defspe = 0;
    }

    // ================================== SPECIAL DAO ==================================
    public PokemonStats(String splitted) {
        String[] stats = splitted.split(":");
        this.setAtk(Integer.parseInt(stats[0]));
        this.setDef(Integer.parseInt(stats[1]));
        this.setSpd(Integer.parseInt(stats[2]));
        this.setAtkspe(Integer.parseInt(stats[3]));
        this.setDefspe(Integer.parseInt(stats[4]));
        this.setPv(Integer.parseInt(stats[5]));
        this.setPp(Integer.parseInt(stats[6]));
    }
    // ================================== GETTERS ==================================

    public int getPv() {
        return pv;
    }

    public void setPv(int pv) {
        this.pv = pv;
    }

    public int getPp() {
        return pp;
    }

    public void setPp(int pp) {
        this.pp = pp;
    }

    public int getAtk() {
        return atk;
    }

    public void setAtk(int atk) {
        this.atk = atk;
    }

    public int getDef() {
        return def;
    }

    // ================================== SETTERS ==================================

    public void setDef(int def) {
        this.def = def;
    }

    public int getSpd() {
        return spd;
    }

    public void setSpd(int spd) {
        this.spd = spd;
    }

    public int getAtkspe() {
        return atkspe;
    }

    public void setAtkspe(int atkspe) {
        this.atkspe = atkspe;
    }

    public int getDefspe() {
        return defspe;
    }

    public void setDefspe(int defspe) {
        this.defspe = defspe;
    }


    // ================================== SHOW ==================================

    // ================================== OVERRIDES ==================================
}
