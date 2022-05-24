package fr.epsi.rennes.poec.stephen.mistayan.Controller;

import fr.epsi.rennes.poec.stephen.mistayan.domain.Response;
import fr.epsi.rennes.poec.stephen.mistayan.exception.BusinessException;
import fr.epsi.rennes.poec.stephen.mistayan.exception.TechnicalException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.SQLException;

/**
 * Author : Stephen Mistayan
 * Created on : 5/19/2022 : 4:38 PM:11
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.stephen.mistayan.Controller
 * Project name : pizzaHut
 **/

@ControllerAdvice
public class ExceptionController {

    private static final Logger logger = LogManager.getLogger(ExceptionController.class);

    @ExceptionHandler(BusinessException.class)
    @ResponseBody
    public Response<String> onBusinessException(BusinessException e) {
        logger.fatal(e.getMessage());
        Response<String> response = new Response<>();
        response.setSuccess(false);
        response.setData(e.getCode());

        return response;
    }

    @ExceptionHandler(TechnicalException.class)
    @ResponseBody
    public Response<Void> onTechnicalException(TechnicalException e) {
        logger.fatal(e.getMessage());
        Response<Void> response = new Response<>();
        response.setSuccess(false);

        return response;
    }

    @ExceptionHandler(SQLException.class)
    @ResponseBody
    public Response<String> onSQLException(BusinessException e) {
        logger.debug(e.getMessage());
        Response<String> response = new Response<>();
        response.setSuccess(false);
        response.setData(e.getCode());

        return response;
    }
}
