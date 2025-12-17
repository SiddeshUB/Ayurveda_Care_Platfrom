package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "product_answers")
public class ProductAnswer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id", nullable = false)
    private ProductQuestion question;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String answer;

    private Boolean isVendorAnswer = false; // If answered by product vendor

    private Integer helpfulCount = 0;

    private Integer notHelpfulCount = 0;

    @Enumerated(EnumType.STRING)
    private AnswerStatus status = AnswerStatus.ACTIVE;

    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    public ProductAnswer() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (status == null) status = AnswerStatus.ACTIVE;
        if (isVendorAnswer == null) isVendorAnswer = false;
        if (helpfulCount == null) helpfulCount = 0;
        if (notHelpfulCount == null) notHelpfulCount = 0;
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public ProductQuestion getQuestion() { return question; }
    public void setQuestion(ProductQuestion question) { this.question = question; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public String getAnswer() { return answer; }
    public void setAnswer(String answer) { this.answer = answer; }

    public Boolean getIsVendorAnswer() { return isVendorAnswer; }
    public void setIsVendorAnswer(Boolean isVendorAnswer) { this.isVendorAnswer = isVendorAnswer; }

    public Integer getHelpfulCount() { return helpfulCount; }
    public void setHelpfulCount(Integer helpfulCount) { this.helpfulCount = helpfulCount; }

    public Integer getNotHelpfulCount() { return notHelpfulCount; }
    public void setNotHelpfulCount(Integer notHelpfulCount) { this.notHelpfulCount = notHelpfulCount; }

    public AnswerStatus getStatus() { return status; }
    public void setStatus(AnswerStatus status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public enum AnswerStatus {
        ACTIVE, HIDDEN, DELETED
    }
}

