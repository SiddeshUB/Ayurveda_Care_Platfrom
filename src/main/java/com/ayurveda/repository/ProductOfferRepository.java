package com.ayurveda.repository;

import com.ayurveda.entity.ProductOffer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ProductOfferRepository extends JpaRepository<ProductOffer, Long> {
    
    List<ProductOffer> findByProductIdOrderBySortOrderAsc(Long productId);
    
    @Query("SELECT o FROM ProductOffer o WHERE (o.product.id = :productId OR o.product IS NULL) AND o.status = 'ACTIVE' AND (o.validFrom IS NULL OR o.validFrom <= :now) AND (o.validUntil IS NULL OR o.validUntil >= :now) ORDER BY o.sortOrder ASC, o.createdAt DESC")
    List<ProductOffer> findActiveOffersForProduct(@Param("productId") Long productId, @Param("now") LocalDateTime now);
    
    @Query("SELECT o FROM ProductOffer o WHERE o.product IS NULL AND o.status = 'ACTIVE' AND (o.validFrom IS NULL OR o.validFrom <= :now) AND (o.validUntil IS NULL OR o.validUntil >= :now) ORDER BY o.sortOrder ASC")
    List<ProductOffer> findActiveGlobalOffers(@Param("now") LocalDateTime now);
    
    List<ProductOffer> findByOfferTypeAndStatusOrderBySortOrderAsc(ProductOffer.OfferType offerType, ProductOffer.OfferStatus status);
}

