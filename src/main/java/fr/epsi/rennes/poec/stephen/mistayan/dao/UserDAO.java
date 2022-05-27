package fr.epsi.rennes.poec.stephen.mistayan.dao;

import fr.epsi.rennes.poec.stephen.mistayan.domain.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@Repository
public class UserDAO {
    private static final Logger logger = LogManager.getLogger(UserDAO.class);
    private final DataSource ds;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserDAO(DataSource ds, PasswordEncoder passwordEncoder) {
        this.ds = ds;
        this.passwordEncoder = passwordEncoder;
    }

    public User getUserByEmail(String mail) throws SQLException {
        //pre-encoding checks


        //end of pre-encoding checks
        String sql = "SELECT email, password, userRole" +
                " FROM user" +
                " WHERE email = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, mail);
            ResultSet rs = ps.executeQuery();
            conn.close();
            if (rs.next()) { // pour le premier élément de la requête:
                User user = new User();
                user.setEmail(rs.getString(1));
                user.setPassword(rs.getString(2));
                user.setRole(rs.getString(3));
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
        String sql = "INSERT INTO user ( email , password , userRole ) VALUES (?,?,?)";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, passwordEncoder.encode(user.getPassword()));
            ps.setString(3, user.getRole());

            int user_id = ps.executeUpdate();
            conn.close();
            if (user_id == 0) {
                throw new SQLException("error adding user.");
            }
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }

    public int getUserByName(String name) throws SQLException {
        logger.info(Thread.currentThread().getName());
        String sql = "SELECT id FROM user WHERE  email = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            conn.close();
            if (!rs.next()) {
                throw new SQLException("error: user not found");
            }
            return rs.getInt(1);
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }
}
