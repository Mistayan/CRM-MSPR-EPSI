package fr.epsi.rennes.poec.stephen.mistayan.Controller;


import fr.epsi.rennes.poec.stephen.mistayan.domain.User;
import fr.epsi.rennes.poec.stephen.mistayan.exception.TechnicalException;
import fr.epsi.rennes.poec.stephen.mistayan.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

@RestController
public class UserController {

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
}
