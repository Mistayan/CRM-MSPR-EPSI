package fr.epsi.rennes.poec.stephen.mistayan.service;

import fr.epsi.rennes.poec.stephen.mistayan.dao.CommandeDAO;
import fr.epsi.rennes.poec.stephen.mistayan.dao.UserDAO;
import fr.epsi.rennes.poec.stephen.mistayan.domain.User;
import fr.epsi.rennes.poec.stephen.mistayan.domain.UserRole;
import fr.epsi.rennes.poec.stephen.mistayan.exception.TechnicalException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.sql.SQLException;

@Service
public class UserService implements UserDetailsService {

    private static final Logger logger = LogManager.getLogger(String.valueOf(UserService.class));
    private final UserDAO userDAO;
    private final CommandeDAO commandeDAO;

    @Autowired
    public UserService(UserDAO userDAO, CommandeDAO commandeDAO) {
        this.userDAO = userDAO;
        this.commandeDAO = commandeDAO;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        try {
            UserDetails user = userDAO.getUserByEmail(username);
            if (user == null) {
                throw new UsernameNotFoundException("User not found : " + username);
            }
            return user;
        } catch (SQLException e) {
//            logger.error(e.getMessage(), e);
            throw new TechnicalException(e);
        }
    }

    public void addUser(User user) {
        try {
            user.setRole(UserRole.ROLE_USER.name());
            userDAO.addUser(user);
        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
            throw new TechnicalException(e);
        }
    }

    public long userOrder(String userName, int panierId) throws SQLException {

        return commandeDAO.order(userName, panierId);
    }
}

