package com.ayurveda.repository;

import com.ayurveda.entity.ProductCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProductCategoryRepository extends JpaRepository<ProductCategory, Long> {

    Optional<ProductCategory> findByName(String name);

    Optional<ProductCategory> findBySlug(String slug);

    boolean existsByName(String name);

    boolean existsBySlug(String slug);

    // Find all active categories
    List<ProductCategory> findByIsActiveTrueOrderBySortOrderAsc();

    // Find parent categories (no parent)
    List<ProductCategory> findByParentIsNullAndIsActiveTrueOrderBySortOrderAsc();

    // Find subcategories of a parent
    List<ProductCategory> findByParentIdAndIsActiveTrueOrderBySortOrderAsc(Long parentId);

    // Find default categories
    List<ProductCategory> findByIsDefaultTrueAndIsActiveTrueOrderBySortOrderAsc();

    // Find custom categories (added by vendors)
    List<ProductCategory> findByIsCustomTrueAndIsActiveTrueOrderByNameAsc();

    // Search categories
    @Query("SELECT c FROM ProductCategory c WHERE c.isActive = true AND " +
           "(LOWER(c.name) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(c.displayName) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    List<ProductCategory> searchCategories(String keyword);

    // Categories with products
    @Query("SELECT c FROM ProductCategory c WHERE c.isActive = true AND c.productCount > 0 ORDER BY c.productCount DESC")
    List<ProductCategory> findCategoriesWithProducts();
}

