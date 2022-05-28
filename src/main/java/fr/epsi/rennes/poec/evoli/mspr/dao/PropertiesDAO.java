package fr.epsi.rennes.poec.evoli.mspr.dao;

import fr.epsi.rennes.poec.evoli.mspr.domain.Property;
import fr.epsi.rennes.poec.evoli.mspr.exception.TechnicalException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Author : Stephen Mistayan
 * Created on : 5/10/2022 : 1:31 PM:44
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.dao
 * Project name : Evoli-Acme
 **/

@Repository
public class PropertiesDAO {
    private static final Logger logger = LogManager.getLogger(PropertiesDAO.class);
    private final DataSource ds;

    @Autowired
    public PropertiesDAO(DataSource ds) {this.ds = ds;}

    public List<Property> getAllProps() {
        String sql = "select * from article_properties";
        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            List<Property> props = new ArrayList<>();
            ResultSet rs = stmt.executeQuery();
            conn.close();
            while (rs.next()) {
                Property prop = new Property();
                prop.setId(rs.getInt("id"));
                prop.setLabel(rs.getString("label"));
                prop.setNbCalories(rs.getInt("nb_calories"));
                prop.setPrix(rs.getDouble("prix"));
                prop.setType(rs.getString("type"));
                props.add(prop);
            }
            return props;
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }
}
