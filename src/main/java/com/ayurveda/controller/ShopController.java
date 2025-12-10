package com.ayurveda.controller;

import com.ayurveda.entity.*;
import com.ayurveda.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/")
public class ShopController {

    @Autowired
    private VendorProductService productService;

    @Autowired
    private ProductCategoryService categoryService;

    @Autowired
    private ProductReviewService reviewService;

    @Autowired
    private CartService cartService;

    @Autowired
    private WishlistService wishlistService;

    @Autowired
    private UserService userService;

    // ==================== Product Catalog ====================

    @RequestMapping(value = "/products", method = RequestMethod.GET)
    public String productCatalog(
            @RequestParam(required = false) Long category,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) BigDecimal minPrice,
            @RequestParam(required = false) BigDecimal maxPrice,
            @RequestParam(required = false) Double rating,
            @RequestParam(defaultValue = "newest") String sort,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "12") int size,
            Authentication authentication,
            Model model) {

        // Build sort
        Sort sortBy;
        switch (sort) {
            case "price_low":
                sortBy = Sort.by("price").ascending();
                break;
            case "price_high":
                sortBy = Sort.by("price").descending();
                break;
            case "popular":
                sortBy = Sort.by("totalSales").descending();
                break;
            case "rating":
                sortBy = Sort.by("averageRating").descending();
                break;
            default:
                sortBy = Sort.by("createdAt").descending();
        }

        Page<Product> products;
        if (search != null && !search.trim().isEmpty()) {
            products = productService.searchProducts(search.trim(), PageRequest.of(page, size, sortBy));
            model.addAttribute("searchTerm", search);
        } else if (category != null || minPrice != null || maxPrice != null || rating != null) {
            products = productService.findWithFilters(category, null, minPrice, maxPrice, rating, PageRequest.of(page, size, sortBy));
        } else {
            products = productService.findAllActiveProducts(PageRequest.of(page, size, sortBy));
        }

        // Get categories for filter
        List<ProductCategory> categories = categoryService.findActiveCategories();

        // Get user's wishlist and cart count
        User user = getCurrentUser(authentication);
        if (user != null) {
            model.addAttribute("currentUser", user);
            model.addAttribute("cartCount", cartService.getCartItemCount(user.getId()));
            model.addAttribute("wishlistIds", getWishlistProductIds(user.getId()));
        }

        model.addAttribute("products", products);
        model.addAttribute("categories", categories);
        model.addAttribute("selectedCategory", category);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("selectedRating", rating);
        model.addAttribute("currentSort", sort);

        // Featured products for sidebar
        model.addAttribute("featuredProducts", productService.findFeaturedProducts());

        return "public/products";
    }

    // ==================== Product Details ====================

    @RequestMapping(value = "/products/{slug}", method = RequestMethod.GET)
    public String productDetails(@PathVariable String slug, Authentication authentication, Model model) {
        Product product = productService.findBySlug(slug)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        // Increment view count
        productService.incrementViews(product.getId());

        // Get reviews
        List<ProductReview> reviews = reviewService.getProductReviews(product.getId());

        // Get similar products
        List<Product> similarProducts = null;
        if (product.getCategory() != null) {
            similarProducts = productService.getSimilarProducts(product.getCategory().getId(), product.getId(), 4);
        }

        // Get rating distribution
        var ratingDistribution = reviewService.getRatingDistribution(product.getId());

        // User info
        User user = getCurrentUser(authentication);
        if (user != null) {
            model.addAttribute("currentUser", user);
            model.addAttribute("cartCount", cartService.getCartItemCount(user.getId()));
            model.addAttribute("inWishlist", wishlistService.isInWishlist(user.getId(), product.getId()));
            model.addAttribute("inCart", cartService.isInCart(user.getId(), product.getId()));
            model.addAttribute("hasReviewed", reviewService.hasUserReviewed(product.getId(), user.getId()));
        }

        model.addAttribute("product", product);
        model.addAttribute("reviews", reviews);
        model.addAttribute("similarProducts", similarProducts);
        model.addAttribute("ratingDistribution", ratingDistribution);
        model.addAttribute("productImages", productService.getProductImages(product.getId()));

        return "public/product-details";
    }

    // ==================== Shop by Category ====================

    @RequestMapping(value = "/products/category/{slug}", method = RequestMethod.GET)
    public String productsByCategory(@PathVariable String slug,
                                     @RequestParam(defaultValue = "0") int page,
                                     @RequestParam(defaultValue = "12") int size,
                                     @RequestParam(defaultValue = "newest") String sort,
                                     Authentication authentication,
                                     Model model) {

        ProductCategory category = categoryService.findBySlug(slug)
                .orElseThrow(() -> new RuntimeException("Category not found"));

        Sort sortBy;
        switch (sort) {
            case "price_low": sortBy = Sort.by("price").ascending(); break;
            case "price_high": sortBy = Sort.by("price").descending(); break;
            case "popular": sortBy = Sort.by("totalSales").descending(); break;
            default: sortBy = Sort.by("createdAt").descending();
        }

        Page<Product> products = productService.findByCategory(category.getId(), PageRequest.of(page, size, sortBy));

        model.addAttribute("category", category);
        model.addAttribute("products", products);
        model.addAttribute("categories", categoryService.findActiveCategories());
        model.addAttribute("currentSort", sort);

        User user = getCurrentUser(authentication);
        if (user != null) {
            model.addAttribute("currentUser", user);
            model.addAttribute("cartCount", cartService.getCartItemCount(user.getId()));
        }

        return "public/products-category";
    }

    // ==================== Quick View (AJAX) ====================

    @RequestMapping(value = "/products/{id}/quick-view", method = RequestMethod.GET)
    @ResponseBody
    public Product quickView(@PathVariable Long id) {
        return productService.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));
    }

    // ==================== Helper Methods ====================

    private User getCurrentUser(Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated() 
                && !"anonymousUser".equals(authentication.getPrincipal())) {
            String email = authentication.getName();
            return userService.findByEmail(email).orElse(null);
        }
        return null;
    }

    private List<Long> getWishlistProductIds(Long userId) {
        return wishlistService.getWishlistItems(userId).stream()
                .map(w -> w.getProduct().getId())
                .toList();
    }
}

