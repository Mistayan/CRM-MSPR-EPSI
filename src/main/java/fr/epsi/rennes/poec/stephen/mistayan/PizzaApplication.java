package fr.epsi.rennes.poec.stephen.mistayan;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.sql.SQLException;

@SpringBootApplication(scanBasePackages = "fr.epsi.rennes.poec.stephen.mistayan")
public class PizzaApplication {
    public static void main(String[] args) {
        SpringApplication.run(PizzaApplication.class, args);
    }
}
