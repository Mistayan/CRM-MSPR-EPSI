package fr.epsi.rennes.poec.evoli.mspr.Controller;


import fr.epsi.rennes.poec.evoli.mspr.domain.Commande;
import fr.epsi.rennes.poec.evoli.mspr.domain.Response;
import fr.epsi.rennes.poec.evoli.mspr.exception.BusinessException;
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
    int limit = 501;

    @Autowired
    public UserController(UserService userService) {this.userService = userService;}
//    @PostMapping("/public/register")
//    public void addUser(@RequestParam String email,
//                        @RequestParam String password) {
//        try {
//            User user = new User();
//            logger.info("user is registering : \nmail : " + email + "\npassword : ");
//            user.setEmail(email);
//            user.setPassword(password);
//            userService.addUser(user);
//        } catch (TechnicalException e) {
//            throw new RuntimeException("public/register route user.service.addUser failed");
//        }
//    }

    @PostMapping("/user/order")
    public Response<Commande> order(@RequestParam int panierId) throws BusinessException {
//                                @AuthenticationPrincipal User user) {
        Response<Commande> response = new Response<>();
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            logger.info("%s : ordering cart %d".formatted(auth.getName(), panierId));
            int orderId = userService.userOrder(auth.getName(), panierId);
            response.setData(userService.getOrderByOrderId(orderId));
            response.setSuccess(true);
            return response;
        } catch (SQLException e) {
            response.setSuccess(false);
            logger.fatal("user/order route userService.userOrder failed :::> %s".formatted(e));
            throw new BusinessException("could not load order n°%d".formatted(panierId));
        }
    }

    @GetMapping("/customer/orders")
    public Response<List<Commande>> customerOrders(@RequestParam int customerId) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        // on récupère le nom de l'utilisateur via l'application, et son token JSession
        Response<List<Commande>> response = new Response<>();
        try {
            logger.trace("%s : fetching orders from customerId : %d"
                    .formatted(auth.getName(), customerId));
            List<Commande> commandes = userService.getOrdersFromCustomerId(customerId, this.limit);
            response.setData(commandes);
            response.setSuccess(true);
            return response;
        } catch (SQLException e) {
            response.setSuccess(false);
            throw new RuntimeException("Could not load user's orders");
        }
    }

    @GetMapping("/user/orders")
    public Response<List<Commande>> getUserOrders(int userId) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        // on récupère le nom de l'utilisateur via l'application, et son token JSession
        Response<List<Commande>> response = new Response<>();
        try {
            int requesterId = userService.getUserIdFromName(auth.getName());
            logger.trace("%s : requesterId: %d fetching orders from userId : %d"
                    .formatted(auth.getName(), requesterId, userId));
            List<Commande> commandes = userService.getOrdersFromUserId(userId, this.limit);
            response.setData(commandes);
            response.setSuccess(true);
            return response;
        } catch (SQLException e) {
            response.setSuccess(false);
            throw new RuntimeException("Could not load user's orders");
        }
    }

    @GetMapping("/user/id")
    public Response<Integer> getUserId() throws BusinessException {
        Response<Integer> response = new Response<>();

        String userName = SecurityContextHolder.getContext().getAuthentication().getName();
        try {
            int userId = userService.getUserIdFromName(userName);
            response.setSuccess(userId > 0);
            response.setData(userId);
            return response;
        } catch (TechnicalException e) {
            response.setSuccess(false);
            throw new BusinessException("Could not load user's id for %s".formatted(userName) + e);
        }
    }
}
