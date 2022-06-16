package fr.epsi.rennes.poec.evoli.mspr.domain;

import org.springframework.security.core.GrantedAuthority;

//public class UserRole implements GrantedAuthority {
//    private final String name;
//
//    public UserRole(String name) {
//    this.name = name;


public enum UserRole implements GrantedAuthority {
    ROLE_USER, ROLE_COMM, ROLE_ADMIN, ROLE_TROUFION,
    ROLE_RANDOM, ROLE_IT, ROLE_COMPTA, ROLE_MODERATOR, ROLE_NOONE;


    @Override
    public String getAuthority() {
        return this.name();
    }
}
