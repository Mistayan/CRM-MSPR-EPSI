package fr.epsi.rennes.poec.stephen.mistayan.dao;

import fr.epsi.rennes.poec.stephen.mistayan.domain.Panier;
import fr.epsi.rennes.poec.stephen.mistayan.domain.Pizza;
import fr.epsi.rennes.poec.stephen.mistayan.exception.TechnicalException;
import fr.epsi.rennes.poec.stephen.mistayan.service.PizzaService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.sql.*;
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
    private static final Logger logger = LogManager.getLogger(PanierDAO.class);
    @Autowired
    private DataSource ds;
    @Autowired
    private PizzaService pizzaService;

    @Async
    public void addPizza(Pizza pizza, int panierId) {
        String sql = "insert into panier_pizza"
                + "(panier_id, pizza_id) values (?,?)";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (panierId >= 1) {
                ps.setInt(1, panierId);
            } else {
                ps.setInt(1, 0);
            }
            ps.setInt(2, pizza.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("could not add pizza to DB :: Panier: " + panierId + " & pizzaId: " + pizza.getId());
        }
    }

    public boolean doesPanierExist(int panierId) {
        String sql = "select id from panier where id = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, panierId);

            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }

    //Créer un panier => service et controller
    public int CreatePanier() {
        String sql = "insert into panier (timestamp) values(?)";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            String date = LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME);
            ps.setString(1, date);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            conn.close();
            if (rs.next()) {
                return rs.getInt(1);
            }
            return -1;
        } catch (SQLException e) {
            throw new TechnicalException(e);
        }
    }

    public Panier getPanierById(int panierId) {
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
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, panierId);
            ResultSet rs = ps.executeQuery();
            conn.close();
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

    public void removePizza(int pizzaId, int panierId) {
        String sql = "DELETE FROM panier_pizza" +
                "    WHERE panier_id = ?" +
                "    AND pizza_id = ?" +
                "    LIMIT 1;";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, Math.max(panierId, 0));
            ps.setInt(2, Math.max(pizzaId, 0));
            ps.executeQuery();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Async
    @Transactional
    public void truncate(int panierId) {
        String sql = "DELETE FROM panier_pizza" +
                "    WHERE panier_id = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, Math.max(panierId, 0));
            ps.executeQuery();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}