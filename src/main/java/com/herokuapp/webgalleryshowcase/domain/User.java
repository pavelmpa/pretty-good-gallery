package com.herokuapp.webgalleryshowcase.domain;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.security.core.GrantedAuthority;

import javax.validation.constraints.Pattern;
import java.util.Collection;
import java.util.Date;

public class User {

    private int id;
    @Length(max = 30, message = "Username must be in range 30.")
    private String firstName;
    @Length(max = 30, message = "Username must be in range 30.")
    private String lastName;
    @NotBlank(message = "Email can not be blank.")
    @Email(message = "Invalid email")
    private String email;
    @NotBlank(message = "Username can not be blank.")
    @Pattern(regexp = "([A-Za-z0-9]{6,20})",
            message = "Username must be in range 6 and 30 and contain latin letters and numbers")
    private String username;
    @NotBlank(message = "Password must not be blank.")
    @Length(min = 6, max = 30, message = "Password must be between 6 and 30.")
    private String password;
    @NotBlank(message = "Confirm password must not be blank.")
    @Length(min = 6, max = 30, message = "Confirm password must be between 6 and 30.")
    private String confirmPassword;
    private Collection<? extends GrantedAuthority> authorities;
    private Date joinDate;
    private boolean enabled;

    public void setId(int id) {
        this.id = id;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
        this.authorities = authorities;
    }

    public Date getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(Date joinDate) {
        this.joinDate = joinDate;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
