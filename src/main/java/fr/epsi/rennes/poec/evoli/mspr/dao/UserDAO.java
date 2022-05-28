package fr.epsi.rennes.poec.evoli.mspr.dao;

import fr.epsi.rennes.poec.evoli.mspr.domain.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;

@Repository
public class UserDAO {
    private static final Logger logger = LogManager.getLogger(UserDAO.class);
    private final DataSource ds;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserDAO(DataSource ds, PasswordEncoder passwordEncoder) {this.ds = ds;
        this.passwordEncoder = passwordEncoder;
    }

    public User getUserByEmail(String mail) throws SQLException {
        //pre-encoding checks


        //end of pre-encoding checks
        String sql = "SELECT email, password, user_role, nickname, date_created" +
                " FROM user" +
                " WHERE email = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement stmt  = conn.prepareStatement(sql)) {
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
                        user.getRole() + " " + user.getNickname() +" " + user.getDateCreated());
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
        logger.info(Thread.currentThread().getName());
        String sql = "INSERT INTO user ( email , password , user_role ) VALUES (?,?,?)";
        try (Connection conn = ds.getConnection();
             PreparedStatement stmt  = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getEmail());
            stmt.setString(2, passwordEncoder.encode(user.getPassword()));
            stmt.setString(3, user.getRole());

            int user_id = stmt.executeUpdate();
            if (user_id == 0) {
                throw new SQLException("error adding user.");
            }
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }

    public int getUserByName(String mail) throws SQLException {
        String sql = "SELECT user_id FROM user WHERE  email = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, mail);
            ResultSet rs = stmt.executeQuery();
            if (!rs.next()) {
                throw new SQLException("error: user not found");
            }
            int userId = rs.getInt(1);
            return userId;
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }
}