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

    // ----- Constructors -----
    public Video() {
    }

    public Video(Long id, String title, String description, String posterUrl, String videoUrl,
                 String director, Integer releaseYear, Date uploadedDate, Integer views,
                 Category category) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.posterUrl = posterUrl;
        this.videoUrl = videoUrl;
        this.director = director;
        this.releaseYear = releaseYear;
        this.uploadedDate = uploadedDate;
        this.views = views;
        this.category = category;
    }

    // ----- Getters & Setters -----
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getPosterUrl() { return posterUrl; }
    public void setPosterUrl(String posterUrl) { this.posterUrl = posterUrl; }

    public String getVideoUrl() { return videoUrl; }
    public void setVideoUrl(String videoUrl) { this.videoUrl = videoUrl; }

    public String getDirector() { return director; }
    public void setDirector(String director) { this.director = director; }

    public Integer getReleaseYear() { return releaseYear; }
    public void setReleaseYear(Integer releaseYear) { this.releaseYear = releaseYear; }

    public Date getUploadedDate() { return uploadedDate; }
    public void setUploadedDate(Date uploadedDate) { this.uploadedDate = uploadedDate; }

    public Integer getViews() { return views; }
    public void setViews(Integer views) { this.views = views; }

    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }

    // ----- Optional: toString() -----
    @Override
    public String toString() {
        return "Video{id=" + id + ", title='" + title + "', director='" + director +
               "', releaseYear=" + releaseYear + ", views=" + views + "}";
    }
}