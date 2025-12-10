package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "saved_centers")
public class SavedCenter {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id", nullable = false)
    private Hospital hospital;

    @Column(updatable = false)
    private LocalDateTime savedAt;

    public SavedCenter() {}

    @PrePersist
    protected void onCreate() {
        savedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Hospital getHospital() { return hospital; }
    public void setHospital(Hospital hospital) { this.hospital = hospital; }

    public LocalDateTime getSavedAt() { return savedAt; }
    public void setSavedAt(LocalDateTime savedAt) { this.savedAt = savedAt; }
}

