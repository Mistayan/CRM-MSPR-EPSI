package fr.epsi.rennes.poec.evoli.mspr.service;

import fr.epsi.rennes.poec.evoli.mspr.dao.CommandeDAO;
import fr.epsi.rennes.poec.evoli.mspr.dao.UserDAO;
import fr.epsi.rennes.poec.evoli.mspr.domain.Commande;
import fr.epsi.rennes.poec.evoli.mspr.domain.User;
import fr.epsi.rennes.poec.evoli.mspr.exception.TechnicalException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class UserService implements UserDetailsService {

    private static final Logger logger = LogManager.getLogger(String.valueOf(UserService.class));
    private final UserDAO userDAO;
    private final CommandeDAO commandeDAO;

    @Autowired
    private UserService(UserDAO userDAO, CommandeDAO commandeDAO) {
        this.userDAO = userDAO;
        this.commandeDAO = commandeDAO;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        try {
            User user = userDAO.getUserByEmail(username);
            if (user == null) {
                throw new SQLException("no such user");
            }
        return user;
        } catch (SQLException e) {
            throw new TechnicalException(new UsernameNotFoundException("UserService ::: User not found : " + username));
        }
    }

    public void addUser(User user) {
        try {
//            user.setRole(UserRole.ROLE_USER.name());
            logger.info("UserService ::: user role : " + user.getRole());
            userDAO.addUser(user);
        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
            throw new TechnicalException(new SQLException(e));
        }
    }

    public int userOrder(String userName, int panierId) throws SQLException {
        try {
            logger.info("UserService ::: user : " + userName + "is ordering : \nPanierId : " + panierId);
            int userId = userDAO.getUserIdFromName(userName);
            int orderId = commandeDAO.doCustomerOrder(userId, panierId);
            logger.info("UserService ::: tracking order %d by user %s".formatted(orderId, userName));
            commandeDAO.addUserOrder(userId, orderId);
            logger.debug("done");
            return orderId;
        } catch (SQLException e) {
            throw new TechnicalException(new SQLException(e));
        }
    }

    public int getUserIdFromName(String userName) throws SQLException {
        try {
            logger.info("UserService ::: getUserIdFromName : " + userName);
            return userDAO.getUserIdFromName(userName); // on assumera que springboot ne nous ment pas ?
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }

    public List<Commande> getOrdersFromCustomerId(int customerId, int limit) throws SQLException {
        try {
            logger.info("UserService ::: getCustomerIdOrders : " + customerId);
            return commandeDAO.getOrdersFromCustomerId(customerId, limit); //todo? set minimumLimit as superGlobal
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }

    public Commande getOrderByOrderId(int orderId) throws SQLException {
        try {
            return commandeDAO.getOrderById(orderId);
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }
    public List<Commande> getOrdersFromUserId(int userId, int limit) throws SQLException {
        try {
            logger.info("UserService ::: getCustomerIdOrders : " + userId);
            return commandeDAO.getOrdersFromUserId(userId, limit); //todo? set minimumLimit as superGlobal
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }
}

