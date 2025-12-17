package com.ayurveda.controller;

import com.ayurveda.entity.*;
import com.ayurveda.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
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

    @Autowired
    private ProductQuestionService questionService;

    @Autowired
    private ProductAnswerService answerService;

    @Autowired
    private ProductOfferService offerService;

    @Autowired
    private ProductVariantService variantService;

    @Autowired
    private ReviewHelpfulVoteService helpfulVoteService;

    @Autowired
    private RecentlyViewedService recentlyViewedService;

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
        User user = getCurrentUserFromContext();
        if (user != null) {
            model.addAttribute("currentUser", user);
            model.addAttribute("cartCount", cartService.getCartItemCount(user.getId()));
            model.addAttribute("wishlistIds", getWishlistProductIds(user.getId()));
            // Get recently viewed products
            var recentViews = recentlyViewedService.getRecentViews(user, 5);
            model.addAttribute("recentViews", recentViews);
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
    public String productDetails(@PathVariable String slug, 
                                 Model model,
                                 jakarta.servlet.http.HttpServletRequest request) {
        try {
            // Try to find by slug first, if not found, try by ID
            Product product = productService.findBySlug(slug).orElse(null);
            
            // If not found by slug, try to parse as ID
            if (product == null) {
                try {
                    Long productId = Long.parseLong(slug);
                    product = productService.findById(productId)
                            .orElseThrow(() -> new RuntimeException("Product not found"));
                } catch (NumberFormatException e) {
                    throw new RuntimeException("Product not found");
                }
            }
            
            // Check if product is active and available
            if (product == null || (!Boolean.TRUE.equals(product.getIsActive()) || !Boolean.TRUE.equals(product.getIsAvailable()))) {
                throw new RuntimeException("Product not available");
            }

            // Increment view count
            productService.incrementViews(product.getId());

            // Get reviews
            List<ProductReview> reviews = reviewService != null ? reviewService.getProductReviews(product.getId()) : new java.util.ArrayList<>();

            // Get similar products
            List<Product> similarProducts = null;
            if (product.getCategory() != null) {
                similarProducts = productService.getSimilarProducts(product.getCategory().getId(), product.getId(), 4);
            }

            // Get rating distribution
            var ratingDistribution = reviewService != null ? reviewService.getRatingDistribution(product.getId()) : new java.util.HashMap<>();

            // Get Q&A
            var questions = questionService != null ? questionService.getProductQuestions(product.getId()) : new java.util.ArrayList<>();
            var questionCount = questionService != null ? questionService.getQuestionCount(product.getId()) : 0L;

            // Get offers
            var productOffers = offerService != null ? offerService.getProductOffers(product.getId()) : new java.util.ArrayList<>();
            var globalOffers = offerService != null ? offerService.getGlobalOffers() : new java.util.ArrayList<>();

            // Get variants
            var variants = variantService != null ? variantService.getVariantsGroupedByType(product.getId()) : new java.util.HashMap<>();

            // Get recently viewed
            User user = getCurrentUserFromContext();
            
            // Also try to get user from session if SecurityContext doesn't have it
            // This is important because public pages might not have SecurityContext set properly
            if (user == null && request != null) {
                try {
                    jakarta.servlet.http.HttpSession session = request.getSession(false);
                    if (session != null) {
                        Long userId = (Long) session.getAttribute("userId");
                        if (userId != null) {
                            user = userService.findById(userId).orElse(null);
                        }
                    }
                } catch (Exception e) {
                    // Ignore - user will remain null
                    e.printStackTrace();
                }
            }
            
            if (user != null && recentlyViewedService != null) {
                recentlyViewedService.recordView(user, product.getId());
                var recentViews = recentlyViewedService.getRecentViews(user, 10);
                model.addAttribute("recentViews", recentViews);
            }

            // User info - ALWAYS set currentUser if user exists
            if (user != null) {
                model.addAttribute("currentUser", user);
                if (cartService != null) {
                    model.addAttribute("cartCount", cartService.getCartItemCount(user.getId()));
                    model.addAttribute("inCart", cartService.isInCart(user.getId(), product.getId()));
                }
                if (wishlistService != null) {
                    model.addAttribute("inWishlist", wishlistService.isInWishlist(user.getId(), product.getId()));
                }
                if (reviewService != null) {
                    model.addAttribute("hasReviewed", reviewService.hasUserReviewed(product.getId(), user.getId()));
                }
            } else {
                // Explicitly set currentUser to null to ensure JSP knows user is not logged in
                model.addAttribute("currentUser", null);
            }

            model.addAttribute("product", product);
            model.addAttribute("reviews", reviews);
            model.addAttribute("similarProducts", similarProducts);
            model.addAttribute("ratingDistribution", ratingDistribution);
            model.addAttribute("productImages", productService.getProductImages(product.getId()));
            model.addAttribute("questions", questions);
            model.addAttribute("questionCount", questionCount);
            model.addAttribute("productOffers", productOffers);
            model.addAttribute("globalOffers", globalOffers);
            model.addAttribute("variants", variants);

            return "public/product-details";
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error loading product: " + e.getMessage(), e);
        }
    }

    // ==================== Shop by Category ====================

    @RequestMapping(value = "/products/category/{slug}", method = RequestMethod.GET)
    public String productsByCategory(@PathVariable String slug,
                                     @RequestParam(defaultValue = "0") int page,
                                     @RequestParam(defaultValue = "12") int size,
                                     @RequestParam(defaultValue = "newest") String sort,
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

        User user = getCurrentUserFromContext();
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
        Product product = productService.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));
        // Eagerly load necessary relationships to avoid lazy loading issues
        if (product.getCategory() != null) {
            product.getCategory().getDisplayName(); // Trigger lazy load
        }
        if (product.getVendor() != null) {
            product.getVendor().getStoreDisplayName(); // Trigger lazy load
        }
        return product;
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
    
    private User getCurrentUserFromContext() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return getCurrentUser(authentication);
    }

    private List<Long> getWishlistProductIds(Long userId) {
        return wishlistService.getWishlistItems(userId).stream()
                .map(w -> w.getProduct().getId())
                .toList();
    }
}

