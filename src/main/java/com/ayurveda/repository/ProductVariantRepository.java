package com.ayurveda.repository;

import com.ayurveda.entity.ProductVariant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProductVariantRepository extends JpaRepository<ProductVariant, Long> {
    
    List<ProductVariant> findByProductIdOrderByVariantTypeAscSortOrderAsc(Long productId);
    
    List<ProductVariant> findByProductIdAndIsActiveTrueOrderByVariantTypeAscSortOrderAsc(Long productId);
    
    List<ProductVariant> findByProductIdAndVariantTypeOrderBySortOrderAsc(Long productId, ProductVariant.VariantType variantType);
    
    @Query("SELECT DISTINCT v.variantType FROM ProductVariant v WHERE v.product.id = :productId AND v.isActive = true")
    List<ProductVariant.VariantType> findDistinctVariantTypesByProductId(@Param("productId") Long productId);
    
    Optional<ProductVariant> findByProductIdAndIsDefaultTrue(Long productId);
    
    Optional<ProductVariant> findByIdAndIsActiveTrue(Long id);
}

