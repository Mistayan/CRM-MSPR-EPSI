package fr.epsi.rennes.poec.evoli.mspr.domain;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;


public class User implements UserDetails {

    private final boolean checked = true;
    private int id;
    private String email;
    private String password;
    private String nickname;
    private String dateCreated;
    private String role;

    public String getEmail() {
        return this.email;
    }

    // ================================

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        if (role == null || role.length() == 0) {
            return null;
        }
        return List.of(UserRole.valueOf(role));
    }

    @Override
    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String getUsername() {
        return this.email;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    // ================================
    @Override
    public boolean isAccountNonExpired() {
        return this.checked;
    }

    @Override
    public boolean isAccountNonLocked() {
        return this.checked;
    }

    // ================================

    @Override
    public boolean isCredentialsNonExpired() {
        return this.checked;
    }

    @Override
    public boolean isEnabled() {
        return this.checked;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(String dateCreated) {
        this.dateCreated = dateCreated;
    }

    public boolean isChecked() {
        return checked;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
