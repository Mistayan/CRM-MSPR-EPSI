package fr.epsi.rennes.poec.evoli.mspr.dao;

import fr.epsi.rennes.poec.evoli.mspr.domain.User;
import fr.epsi.rennes.poec.evoli.mspr.domain.UserRole;
import fr.epsi.rennes.poec.evoli.mspr.exception.TechnicalException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class UserDAO {
    private static final Logger logger = LogManager.getLogger(UserDAO.class);
    private final DataSource ds;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserDAO(DataSource ds, PasswordEncoder passwordEncoder) throws SQLException {
        this.ds = ds;
        this.passwordEncoder = passwordEncoder;
    }

    public User getUserByEmail(String mail) throws SQLException {

        String sql = "SELECT email, password, user_role, nickname, date_created FROM user WHERE email = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, mail);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) { // pour le premier élément de la requête:
                logger.debug("getUserByEmail" + mail);
                User user = new User();
                user.setEmail(rs.getString(1));
                user.setPassword(rs.getString(2));
                user.setRole(rs.getString(3));
                user.setNickname(rs.getString(4));
                user.setDateCreated(rs.getString(5));
                logger.debug("getUserByEmail Result : " +
                        user.getRole() + " " + user.getNickname() + " " + user.getDateCreated());
                return user;
            } else {
                return null;
            }
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }

    @Async
    public void addUser(User user) throws SQLException {
        String sql = "INSERT INTO user ( email , password , user_role ) VALUES (?,?,?)";
        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getEmail());
            stmt.setString(2, passwordEncoder.encode(user.getPassword()));
            stmt.setString(3, user.getRole());

            int user_id = stmt.executeUpdate();
            if (user_id == 0) {
                throw new SQLException("error adding user.");
            }
        } catch (SQLException e) {
            logger.error("could not %s with email= %s, role= %s, nick= %s".formatted(sql, user.getEmail(), user.getRole(), user.getNickname()));
            throw new SQLException(e);
        }
    }

    public int getUserIdFromName(String mail) throws SQLException {
        String sql = "SELECT user_id FROM user WHERE  email = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, mail);
            ResultSet rs = stmt.executeQuery();
            if (!rs.next()) {
                throw new SQLException("error: user not found");
            }
            return rs.getInt(1) == -1 ? 0 : rs.getInt(1);
        } catch (SQLException e) {
            throw new TechnicalException(new SQLException(e));
        }
    }

    public List<User> getAllUsers() throws SQLException {
        String sql = "SELECT * FROM user ";
        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            List<User> users = new ArrayList<>();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPassword("");
                user.setRole(rs.getString("user_role"));
                user.setNickname(rs.getString("nickname"));
                user.setDateCreated(rs.getString("date_created"));
                users.add(user);
            }
            return users;
        } catch (SQLException e) {
            throw new TechnicalException(new SQLException(e));
        }
    }

    public List<UserRole> getAllRoles() {
        String sql = "SELECT label FROM user_role";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            List<UserRole> roles = new ArrayList<>();
            ResultSet rs = ps.executeQuery();
            logger.debug("ok");
            while (rs.next()) {
                UserRole role = UserRole.valueOf("%s%s".formatted("ROLE_", rs.getString("label")));
                roles.add(role);
            }
            return roles;
        } catch (SQLException e) {
            throw new TechnicalException(new SQLException(e));
        }
    }

    public boolean modifyUser(User user) throws SQLException {
        String sql = "update user set email = ? ,nickname = ? ,user_role = ? WHERE user_id = ?;";
        logger.debug("modUser");
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getNickname());
            ps.setString(3, user.getRole() == null ? "ROLE_NOONE" : user.getRole());
            ps.setInt(4, user.getId());
            logger.debug("exec");
            int ctrl = ps.executeUpdate();
            logger.debug("ok, parsing");

            if (ctrl > 0) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }
}
