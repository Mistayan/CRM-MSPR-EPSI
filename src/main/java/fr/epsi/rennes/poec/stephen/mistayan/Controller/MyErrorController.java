package fr.epsi.rennes.poec.stephen.mistayan.Controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

/**
 * Author: Stephen Mistayan
 * Created on : 5/4/2022 : 3:46 PM:29
 * IDE : IntelliJ IDEA
 * $
 **/
//@RestController
public class MyErrorController{ //implements ErrorController {

//    @RequestMapping("/error")
//    public String handleError(HttpServletRequest request) {
//        Object name = request.getHeader(RequestDispatcher.ERROR_SERVLET_NAME);
//        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
//
//        if (status != null) {
//            int statusCode = Integer.parseInt(status.toString());
//            if (statusCode == HttpStatus.NOT_FOUND.value()) {
//                return "error-404";
//            }
//        }
//        return "error unknown";
//    }
}


