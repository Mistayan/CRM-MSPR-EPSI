package fr.epsi.rennes.poec.evoli.mspr;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "fr.epsi.rennes.poec.evoli.mspr")
public class AcmeApplication {
    public static void main(String[] args) {
        SpringApplication.run(AcmeApplication.class, args);
    }
}
