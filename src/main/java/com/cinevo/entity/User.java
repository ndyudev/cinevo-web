package com.cinevo.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Users")
public class User {


	    @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    @Column(name = "Id")
	    private Long id;

	    @Column(name = "Email", columnDefinition = "NVARCHAR(100)")
	    private String email;

	    @Column(name = "Password", columnDefinition = "NVARCHAR(255)")
	    private String password;

	    @Column(name = "Fullname", columnDefinition = "NVARCHAR(100)")
	    private String fullname;

	    @Column(name = "IsAdmin")
	    private Boolean isAdmin = false;

	    // ----- Constructors -----
	    public User() {
	    }

	    public User(Long id, String email, String password, String fullname, Boolean isAdmin) {
	        this.id = id;
	        this.email = email;
	        this.password = password;
	        this.fullname = fullname;
	        this.isAdmin = isAdmin;
	    }

	    // ----- Getters & Setters -----
	    public Long getId() {
	        return id;
	    }

	    public void setId(Long id) {
	        this.id = id;
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

	    public String getFullname() {
	        return fullname;
	    }

	    public void setFullname(String fullname) {
	        this.fullname = fullname;
	    }

	    public Boolean getIsAdmin() {
	        return isAdmin;
	    }

	    public void setIsAdmin(Boolean isAdmin) {
	        this.isAdmin = isAdmin;
	    }

	    // ----- Optional: toString() -----
	    @Override
	    public String toString() {
	        return "User{id=" + id + ", email='" + email + "', fullname='" + fullname + 
	               "', isAdmin=" + isAdmin + "}";
	    }
	
}