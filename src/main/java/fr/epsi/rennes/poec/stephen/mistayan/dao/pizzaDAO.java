package fr.epsi.rennes.poec.stephen.mistayan.dao;

import fr.epsi.rennes.poec.stephen.mistayan.domain.Ingredient;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Pizza;
import fr.epsi.rennes.poec.stephen.mistayan.exception.TechnicalException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Author: Stephen Mistayan
 * Created on : 5/5/2022 : 12:30 AM:11
 * IDE : IntelliJ IDEA
 * $
 **/
@Repository
public class pizzaDAO {
    private final DataSource ds;

    @Autowired
    public pizzaDAO(DataSource ds) {this.ds = ds;}

    /**
     * int id;
     * String label;
     * List<Ingredient> ingredients;
     * double prix;
     * int nb_calories;
     *
     * @throws TechnicalException
     */

    public int createPizza(String label) throws TechnicalException {
        String sql = "INSERT INTO pizza (label) values (?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, label);
            int ctrl = ps.executeUpdate();
            if (ctrl != 1) throw new SQLException("Error while inserting pizza");
            ResultSet rs = ps.getGeneratedKeys();
            conn.close();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (TechnicalException | SQLException e) {
            throw new TechnicalException(e);
        }
        return -1;
    }

    public void addIngredientToPizza(int pizzaId, int ingredientId) throws TechnicalException {
        String sql = "INSERT INTO pizza_ingredient (pizza_id, ingredient_id) values (?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pizzaId);
            ps.setInt(2, ingredientId);
            int ctrl = ps.executeUpdate();
            conn.close();
            if (ctrl != 1) throw new SQLException("could not add ingredient to pizza");
        } catch (TechnicalException | SQLException e) {
            throw new TechnicalException(e);
        }
    }

    // 	id 	label 	prix    nb_calories
    public List<Pizza> getAll() throws TechnicalException {
        String sql = "SELECT p.id as pizzaId, p.label as pizzaLabel, " +
                "GROUP_CONCAT(ingredients.id, ':', ingredients.label," +
                " ':', ingredients.prix, ':', ingredients.nb_calories) as ingredients " +
                "FROM pizza as p " +
                "RIGHT JOIN pizza_ingredient ON pizza_ingredient.pizza_id = p.id " +
                "LEFT JOIN ingredients ON pizza_ingredient.ingredient_id = ingredients.id " +
                "GROUP BY p.label;";
        List<Pizza> pizzas = new ArrayList<>();
        try (Connection conn = ds.getConnection()) {
            ResultSet rs = conn.createStatement().executeQuery(sql);
            conn.close();
            while (rs.next()) {
                Pizza pizza = new Pizza();
                String ingredients = rs.getString("ingredients");
                List<Ingredient> ingredientsList = new ArrayList<>();
                for (String ingredient : ingredients.split(",")) {
                    String[] idAndIng = ingredient.split(":");
                    Ingredient ingredientPojo = new Ingredient();
                    ingredientPojo.setId(Integer.parseInt(idAndIng[0]));
                    ingredientPojo.setLabel(idAndIng[1]);
                    ingredientPojo.setPrix(Double.parseDouble(idAndIng[2]));
                    ingredientPojo.setNbCalories(Integer.parseInt(idAndIng[3]));
                    ingredientsList.add(ingredientPojo);
                }
                pizza.setIngredients(ingredientsList);
                pizza.setLabel(rs.getString("pizzaLabel"));
                pizza.setId(rs.getInt("pizzaId"));
                pizza.setPrix();
                pizza.setCalories();
                pizzas.add(pizza);
            }
            return pizzas;
            //if (ctrl != 1) throw new BusinessException(e);
        } catch (TechnicalException | SQLException e) {
            throw new TechnicalException(e);
        }

    }
}