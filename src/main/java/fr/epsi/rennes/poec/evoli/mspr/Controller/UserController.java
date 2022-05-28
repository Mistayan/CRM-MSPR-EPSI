package fr.epsi.rennes.poec.evoli.mspr.Controller;


import fr.epsi.rennes.poec.evoli.mspr.domain.Commande;
import fr.epsi.rennes.poec.evoli.mspr.domain.Response;
import fr.epsi.rennes.poec.evoli.mspr.domain.User;
import fr.epsi.rennes.poec.evoli.mspr.exception.TechnicalException;
import fr.epsi.rennes.poec.evoli.mspr.service.UserService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.sql.SQLException;
import java.util.List;

@RestController
public class UserController {
    private static final Logger logger = LogManager.getLogger(String.valueOf(UserService.class));
    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {this.userService = userService;}

    @PostMapping("/public/register")
    public void addUser(@RequestParam String email,
                        @RequestParam String password) {
        try {
            User user = new User();
            logger.info("user is registering : \nmail : " + email + "\npassword : ");
            user.setEmail(email);
            user.setPassword(password);
            userService.addUser(user);
        } catch (TechnicalException e) {
            throw new RuntimeException("public/register route user.service.addUser failed");
        }

    }

    @PostMapping("/user/order")
    public Response<Commande> order(@RequestParam int panierId) {
//                                @AuthenticationPrincipal User user) {
        Response<Commande> response = new Response<>();
        try {
            logger.info("########### Action : ordering cart " + panierId);
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            int orderId = userService.userOrder(auth.getName(), panierId);
            response.setData(userService.getOrderByOrderId(orderId));
            response.setSuccess(true);
            return response;
        } catch (TechnicalException e) {
            response.setSuccess(false);
            logger.fatal("user/order route userService.userOrder failed :::> " + e);
            throw new RuntimeException("order failed. See logs for more details", e);
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }

    @GetMapping("/user/orders")
    public Response<List<Commande>> orders() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        // on récupère le nom de l'utilisateur via l'application, et son token JSession
        Response<List<Commande>> response = new Response<>();
        try {
            int userId = userService.getUserIdFromName(auth.getName());
            logger.info("########### Action : fetching orders from userId : " + userId);
            List<Commande> commandes = userService.getOrdersFromUserId(userId);
            logger.info("########### Fetched Commande :  " + commandes);
            response.setData(commandes);
            response.setSuccess(true);
            return response;
        } catch (SQLException e) {
            response.setSuccess(false);
            throw new RuntimeException("Could not load user's orders");
        }
    }
}
