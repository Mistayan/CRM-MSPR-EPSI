package fr.epsi.rennes.poec.stephen.mistayan.dao;

import fr.epsi.rennes.poec.stephen.mistayan.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@Repository
public class UserDAO {

    @Autowired
    private DataSource ds;

    @Autowired(required = false)
    private PasswordEncoder passwordEncoder;

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

    public void addUser(User user) throws SQLException {
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
}
