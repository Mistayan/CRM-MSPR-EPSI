package fr.epsi.rennes.poec.evoli.mspr.dao;

import fr.epsi.rennes.poec.evoli.mspr.domain.Customer;
import fr.epsi.rennes.poec.evoli.mspr.domain.CustomerAddress;
import fr.epsi.rennes.poec.evoli.mspr.exception.TechnicalException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Author : Stephen Mistayan
 * Created on : 6/5/2022 : 1:19 AM:46
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.dao
 * Project name : acme MSPR
 **/

@Repository
public class CustomerDAO {
    private static final Logger logger = LogManager.getLogger(CustomerDAO.class);
    private final DataSource ds;

    public CustomerDAO(DataSource ds) {this.ds = ds;}

    public List<Customer> getAllCustomers() {
        String sql = "SELECT * from customer";

        try (Connection conn = ds.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)){
        ResultSet rs = ps.executeQuery();
        List<Customer> customers = new ArrayList<>();
        while (rs.next()) {
            Customer customer = new Customer();
            customer.setId(rs.getInt("customer_id"));
            customer.setFirstName(rs.getString("first_name"));
            customer.setLastName(rs.getString("last_name"));
            customer.setEmail(rs.getString("email"));
            customer.setPhone(rs.getString("phone"));
            CustomerAddress address = new CustomerAddress();
            address.setCountry(rs.getString("country"));
            address.setCity(rs.getString("city"));
            address.setPostalCode(rs.getString("postal_code"));
            address.setWayNumber(rs.getInt("way_number"));
            address.setWayType(rs.getString("way_type"));
            address.setWayName(rs.getString("way_name"));
            customer.setAddress(address);
            customers.add(customer);
        }
        return customers;
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }
    public int addCustomer(Customer c) {
        String sql = "INSERT INTO customer " +
                "(first_name, last_name, email, phone," +
                " country, city, postal_code," +
                " way_number, way_type, way_name) " +
                "VALUES " +
                "(?,?,?,?,?,?,?,?,?,?) " + // 10
                "";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, c.getFirstName());
            ps.setString(2, c.getLastName());
            ps.setString(3, c.getEmail());
            ps.setString(4, c.getPhone());
            ps.setString(5, c.getAddress().getCountry());
            ps.setString(6, c.getAddress().getCity());
            ps.setString(7, c.getAddress().getPostalCode());
            ps.setInt(8, c.getAddress().getWayNumber());
            ps.setString(9, c.getAddress().getWayType());
            ps.setString(10, c.getAddress().getWayName());

            int ctrl = ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
        return -1;
    }

    public int switchCustomer(int customerId, boolean _switch) {
        String sql = "UPDATE customer SET " +
                "enabled = ? " +
                "WHERE customer_id = ?";
        try (Connection conn = ds.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, _switch);
            ps.setInt(2, customerId);
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
        return -1;
    }

    public int modifyCustomer(Customer c) {
        String sql = "UPDATE customer SET " +
                "first_name = ?, last_name = ?, " +
                "email = ?, phone = ?, " +
                "country = ?, city = ?, postal_code = ?, " +
                "way_number = ?, way_type = ?, way_name = ? " + // 10
                "WHERE customer_id = ? " + // 11
                ";";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, c.getFirstName());
            ps.setString(2, c.getLastName());
            ps.setString(3, c.getEmail());
            ps.setString(4, c.getPhone());
            CustomerAddress a = c.getAddress();
            ps.setString(5, a.getCountry());
            ps.setString(6, a.getCity());
            ps.setString(7, a.getPostalCode());
            ps.setInt(8, a.getWayNumber());
            ps.setString(9, a.getWayType());
            ps.setString(10, a.getWayName());
            ps.setInt(11, c.getId());

            int ctrl = ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            conn.close();
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
        return -1;
    }

    /**
     * La requête étant de type 'publique', on filtrera au maximum les infos sorties. (customerId, fullName, city)
     **/
    public List<Customer> getAllCustomersPublic() {
        String sql = "SELECT customer_id, first_name, last_name, city " +
                "FROM customer";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            List<Customer> customers = new ArrayList<>();
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setId(rs.getInt("customer_id"));
                customer.setFirstName(rs.getString("first_name"));
                customer.setLastName(rs.getString("last_name"));
                CustomerAddress address = new CustomerAddress();
                address.setCity(rs.getString("city"));
                customer.setAddress(address);
                customers.add(customer);
            }
            return customers;
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }

    }
}
