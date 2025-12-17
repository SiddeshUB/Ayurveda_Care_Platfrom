package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "review_helpful_votes", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"review_id", "user_id"})
})
public class ReviewHelpfulVote {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "review_id", nullable = false)
    private ProductReview review;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Enumerated(EnumType.STRING)
    private VoteType voteType; // HELPFUL or NOT_HELPFUL

    @Column(updatable = false)
    private LocalDateTime createdAt;

    public ReviewHelpfulVote() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public ProductReview getReview() { return review; }
    public void setReview(ProductReview review) { this.review = review; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public VoteType getVoteType() { return voteType; }
    public void setVoteType(VoteType voteType) { this.voteType = voteType; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public enum VoteType {
        HELPFUL, NOT_HELPFUL
    }
}

