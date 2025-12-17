package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "product_questions")
public class ProductQuestion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String question;

    @Enumerated(EnumType.STRING)
    private QuestionStatus status = QuestionStatus.ACTIVE;

    private Integer helpfulCount = 0;

    private Integer notHelpfulCount = 0;

    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "question", cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    private List<ProductAnswer> answers;

    public ProductQuestion() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (status == null) status = QuestionStatus.ACTIVE;
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

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public String getQuestion() { return question; }
    public void setQuestion(String question) { this.question = question; }

    public QuestionStatus getStatus() { return status; }
    public void setStatus(QuestionStatus status) { this.status = status; }

    public Integer getHelpfulCount() { return helpfulCount; }
    public void setHelpfulCount(Integer helpfulCount) { this.helpfulCount = helpfulCount; }

    public Integer getNotHelpfulCount() { return notHelpfulCount; }
    public void setNotHelpfulCount(Integer notHelpfulCount) { this.notHelpfulCount = notHelpfulCount; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public List<ProductAnswer> getAnswers() { return answers; }
    public void setAnswers(List<ProductAnswer> answers) { this.answers = answers; }

    public enum QuestionStatus {
        ACTIVE, HIDDEN, DELETED
    }
}

