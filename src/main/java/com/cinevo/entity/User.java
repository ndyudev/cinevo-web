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
}
