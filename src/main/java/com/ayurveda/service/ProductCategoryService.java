package com.ayurveda.service;

import com.ayurveda.entity.ProductCategory;
import com.ayurveda.repository.ProductCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.annotation.PostConstruct;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ProductCategoryService {

    @Autowired
    private ProductCategoryRepository categoryRepository;

    // ==================== Initialize Default Categories ====================

    @PostConstruct
    public void initDefaultCategories() {
        if (categoryRepository.count() == 0) {
            createDefaultCategories();
        }
    }

    private void createDefaultCategories() {
        String[][] defaultCategories = {
            {"Ayurvedic Medicines", "ayurvedic-medicines", "Traditional Ayurvedic medicines and formulations", "fa-pills"},
            {"Herbal Supplements", "herbal-supplements", "Natural herbal supplements for health and wellness", "fa-leaf"},
            {"Personal Care", "personal-care", "Ayurvedic personal care and hygiene products", "fa-pump-soap"},
            {"Hair Care", "hair-care", "Natural hair care oils, shampoos and treatments", "fa-head-side"},
            {"Skin Care", "skin-care", "Herbal skin care creams, lotions and treatments", "fa-spa"},
            {"Health Foods", "health-foods", "Organic and Ayurvedic health food products", "fa-apple-alt"},
            {"Wellness Products", "wellness-products", "Products for overall wellness and immunity", "fa-heart"},
            {"Yoga & Fitness", "yoga-fitness", "Yoga accessories and fitness products", "fa-om"},
            {"Herbal Oils", "herbal-oils", "Traditional massage and therapeutic oils", "fa-oil-can"},
            {"Herbal Teas", "herbal-teas", "Ayurvedic and herbal tea blends", "fa-mug-hot"},
            {"Organic Products", "organic-products", "Certified organic Ayurvedic products", "fa-seedling"},
            {"Books & Literature", "books-literature", "Books on Ayurveda, Yoga and wellness", "fa-book"},
            {"Aromatherapy", "aromatherapy", "Essential oils and aromatherapy products", "fa-wind"},
            {"Weight Management", "weight-management", "Natural weight management supplements", "fa-weight"},
            {"Immunity Boosters", "immunity-boosters", "Products to boost natural immunity", "fa-shield-virus"}
        };

        int sortOrder = 1;
        for (String[] cat : defaultCategories) {
            ProductCategory category = new ProductCategory();
            category.setName(cat[0]);
            category.setDisplayName(cat[0]);
            category.setSlug(cat[1]);
            category.setDescription(cat[2]);
            category.setIconClass(cat[3]);
            category.setIsDefault(true);
            category.setIsActive(true);
            category.setSortOrder(sortOrder++);
            category.setCreatedBy("System");
            categoryRepository.save(category);
        }
    }

    // ==================== CRUD Operations ====================

    public ProductCategory save(ProductCategory category) {
        return categoryRepository.save(category);
    }

    public Optional<ProductCategory> findById(Long id) {
        return categoryRepository.findById(id);
    }

    public Optional<ProductCategory> findByName(String name) {
        return categoryRepository.findByName(name);
    }

    public Optional<ProductCategory> findBySlug(String slug) {
        return categoryRepository.findBySlug(slug);
    }

    public List<ProductCategory> findAll() {
        return categoryRepository.findAll();
    }

    public void delete(Long id) {
        categoryRepository.deleteById(id);
    }

    // ==================== Active Categories ====================

    public List<ProductCategory> findActiveCategories() {
        return categoryRepository.findByIsActiveTrueOrderBySortOrderAsc();
    }

    public List<ProductCategory> findParentCategories() {
        return categoryRepository.findByParentIsNullAndIsActiveTrueOrderBySortOrderAsc();
    }

    public List<ProductCategory> findSubcategories(Long parentId) {
        return categoryRepository.findByParentIdAndIsActiveTrueOrderBySortOrderAsc(parentId);
    }

    public List<ProductCategory> findDefaultCategories() {
        return categoryRepository.findByIsDefaultTrueAndIsActiveTrueOrderBySortOrderAsc();
    }

    public List<ProductCategory> findCustomCategories() {
        return categoryRepository.findByIsCustomTrueAndIsActiveTrueOrderByNameAsc();
    }

    // ==================== Search ====================

    public List<ProductCategory> searchCategories(String keyword) {
        return categoryRepository.searchCategories(keyword);
    }

    // ==================== Create Custom Category ====================

    public ProductCategory createCustomCategory(String name, String createdBy) {
        // Check if category already exists
        Optional<ProductCategory> existing = categoryRepository.findByName(name);
        if (existing.isPresent()) {
            return existing.get();
        }

        ProductCategory category = new ProductCategory();
        category.setName(name);
        category.setDisplayName(name);
        category.setSlug(name.toLowerCase().replaceAll("[^a-z0-9]+", "-"));
        category.setIsDefault(false);
        category.setIsCustom(true);
        category.setIsActive(true);
        category.setCreatedBy(createdBy);
        category.setSortOrder(100); // Custom categories at the end

        return categoryRepository.save(category);
    }

    // ==================== Validation ====================

    public boolean existsByName(String name) {
        return categoryRepository.existsByName(name);
    }

    public boolean existsBySlug(String slug) {
        return categoryRepository.existsBySlug(slug);
    }

    // ==================== Product Count ====================

    public void incrementProductCount(Long categoryId) {
        ProductCategory category = categoryRepository.findById(categoryId).orElse(null);
        if (category != null) {
            category.setProductCount(category.getProductCount() + 1);
            categoryRepository.save(category);
        }
    }

    public void decrementProductCount(Long categoryId) {
        ProductCategory category = categoryRepository.findById(categoryId).orElse(null);
        if (category != null && category.getProductCount() > 0) {
            category.setProductCount(category.getProductCount() - 1);
            categoryRepository.save(category);
        }
    }

    // ==================== Toggle Status ====================

    public ProductCategory toggleActive(Long categoryId) {
        ProductCategory category = categoryRepository.findById(categoryId)
                .orElseThrow(() -> new RuntimeException("Category not found"));
        category.setIsActive(!category.getIsActive());
        return categoryRepository.save(category);
    }
}

