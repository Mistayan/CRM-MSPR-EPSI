package fr.epsi.rennes.poec.evoli.mspr.exception;

import java.io.Serial;

public class TechnicalException extends RuntimeException {

    @Serial
    private static final long serialVersionUID = 1L;

    public TechnicalException(Exception e) {
        super(e);
    }
}
