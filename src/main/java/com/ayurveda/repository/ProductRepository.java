package com.ayurveda.repository;

import com.ayurveda.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    // Find by vendor
    List<Product> findByVendorId(Long vendorId);

    Page<Product> findByVendorId(Long vendorId, Pageable pageable);

    List<Product> findByVendorIdAndIsActiveTrue(Long vendorId);

    List<Product> findByVendorIdAndIsActiveTrueAndIsAvailableTrue(Long vendorId);

    // Find by category
    List<Product> findByCategoryIdAndIsActiveTrueAndIsAvailableTrue(Long categoryId);

    Page<Product> findByCategoryIdAndIsActiveTrueAndIsAvailableTrue(Long categoryId, Pageable pageable);

    // Find by vendor and category
    List<Product> findByVendorIdAndCategoryId(Long vendorId, Long categoryId);

    // Featured products
    List<Product> findByIsFeaturedTrueAndIsActiveTrueAndIsAvailableTrueOrderBySortOrderAsc();

    List<Product> findByVendorIdAndIsFeaturedTrue(Long vendorId);

    // New arrivals
    List<Product> findByIsNewTrueAndIsActiveTrueAndIsAvailableTrueOrderByCreatedAtDesc();

    // Best sellers
    List<Product> findByIsBestSellerTrueAndIsActiveTrueAndIsAvailableTrueOrderByTotalSalesDesc();

    // SKU related
    Optional<Product> findBySku(String sku);

    Optional<Product> findBySlug(String slug);

    Optional<Product> findByVendorIdAndSku(Long vendorId, String sku);

    boolean existsBySku(String sku);

    boolean existsByVendorIdAndSku(Long vendorId, String sku);

    // Active and available products for storefront
    Page<Product> findByIsActiveTrueAndIsAvailableTrue(Pageable pageable);

    // Search products
    @Query("SELECT p FROM Product p WHERE p.isActive = true AND p.isAvailable = true AND " +
           "(LOWER(p.productName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(p.description) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(p.tags) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(p.brand) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    Page<Product> searchProducts(@Param("keyword") String keyword, Pageable pageable);

    // Filter by price range
    @Query("SELECT p FROM Product p WHERE p.isActive = true AND p.isAvailable = true AND p.price BETWEEN :minPrice AND :maxPrice")
    Page<Product> findByPriceRange(@Param("minPrice") BigDecimal minPrice, @Param("maxPrice") BigDecimal maxPrice, Pageable pageable);

    // Filter by rating
    @Query("SELECT p FROM Product p WHERE p.isActive = true AND p.isAvailable = true AND p.averageRating >= :minRating")
    Page<Product> findByMinRating(@Param("minRating") Double minRating, Pageable pageable);

    // Complex filter
    @Query("SELECT p FROM Product p WHERE p.isActive = true AND p.isAvailable = true " +
           "AND (:categoryId IS NULL OR p.category.id = :categoryId) " +
           "AND (:vendorId IS NULL OR p.vendor.id = :vendorId) " +
           "AND (:minPrice IS NULL OR p.price >= :minPrice) " +
           "AND (:maxPrice IS NULL OR p.price <= :maxPrice) " +
           "AND (:minRating IS NULL OR p.averageRating >= :minRating)")
    Page<Product> findWithFilters(@Param("categoryId") Long categoryId,
                                   @Param("vendorId") Long vendorId,
                                   @Param("minPrice") BigDecimal minPrice,
                                   @Param("maxPrice") BigDecimal maxPrice,
                                   @Param("minRating") Double minRating,
                                   Pageable pageable);

    // Low stock products
    @Query("SELECT p FROM Product p WHERE p.vendor.id = :vendorId AND p.isActive = true AND p.trackInventory = true AND p.stockQuantity <= p.minStockLevel")
    List<Product> findLowStockByVendorId(@Param("vendorId") Long vendorId);

    // Out of stock products
    @Query("SELECT p FROM Product p WHERE p.vendor.id = :vendorId AND p.isActive = true AND p.trackInventory = true AND p.stockQuantity <= 0")
    List<Product> findOutOfStockByVendorId(@Param("vendorId") Long vendorId);

    // Count products by vendor
    long countByVendorId(Long vendorId);

    long countByVendorIdAndIsActiveTrue(Long vendorId);

    // Top selling products
    @Query("SELECT p FROM Product p WHERE p.isActive = true ORDER BY p.totalSales DESC")
    List<Product> findTopSellingProducts(Pageable pageable);

    // Most viewed products
    @Query("SELECT p FROM Product p WHERE p.isActive = true ORDER BY p.totalViews DESC")
    List<Product> findMostViewedProducts(Pageable pageable);

    // Find by ID with eager fetching of vendor and category (for admin/view pages)
    @Query("SELECT p FROM Product p LEFT JOIN FETCH p.vendor LEFT JOIN FETCH p.category WHERE p.id = :id")
    Optional<Product> findByIdWithRelations(@Param("id") Long id);

    // Products on discount
    @Query("SELECT p FROM Product p WHERE p.isActive = true AND p.isAvailable = true AND p.discountPrice IS NOT NULL AND p.discountPrice > 0 AND p.discountPrice < p.price")
    List<Product> findProductsOnDiscount();

    // Similar products (same category, excluding current product)
    @Query("SELECT p FROM Product p WHERE p.category.id = :categoryId AND p.id != :productId AND p.isActive = true AND p.isAvailable = true ORDER BY p.totalSales DESC")
    List<Product> findSimilarProducts(@Param("categoryId") Long categoryId, @Param("productId") Long productId, Pageable pageable);
}
