package fr.epsi.rennes.poec.stephen.mistayan.conf;

import com.zaxxer.hikari.HikariDataSource;
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

import static org.eclipse.jdt.internal.compiler.codegen.ConstantPool.GetClass;

@Configuration(proxyBeanMethods = true)
@EnableWebSecurity
@EnableAspectJAutoProxy
@EnableAutoConfiguration
@EnableConfigurationProperties
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {
    private static final Logger logger = LogManager.getLogger(GetClass);
    private final UserDetailsService userDetailsService;

    //    @Lazy
    public SpringSecurityConfig(@Lazy UserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth
                .userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder());
//                .notifyAll();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .csrf().disable()  //should be removed ?
                .authorizeRequests()
                .antMatchers("/public/**").permitAll()//.filterSecurityInterceptorOncePerRequest(true)
                .antMatchers("/user/**").hasAnyRole("USER", "ADMIN")//.filterSecurityInterceptorOncePerRequest(true)
                .antMatchers("/admin/**", "/actuator/**").hasRole("ADMIN")
//                .antMatchers("/**").hasRole("ADMIN") // Debug only
                .and()
                .formLogin()
//                .loginPage("/login.html")
//                .loginProcessingUrl("/user/login-success.html")
                .defaultSuccessUrl("/user/login-success.html")
                .failureUrl("/login.html?error=true")
                .and()
                .logout()
//                .logoutUrl("/logout")
                .deleteCookies("JSESSIONID");
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public Logger appLogger() {return LogManager.getLogger("app");}

}