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
@Table(name = "Shares")
public class Share {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "UserId")
    private User user;

    @ManyToOne
    @JoinColumn(name = "VideoId")
    private Video video;

    @Column(name = "SharedToEmail", columnDefinition = "NVARCHAR(100)")
    private String sharedToEmail;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ShareDate")
    private Date shareDate;

    // ----- Constructors -----
    public Share() {
    }

    public Share(Long id, User user, Video video, String sharedToEmail, Date shareDate) {
        this.id = id;
        this.user = user;
        this.video = video;
        this.sharedToEmail = sharedToEmail;
        this.shareDate = shareDate;
    }

    // ----- Getters & Setters -----
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Video getVideo() {
        return video;
    }

    public void setVideo(Video video) {
        this.video = video;
    }

    public String getSharedToEmail() {
        return sharedToEmail;
    }

    public void setSharedToEmail(String sharedToEmail) {
        this.sharedToEmail = sharedToEmail;
    }

    public Date getShareDate() {
        return shareDate;
    }

    public void setShareDate(Date shareDate) {
        this.shareDate = shareDate;
    }

    // ----- Optional: toString() -----
    @Override
    public String toString() {
        return "Share{id=" + id + ", user=" + user + ", video=" + video +
               ", sharedToEmail='" + sharedToEmail + "', shareDate=" + shareDate + "}";
    }
}