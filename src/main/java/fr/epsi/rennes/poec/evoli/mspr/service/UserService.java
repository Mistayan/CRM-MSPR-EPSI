package fr.epsi.rennes.poec.evoli.mspr.service;

import fr.epsi.rennes.poec.evoli.mspr.dao.CommandeDAO;
import fr.epsi.rennes.poec.evoli.mspr.dao.UserDAO;
import fr.epsi.rennes.poec.evoli.mspr.domain.Commande;
import fr.epsi.rennes.poec.evoli.mspr.domain.User;
import fr.epsi.rennes.poec.evoli.mspr.domain.UserRole;
import fr.epsi.rennes.poec.evoli.mspr.exception.BusinessException;
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
    public UserDetails loadUserByUsername(String username) {
        try {
            logger.debug(username);
            User user = userDAO.getUserByEmail(username);
            if (user == null) {
                throw new SQLException("no such user");
            }
            return user;
        } catch (SQLException e) {
            throw new RuntimeException("email + password incorrect");
        }
    }

    public void addUser(User user) {
        try {
//            user.setRole(UserRole.ROLE_USER.name());
            logger.trace("Adding user: {'email': %s, 'role': %s, 'nickname': %s} "
                    .formatted(user.getEmail(), user.getRole(), user.getNickname()));
            userDAO.addUser(user);
        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
            throw new TechnicalException(new SQLException(e));
        }
    }

    public int userOrder(String userName, int panierId) throws SQLException {
        try {
            logger.info("UserService ::: " + userName + "is ordering : \nPanierId : " + panierId);
            int userId = userDAO.getUserIdFromName(userName);
            int orderId = commandeDAO.doCustomerOrder(userId, panierId);
            logger.info("UserService ::: tracking order %d by %s".formatted(orderId, userName));
            commandeDAO.addUserOrder(userId, orderId);
            logger.debug("done");
            return orderId;
        } catch (SQLException e) {
            throw new TechnicalException(new SQLException(e));
        }
    }

    public int getUserIdFromName(String userName) throws TechnicalException {
        try {
            logger.info("getUserIdFromName : %s".formatted(userName));
            int userId = userDAO.getUserIdFromName(userName);
            return userId; // on assumera que springboot ne nous ment pas ?
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }

    public List<Commande> getOrdersFromCustomerId(int customerId, int limit) throws SQLException {
        try {
            logger.info("UserService ::: getCustomerIdOrders : " + customerId);
            return commandeDAO.getOrdersFromCustomerId(customerId, limit); //todo? set minimumLimit as superGlobal
        } catch (SQLException e) {
            throw new TechnicalException(new SQLException(e));
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
            return commandeDAO.getOrdersFromUserId(userId, limit); //todo? set minimumLimit as superGlobal
        } catch (SQLException e) {
            throw new TechnicalException(new SQLException(e));
        }
    }

    public List<User> getAllUsers() {
        try {
            return userDAO.getAllUsers();
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }

    public List<UserRole> getAllRoles() {
        return userDAO.getAllRoles();
    }

    public UserDetails modifyUser(User user) throws Exception {
        if (!userDAO.modifyUser(user)) {
            throw new BusinessException("cannot change user %d".formatted(user.getId()));
        }
        return user;
    }
}

