package fr.epsi.rennes.poec.evoli.mspr.conf;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
@EnableAspectJAutoProxy
@EnableAutoConfiguration
@EnableConfigurationProperties
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {
    private static final Logger logger = LogManager.getLogger(SpringSecurityConfig.class);
    private final UserDetailsService userDetailsService;

    public SpringSecurityConfig(@Lazy UserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth
                .userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder())
        ;
        auth.jdbcAuthentication()
        ;

    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
//        super.configure(http);
        http
                .headers()
                .xssProtection()
                .xssProtectionEnabled(true)
        ;
        http
                .csrf().disable()
                .authorizeRequests()
                .antMatchers("/ressources/**").permitAll().filterSecurityInterceptorOncePerRequest(true)
                .antMatchers("/public/**").hasAnyRole("USER", "COMM", "ADMIN").filterSecurityInterceptorOncePerRequest(true)
                .antMatchers("/user/**").hasAnyRole("USER", "COMM", "ADMIN").filterSecurityInterceptorOncePerRequest(true)
                .antMatchers("/customer/**").hasAnyRole( "USER", "COMM","ADMIN").filterSecurityInterceptorOncePerRequest(true)
                .antMatchers("/comm**/**").hasAnyRole("COMM", "ADMIN").filterSecurityInterceptorOncePerRequest(true)
                .antMatchers("/admin**/**", "/actuator/**").hasRole("ADMIN").filterSecurityInterceptorOncePerRequest(true)
                .and()
                .formLogin()
                .defaultSuccessUrl("/public/login-success.html")
                .failureUrl("/login.html?error=true")
                .and()
                .logout()
                .deleteCookies("Arma3")
        ;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public Logger appLogger() {return LogManager.getLogger();}

}