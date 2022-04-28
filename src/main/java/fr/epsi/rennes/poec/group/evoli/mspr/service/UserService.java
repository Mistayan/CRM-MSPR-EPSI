package fr.epsi.rennes.poec.group.evoli.mspr.service;

import fr.epsi.rennes.poec.group.evoli.mspr.dao.UserDAO;
import fr.epsi.rennes.poec.group.evoli.mspr.domain.User;
import fr.epsi.rennes.poec.group.evoli.mspr.exception.TechnicalException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Repository;

import java.sql.SQLException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@Repository
public class UserService implements UserDetailsService {

    private static final Logger logger = LogManager.getLogger(String.valueOf(UserService.class));
    @Autowired
    private UserDAO userDAO;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        try {
            UserDetails user = userDAO.getUserByEmail(username);
            if (user == null) {
                throw new UsernameNotFoundException("User not found : " + username);
            }
            return user;
        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
            throw new TechnicalException(e);
        }
    }

    public void addUser(User user) {
        try {
            userDAO.addUser(user);
        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
            throw new TechnicalException(e);
        }
    }
}
