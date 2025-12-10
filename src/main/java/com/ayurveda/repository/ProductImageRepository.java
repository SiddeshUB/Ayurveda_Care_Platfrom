package com.ayurveda.repository;

import com.ayurveda.entity.ProductImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProductImageRepository extends JpaRepository<ProductImage, Long> {

    List<ProductImage> findByProductIdOrderBySortOrderAsc(Long productId);

    Optional<ProductImage> findByProductIdAndIsFeaturedTrue(Long productId);

    int countByProductId(Long productId);

    @Modifying
    @Query("UPDATE ProductImage pi SET pi.isFeatured = false WHERE pi.product.id = :productId")
    void clearFeaturedImage(Long productId);

    @Modifying
    @Query("DELETE FROM ProductImage pi WHERE pi.product.id = :productId")
    void deleteByProductId(Long productId);
}

