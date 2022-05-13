package fr.epsi.rennes.poec.stephen.mistayan.exception;

import java.io.Serial;

public class BusinessException extends Exception {
    @Serial
    private static final long serialVersionUID = 1L;
    private final String code;

    public BusinessException(String code) {
        this.code = code;
    }

    public String getCode() {
        return this.code;
    }
}
