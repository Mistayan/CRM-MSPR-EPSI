package fr.epsi.rennes.poec.stephen.mistayan.dao;

import fr.epsi.rennes.poec.stephen.mistayan.domain.Ingredient;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Pizza;
import fr.epsi.rennes.poec.stephen.mistayan.exception.TechnicalException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
    @Autowired
    private DataSource ds;

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

        try (PreparedStatement stmt = ds.getConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, label);
            int ctrl = stmt.executeUpdate();
            if (ctrl != 1) throw new SQLException("Error while inserting pizza");
            ResultSet rs = stmt.getGeneratedKeys();
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

        try (PreparedStatement stmt = ds.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, pizzaId);
            stmt.setInt(2, ingredientId);
            int ctrl = stmt.executeUpdate();
            //if (ctrl != 1) throw new BusinessException(e);
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
        try (PreparedStatement stmt = ds.getConnection().prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
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
//    public static void addPizza(Pizza pizza) throws SQLException {
//        String sql = "INSERT INTO pizza (label, ingredients, description, prix) VALUES (?,?,?,?);";
//
//        try (PreparedStatement stmt = ds.getConnection().prepareStatement(sql)) {
//            stmt.setString(1, pizza.getLabel());
//            stmt.setString(2, pizza.getIngredients());
//            stmt.setString(3, pizza.getDescription());
//            stmt.setDouble(4, pizza.getPrix());
//            stmt.setInt(5, pizza.getCalories());
//            stmt.executeUpdate(sql);
//        } catch (SQLException e) {
//            throw new SQLException(e);
//        }
//    }
//    public List<Pizza> getList() throws SQLException {
//        List<Pizza> list = new ArrayList<>();
//
//        String sqlSelect = "Select label, ingredients, descritpion, prix FROM articles";
//        try (Statement stmt = ds.getConnection().createStatement();
//             ResultSet rs = stmt.executeQuery(sqlSelect)) {
//            pizzaBDLink(list, rs);
//        } catch (SQLException e) {
//            throw new SQLException(e);
//        }
//        return list;
//    }
//
//    private void pizzaBDLink(List<Pizza> list, ResultSet rs) throws SQLException {
//        while (rs.next()) {
//            Pizza article = new Pizza();
//            article.setId(rs.getInt(1));
//            article.setLabel(rs.getString(2));
//            article.setIngredients(rs.getDouble(3));
//            article.setDescription(rs.getString(4));
//            article.setPrix(rs.getInt(5));
//            article.setCalories(rs.getInt(6));
//            list.add(article);
//        }
//    }
//
//    public List<Pizza> getListByLabel(String label) throws SQLException {
//        List<Pizza> list = new ArrayList<>();
//
//        String sql = "Select label, ingredients, descritpion, prix FROM articles WHERE label = '?'";
//        try (PreparedStatement stmt = ds.getConnection().prepareStatement(sql)){
//             stmt.setString(1, label);
//             ResultSet rs = stmt.executeQuery();
//            pizzaBDLink(list, rs);
//        } catch (SQLException e) {
//            throw new SQLException(e);
//        }
//        return list;
//    }
}
