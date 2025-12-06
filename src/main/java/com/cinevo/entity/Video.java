package com.cinevo.entity;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Videos")
public class Video {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "Id")
	private Long id;

	@Column(name = "Title", columnDefinition = "NVARCHAR(255)")
	private String title;

	@Column(name = "Description", columnDefinition = "NVARCHAR(MAX)")
	private String description;

	@Column(name = "PosterUrl", columnDefinition = "NVARCHAR(500)")
	private String posterUrl;

	@Column(name = "VideoUrl", columnDefinition = "NVARCHAR(500)")
	private String videoUrl;

	@Column(name = "Director", columnDefinition = "NVARCHAR(100)")
	private String director;

	@Column(name = "ReleaseYear")
	private Integer releaseYear;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "UploadedDate")
	private Date uploadedDate;

	@Column(name = "Views")
	private Integer views = 0;

	@ManyToOne
	@JoinColumn(name = "CategoryId")
	private Category category;
}
