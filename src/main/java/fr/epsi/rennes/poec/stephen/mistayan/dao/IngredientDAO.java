package fr.epsi.rennes.poec.stephen.mistayan.dao;

import fr.epsi.rennes.poec.stephen.mistayan.domain.Ingredient;
import fr.epsi.rennes.poec.stephen.mistayan.exception.TechnicalException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Author : Stephen Mistayan
 * Created on : 5/10/2022 : 1:31 PM:44
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.stephen.mistayan.dao
 * Project name : pizzaHut
 **/

@Repository
public class IngredientDAO {

    @Autowired
    private DataSource ds;

    public List<Ingredient> getAllIngredients() {
        String sql = "select * from ingredients";
        try (PreparedStatement stmt = ds.getConnection().prepareStatement(sql)) {
            List<Ingredient> ingredients = new ArrayList<>();
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Ingredient ingredient = new Ingredient();
                ingredient.setId(rs.getInt("id"));
                ingredient.setLabel(rs.getString("label"));
                ingredient.setNbCalories(rs.getInt("nb_calories"));
                ingredient.setPrix(rs.getDouble("prix"));
                ingredient.setType(rs.getString("type"));
                ingredients.add(ingredient);
            }
            return ingredients;
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }
}
