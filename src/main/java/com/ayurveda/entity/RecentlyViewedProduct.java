package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "recently_viewed_products", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"user_id", "product_id"})
})
public class RecentlyViewedProduct {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @Column(updatable = false)
    private LocalDateTime viewedAt;

    public RecentlyViewedProduct() {}

    @PrePersist
    protected void onCreate() {
        viewedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public LocalDateTime getViewedAt() { return viewedAt; }
    public void setViewedAt(LocalDateTime viewedAt) { this.viewedAt = viewedAt; }
}

