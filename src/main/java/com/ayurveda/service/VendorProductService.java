package com.ayurveda.service;

import com.ayurveda.entity.Product;
import com.ayurveda.entity.ProductCategory;
import com.ayurveda.entity.ProductImage;
import com.ayurveda.entity.Vendor;
import com.ayurveda.repository.ProductRepository;
import com.ayurveda.repository.ProductImageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class VendorProductService {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ProductImageRepository productImageRepository;

    @Autowired
    private VendorService vendorService;

    @Autowired
    private ProductCategoryService categoryService;

    @Value("${file.upload-dir:uploads}")
    private String uploadDir;

    // ==================== CRUD Operations ====================

    public Product createProduct(Product product, Vendor vendor) {
        product.setVendor(vendor);
        product.setIsActive(true);
        product.setIsAvailable(true);
        // hospitalId is now nullable after running fix_products_table.sql

        Product savedProduct = productRepository.save(product);

        // Update vendor product count
        vendorService.incrementProductCount(vendor.getId());

        // Update category product count
        if (product.getCategory() != null) {
            categoryService.incrementProductCount(product.getCategory().getId());
        }

        return savedProduct;
    }

    public Product save(Product product) {
        return productRepository.save(product);
    }

    public Optional<Product> findById(Long id) {
        return productRepository.findById(id);
    }

    public Optional<Product> findBySku(String sku) {
        return productRepository.findBySku(sku);
    }

    public Optional<Product> findBySlug(String slug) {
        return productRepository.findBySlug(slug);
    }

    public void delete(Long productId, Long vendorId) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        if (!product.getVendor().getId().equals(vendorId)) {
            throw new RuntimeException("Unauthorized: Product does not belong to this vendor");
        }

        // Update counts
        vendorService.decrementProductCount(vendorId);
        if (product.getCategory() != null) {
            categoryService.decrementProductCount(product.getCategory().getId());
        }

        productRepository.delete(product);
    }

    // ==================== Find by Vendor ====================

    public List<Product> findByVendorId(Long vendorId) {
        return productRepository.findByVendorId(vendorId);
    }

    public Page<Product> findByVendorId(Long vendorId, Pageable pageable) {
        return productRepository.findByVendorId(vendorId, pageable);
    }

    public List<Product> findActiveByVendorId(Long vendorId) {
        return productRepository.findByVendorIdAndIsActiveTrue(vendorId);
    }

    public List<Product> findAvailableByVendorId(Long vendorId) {
        return productRepository.findByVendorIdAndIsActiveTrueAndIsAvailableTrue(vendorId);
    }

    // ==================== Find by Category ====================

    public List<Product> findByCategory(Long categoryId) {
        return productRepository.findByCategoryIdAndIsActiveTrueAndIsAvailableTrue(categoryId);
    }

    public Page<Product> findByCategory(Long categoryId, Pageable pageable) {
        return productRepository.findByCategoryIdAndIsActiveTrueAndIsAvailableTrue(categoryId, pageable);
    }

    // ==================== Featured & Special Products ====================

    public List<Product> findFeaturedProducts() {
        return productRepository.findByIsFeaturedTrueAndIsActiveTrueAndIsAvailableTrueOrderBySortOrderAsc();
    }

    public List<Product> findNewArrivals() {
        return productRepository.findByIsNewTrueAndIsActiveTrueAndIsAvailableTrueOrderByCreatedAtDesc();
    }

    public List<Product> findBestSellers() {
        return productRepository.findByIsBestSellerTrueAndIsActiveTrueAndIsAvailableTrueOrderByTotalSalesDesc();
    }

    public List<Product> findProductsOnDiscount() {
        return productRepository.findProductsOnDiscount();
    }

    // ==================== Search & Filter ====================

    public Page<Product> searchProducts(String keyword, Pageable pageable) {
        return productRepository.searchProducts(keyword, pageable);
    }

    public Page<Product> findWithFilters(Long categoryId, Long vendorId, 
                                         BigDecimal minPrice, BigDecimal maxPrice, 
                                         Double minRating, Pageable pageable) {
        return productRepository.findWithFilters(categoryId, vendorId, minPrice, maxPrice, minRating, pageable);
    }

    public Page<Product> findAllActiveProducts(Pageable pageable) {
        return productRepository.findByIsActiveTrueAndIsAvailableTrue(pageable);
    }

    // ==================== Inventory Management ====================

    public List<Product> findLowStockProducts(Long vendorId) {
        return productRepository.findLowStockByVendorId(vendorId);
    }

    public List<Product> findOutOfStockProducts(Long vendorId) {
        return productRepository.findOutOfStockByVendorId(vendorId);
    }

    public void updateStock(Long productId, int quantity) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        product.setStockQuantity(quantity);

        // Auto-disable if out of stock
        if (product.getTrackInventory() && quantity <= 0) {
            product.setIsAvailable(false);
        } else if (quantity > 0) {
            product.setIsAvailable(true);
        }

        productRepository.save(product);
    }

    public void reduceStock(Long productId, int quantity) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        if (product.getTrackInventory()) {
            int newStock = product.getStockQuantity() - quantity;
            product.setStockQuantity(Math.max(0, newStock));

            if (newStock <= 0) {
                product.setIsAvailable(false);
            }

            productRepository.save(product);
        }
    }

    // ==================== Toggle Status ====================

    public Product toggleActive(Long productId, Long vendorId) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        if (!product.getVendor().getId().equals(vendorId)) {
            throw new RuntimeException("Unauthorized");
        }

        product.setIsActive(!product.getIsActive());
        return productRepository.save(product);
    }

    public Product toggleFeatured(Long productId, Long vendorId) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        if (!product.getVendor().getId().equals(vendorId)) {
            throw new RuntimeException("Unauthorized");
        }

        product.setIsFeatured(!product.getIsFeatured());
        return productRepository.save(product);
    }

    // ==================== Image Management ====================

    public String uploadProductImage(MultipartFile file, Long productId) throws IOException {
        if (file == null || file.isEmpty()) {
            throw new IOException("File is empty or null");
        }
        
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        // Sanitize filename - remove special characters and spaces
        String originalFilename = file.getOriginalFilename();
        if (originalFilename == null || originalFilename.trim().isEmpty()) {
            originalFilename = "image";
        }
        
        // Get file extension
        String extension = "";
        int lastDot = originalFilename.lastIndexOf('.');
        if (lastDot > 0 && lastDot < originalFilename.length() - 1) {
            extension = originalFilename.substring(lastDot);
        }
        
        // Generate unique filename with sanitized original name
        String sanitizedBaseName = originalFilename.substring(0, lastDot > 0 ? lastDot : originalFilename.length())
                .replaceAll("[^a-zA-Z0-9._-]", "_")
                .replaceAll("\\s+", "_");
        
        String fileName = UUID.randomUUID().toString() + "_" + sanitizedBaseName + extension;
        
        // Get upload path - use same logic as FileStorageService for Tomcat compatibility
        Path rootUploadPath = getUploadRootPath();
        Path uploadPath = rootUploadPath.resolve("products");

        // Ensure directory exists
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        // Save file
        Path filePath = uploadPath.resolve(fileName);
        try {
            Files.copy(file.getInputStream(), filePath, java.nio.file.StandardCopyOption.REPLACE_EXISTING);
            
            // Verify file was saved
            if (!Files.exists(filePath) || !Files.isRegularFile(filePath)) {
                throw new IOException("Failed to save file: " + filePath);
            }
        } catch (IOException e) {
            System.err.println("Error saving product image: " + e.getMessage());
            System.err.println("Upload path: " + uploadPath);
            System.err.println("File path: " + filePath);
            throw new IOException("Failed to save product image: " + e.getMessage(), e);
        }

        String imageUrl = "/uploads/products/" + fileName;

        // Save as product image
        ProductImage productImage = new ProductImage(product, imageUrl, false);
        productImageRepository.save(productImage);

        // If this is the first image, set as main image
        if (product.getImageUrl() == null || product.getImageUrl().isEmpty()) {
            product.setImageUrl(imageUrl);
            productImage.setIsFeatured(true);
            productRepository.save(product);
            productImageRepository.save(productImage);
        }

        return imageUrl;
    }
    
    /**
     * Get the root upload directory path - handles Tomcat external directory
     * This ensures files are stored outside WAR and persist across deployments
     */
    private Path getUploadRootPath() {
        // Check if uploadDir is absolute or relative
        if (Paths.get(uploadDir).isAbsolute()) {
            // Absolute path specified in config
            return Paths.get(uploadDir);
        } else {
            // Check if running in Tomcat
            String catalinaBase = System.getProperty("catalina.base");
            if (catalinaBase != null && !catalinaBase.isEmpty()) {
                // Running in Tomcat - use external directory (outside WAR)
                // This ensures files persist across deployments
                return Paths.get(catalinaBase, "uploads");
            } else {
                // Development or embedded server - use relative path
                String projectRoot = System.getProperty("user.dir");
                return Paths.get(projectRoot, uploadDir);
            }
        }
    }

    public void setFeaturedImage(Long productId, Long imageId) {
        // Clear existing featured
        productImageRepository.clearFeaturedImage(productId);

        // Set new featured
        ProductImage image = productImageRepository.findById(imageId)
                .orElseThrow(() -> new RuntimeException("Image not found"));
        image.setIsFeatured(true);
        productImageRepository.save(image);

        // Update product main image
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));
        product.setImageUrl(image.getImageUrl());
        productRepository.save(product);
    }

    public void deleteProductImage(Long imageId) {
        ProductImage image = productImageRepository.findById(imageId)
                .orElseThrow(() -> new RuntimeException("Image not found"));

        // If this is the featured image, clear product main image
        if (image.getIsFeatured()) {
            Product product = image.getProduct();
            product.setImageUrl(null);
            productRepository.save(product);
        }

        productImageRepository.delete(image);
    }

    public List<ProductImage> getProductImages(Long productId) {
        return productImageRepository.findByProductIdOrderBySortOrderAsc(productId);
    }

    // ==================== Analytics ====================

    public void incrementViews(Long productId) {
        Product product = productRepository.findById(productId).orElse(null);
        if (product != null) {
            product.setTotalViews(product.getTotalViews() + 1);
            productRepository.save(product);
        }
    }

    public void incrementSales(Long productId, int quantity) {
        Product product = productRepository.findById(productId).orElse(null);
        if (product != null) {
            product.setTotalSales(product.getTotalSales() + quantity);
            productRepository.save(product);
        }
    }

    public List<Product> getTopSellingProducts(int limit) {
        return productRepository.findTopSellingProducts(PageRequest.of(0, limit));
    }

    public List<Product> getMostViewedProducts(int limit) {
        return productRepository.findMostViewedProducts(PageRequest.of(0, limit));
    }

    public List<Product> getSimilarProducts(Long categoryId, Long productId, int limit) {
        return productRepository.findSimilarProducts(categoryId, productId, PageRequest.of(0, limit));
    }

    // ==================== Counts ====================

    public long countByVendor(Long vendorId) {
        return productRepository.countByVendorId(vendorId);
    }

    public long countActiveByVendor(Long vendorId) {
        return productRepository.countByVendorIdAndIsActiveTrue(vendorId);
    }

    // ==================== Validation ====================

    public boolean existsBySku(String sku) {
        return productRepository.existsBySku(sku);
    }

    public boolean existsByVendorIdAndSku(Long vendorId, String sku) {
        return productRepository.existsByVendorIdAndSku(vendorId, sku);
    }
}

