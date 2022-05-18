package fr.epsi.rennes.poec.stephen.mistayan.Controller;


import fr.epsi.rennes.poec.stephen.mistayan.domain.Response;
import fr.epsi.rennes.poec.stephen.mistayan.domain.User;
import fr.epsi.rennes.poec.stephen.mistayan.exception.TechnicalException;
import fr.epsi.rennes.poec.stephen.mistayan.service.UserService;
import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.sql.SQLException;

@RestController
public class UserController {
    private static final Logger logger = LogManager.getLogger(String.valueOf(UserService.class));
    @Autowired
    private UserService userService;

    @PostMapping("/public/register")
    public void addUser(@RequestParam String email,
                        @RequestParam String password) {
        try {
            User user = new User();
            user.setEmail(email);
            user.setPassword(password);
            userService.addUser(user);
        } catch (TechnicalException e) {
            throw new TechnicalException(new SQLException("public/register route user.service.addUser failed"));
        }

    }

    @PostMapping("/user/order")
    public Response<Long> order(@RequestParam int panier_id) {
//                                @AuthenticationPrincipal User user) {
        Response<Long> response = new Response<>();
        try {
            logger.info("########### Action : ordering");
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            long order_id = userService.userOrder(auth.getName(), panier_id);
            response.setData(order_id);
            response.setSuccess(true);
            return response;
        } catch (TechnicalException e) {
            response.setSuccess(false);
            logger.log(Level.FATAL, "user/order route userService.userOrder failed :::> " + e);
            return (response);
//            throw new TechnicalException(new SQLException(""));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
