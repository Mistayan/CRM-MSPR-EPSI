package fr.epsi.rennes.poec.stephen.mistayan.dao;

import fr.epsi.rennes.poec.stephen.mistayan.domain.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@Repository
public class UserDAO {
    private static final Logger logger = LogManager.getLogger(UserDAO.class);
    private final DataSource ds;
    @Autowired(required = false)
    private PasswordEncoder passwordEncoder;

    public UserDAO(DataSource ds) {this.ds = ds;}

    public User getUserByEmail(String mail) throws SQLException {
        //pre-encoding checks


        //end of pre-encoding checks
        String sql = "SELECT email, password, userRole" +
                " FROM user" +
                " WHERE email = ?";
        try (PreparedStatement stmt = ds.getConnection().prepareStatement(sql)) {
            stmt.setString(1, mail);
            ResultSet rs = stmt.executeQuery();
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
        try (PreparedStatement stmt = ds.getConnection().prepareStatement(sql)) {
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

    public int getUserByName(String name) throws SQLException {
        logger.info(Thread.currentThread().getName());
        String sql = "SELECT id FROM user WHERE  email = ?";
        try (PreparedStatement stmt = ds.getConnection().prepareStatement(sql)) {
            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();
            if (!rs.next()) {
                throw new SQLException("error: user not found");
            }
            return rs.getInt(1);
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }
}
