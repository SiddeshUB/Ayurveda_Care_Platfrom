package com.ayurveda.service;

import com.ayurveda.entity.*;
import com.ayurveda.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Basic ProductService for public/admin product viewing.
 * For Vendor product management, use VendorProductService.
 */
@Service
public class ProductService {

    private final ProductRepository productRepository;

    @Autowired
    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    // ==================== Public Product Viewing ====================

    public List<Product> getAllActiveProducts() {
        return productRepository.findByIsActiveTrueAndIsAvailableTrue(Pageable.unpaged())
                .getContent();
    }

    public Page<Product> getAllActiveProducts(Pageable pageable) {
        return productRepository.findByIsActiveTrueAndIsAvailableTrue(pageable);
    }

    public List<Product> getFeaturedProducts() {
        return productRepository.findByIsFeaturedTrueAndIsActiveTrueAndIsAvailableTrueOrderBySortOrderAsc();
    }

    public List<Product> getNewArrivals() {
        return productRepository.findByIsNewTrueAndIsActiveTrueAndIsAvailableTrueOrderByCreatedAtDesc();
    }

    public List<Product> getBestSellers() {
        return productRepository.findByIsBestSellerTrueAndIsActiveTrueAndIsAvailableTrueOrderByTotalSalesDesc();
    }

    public List<Product> getProductsOnDiscount() {
        return productRepository.findProductsOnDiscount();
    }

    public Optional<Product> findById(Long productId) {
        return productRepository.findById(productId);
    }

    public Optional<Product> findBySku(String sku) {
        return productRepository.findBySku(sku);
    }

    public Optional<Product> findBySlug(String slug) {
        return productRepository.findBySlug(slug);
    }

    // ==================== Category-based Retrieval ====================

    public List<Product> getProductsByCategory(Long categoryId) {
        return productRepository.findByCategoryIdAndIsActiveTrueAndIsAvailableTrue(categoryId);
    }

    public Page<Product> getProductsByCategory(Long categoryId, Pageable pageable) {
        return productRepository.findByCategoryIdAndIsActiveTrueAndIsAvailableTrue(categoryId, pageable);
    }

    // ==================== Search ====================

    public Page<Product> searchProducts(String keyword, Pageable pageable) {
        return productRepository.searchProducts(keyword, pageable);
    }

    // ==================== Similar Products ====================

    public List<Product> getSimilarProducts(Long categoryId, Long excludeProductId, int limit) {
        return productRepository.findSimilarProducts(categoryId, excludeProductId, 
                Pageable.ofSize(limit)).stream().limit(limit).collect(Collectors.toList());
    }

    // ==================== Admin Methods ====================

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    public Page<Product> getAllProducts(Pageable pageable) {
        return productRepository.findAll(pageable);
    }

    @Transactional
    public Product toggleProductStatus(Long productId) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));
        product.setIsActive(!Boolean.TRUE.equals(product.getIsActive()));
        return productRepository.save(product);
    }

    @Transactional
    public Product toggleProductFeatured(Long productId) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));
        product.setIsFeatured(!Boolean.TRUE.equals(product.getIsFeatured()));
        return productRepository.save(product);
    }

    @Transactional
    public void deleteProduct(Long productId) {
        productRepository.deleteById(productId);
    }

    // ==================== Statistics ====================

    public long countAllProducts() {
        return productRepository.count();
    }
}
