package fr.epsi.rennes.poec.stephen.mistayan.dao;

import fr.epsi.rennes.poec.stephen.mistayan.domain.Panier;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Pizza;
import fr.epsi.rennes.poec.stephen.mistayan.exception.TechnicalException;
import fr.epsi.rennes.poec.stephen.mistayan.service.PizzaService;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * Author : Stephen Mistayan
 * Created on : 5/12/2022 : 11:14 AM:20
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.stephen.mistayan.dao
 * Project name : pizzaHut
 **/

@Repository
public class PanierDAO {
    @Autowired
    private DataSource ds;

    @Autowired
    private Logger logger;

    @Autowired
    private PizzaService pizzaService = new PizzaService();

    public void addPizza(Pizza pizza, int panier_id) {
        String sql = "insert into panier_pizza"
                + "(panier_id, pizza_id) values (?,?)";
        try (PreparedStatement ps = ds.getConnection().prepareStatement(sql)) {
            if (panier_id >= 1) {
                ps.setInt(1, panier_id);
            } else {
                ps.setInt(1, 0);
            }
            ps.setInt(2, pizza.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean doesPanierExist(int panier_id) {
        String sql = "select id from panier where id = ?";
        try (PreparedStatement ps = ds.getConnection().prepareStatement(sql)) {

            ps.setInt(1, panier_id);

            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }

    //Créer un panier => service et controller
    public int CreatePanier() {
        String sql = "insert into panier (timestamp) values(?)";
        try (PreparedStatement ps = ds.getConnection()
                .prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            String date = LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME);
            ps.setString(1, date);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys(); //
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
        throw new TechnicalException(new SQLException("Panier creation error"));
    }

    public Panier getPanierById(int panier_id) {
        String sql = "select "
                + "panier.id as panier_id, "
                + "panier.timestamp as panier_date, "
                + "group_concat(pizza.id) as pizzas "
                + "from panier "
                + "right join panier_pizza "
                + "on panier_pizza.panier_id = panier.id "
                + "left join pizza "
                + "on panier_pizza.pizza_id = pizza.id "
                + "where panier.id = ? ";
        //+ "group by panier.id ";
        try (PreparedStatement ps = ds.getConnection().prepareStatement(sql)) {


            ps.setInt(1, panier_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Panier panier = new Panier();
                panier.setId(rs.getInt("panier_id"));


                String pizzas = rs.getString("pizzas");

                List<Pizza> pizzaRepo = pizzaService.getAllPizzas();
                List<Pizza> pizzaList = new ArrayList<>();
                if (pizzas != null) {
                    for (String pizza_id : pizzas.split(",")) {
                        for (Pizza pizza_ : pizzaRepo) {
                            if (pizza_.getId() == Integer.parseInt(pizza_id)) {
                                pizzaList.add(pizza_);
                            }
                        }
                    }
                    panier.setPizzas(pizzaList);
                    panier.setTotalPrix();
                    panier.setTotalCalories();
                }
                return panier;
            }
            return null;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void removePizza(int pizza_id, int panier_id) {
        String sql = "DELETE FROM panier_pizza" +
                "    WHERE panier_id = ?" +
                "    AND pizza_id = ?" +
                "    LIMIT 1;";

        try (PreparedStatement ps = ds.getConnection().prepareStatement(sql)) {
            ps.setInt(1, Math.max(panier_id, 0));
            ps.setInt(2, Math.max(pizza_id, 0));
            ps.executeQuery();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void truncate(int panier_id) {
        String sql = "DELETE FROM panier_pizza" +
                "    WHERE panier_id = ?";
        try (PreparedStatement ps = ds.getConnection().prepareStatement(sql)) {
            ps.setInt(1, Math.max(panier_id, 0));
            ps.executeQuery();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}