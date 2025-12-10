package com.ayurveda.repository;

import com.ayurveda.entity.Wishlist;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface WishlistRepository extends JpaRepository<Wishlist, Long> {

    List<Wishlist> findByUserIdOrderByAddedAtDesc(Long userId);

    Optional<Wishlist> findByUserIdAndProductId(Long userId, Long productId);

    boolean existsByUserIdAndProductId(Long userId, Long productId);

    int countByUserId(Long userId);

    @Modifying
    void deleteByUserIdAndProductId(Long userId, Long productId);

    @Modifying
    @Query("DELETE FROM Wishlist w WHERE w.user.id = :userId")
    void deleteAllByUserId(Long userId);

    // Find users who have a product in wishlist (for notifications)
    @Query("SELECT w.user.id FROM Wishlist w WHERE w.product.id = :productId")
    List<Long> findUserIdsByProductId(Long productId);
}

