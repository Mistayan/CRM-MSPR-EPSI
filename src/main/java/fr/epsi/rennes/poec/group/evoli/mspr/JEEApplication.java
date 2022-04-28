package fr.epsi.rennes.poec.group.evoli.mspr;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.sql.SQLException;

@SpringBootApplication(
        scanBasePackages = "fr.epsi.rennes.poec.group.evoli.mspr" //Racine du projet
)
public class JEEApplication {

    public static void main(String[] args) {
        SpringApplication application = new SpringApplication(JEEApplication.class);
        //
        // Si on souhaite configurer l'application, c'est ici qu'on le fera.
        //

        application.run(args);
    }
}

