package fr.epsi.rennes.poec.evoli.mspr.domain;

/**
 * Author : Stephen Mistayan
 * Created on : 5/10/2022 : 2:05 PM:05
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.domain
 * Project name : Evoli-Acme
 **/

public class Response<T> {

    private T data;
    private boolean success = true;

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }
}
