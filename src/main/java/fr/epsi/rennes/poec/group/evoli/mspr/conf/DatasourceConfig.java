package fr.epsi.rennes.poec.group.evoli.mspr.conf;

import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

@Configuration
public class DatasourceConfig {
    @Bean // Required for Autowire
    public DataSource getDataSource() {
        DataSourceBuilder dataSourceBuilder = DataSourceBuilder.create();
        dataSourceBuilder.driverClassName("com.mysql.cj.jdbc.Driver");
        dataSourceBuilder.url("jdbc:mysql://localhost:3306/ACME");
        dataSourceBuilder.username("JEEApplication2");
        dataSourceBuilder.password("");
        return dataSourceBuilder.build();
        }
}
