package com.ayurveda.controller;

import com.ayurveda.entity.*;
import com.ayurveda.entity.Vendor.BusinessType;
import com.ayurveda.entity.Vendor.AccountType;
import com.ayurveda.entity.VendorDocument.DocumentType;
import com.ayurveda.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/vendor")
public class VendorController {

    @Autowired
    private VendorService vendorService;

    @Autowired
    private VendorDocumentService documentService;

    @Autowired
    private VendorProductService productService;

    @Autowired
    private ProductCategoryService categoryService;

    @Autowired
    private ProductOrderService orderService;

    @Autowired
    private VendorWalletService walletService;

    @Autowired
    private ProductReviewService reviewService;

    // ==================== Authentication ====================

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(HttpSession session) {
        if (session.getAttribute("vendor") != null) {
            return "redirect:/vendor/dashboard";
        }
        return "vendor/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email,
                       @RequestParam String password,
                       HttpSession session,
                       RedirectAttributes redirectAttributes) {
        try {
            Vendor vendor = vendorService.authenticate(email, password)
                    .orElseThrow(() -> new RuntimeException("Invalid email or password"));

            if (vendor.getStatus() == Vendor.VendorStatus.PENDING) {
                redirectAttributes.addFlashAttribute("warning", "Your account is pending approval. Please wait for admin verification.");
                return "redirect:/vendor/login";
            }

            if (vendor.getStatus() == Vendor.VendorStatus.REJECTED) {
                redirectAttributes.addFlashAttribute("error", "Your account has been rejected. Reason: " + vendor.getRejectionReason());
                return "redirect:/vendor/login";
            }

            if (vendor.getStatus() == Vendor.VendorStatus.SUSPENDED || vendor.getStatus() == Vendor.VendorStatus.BLOCKED) {
                redirectAttributes.addFlashAttribute("error", "Your account has been suspended. Please contact support.");
                return "redirect:/vendor/login";
            }

            session.setAttribute("vendor", vendor);
            session.setAttribute("vendorId", vendor.getId());
            return "redirect:/vendor/dashboard";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/vendor/login";
        }
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.removeAttribute("vendor");
        session.removeAttribute("vendorId");
        return "redirect:/vendor/login";
    }

    // ==================== Registration ====================

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerPage(Model model) {
        model.addAttribute("vendor", new Vendor());
        model.addAttribute("businessTypes", BusinessType.values());
        model.addAttribute("accountTypes", AccountType.values());
        model.addAttribute("categories", categoryService.findActiveCategories());
        return "vendor/register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute Vendor vendor,
                          @RequestParam(required = false) String confirmPassword,
                          @RequestParam(required = false) String[] selectedCategories,
                          RedirectAttributes redirectAttributes) {
        try {
            // Validate password match
            if (!vendor.getPassword().equals(confirmPassword)) {
                redirectAttributes.addFlashAttribute("error", "Passwords do not match");
                return "redirect:/vendor/register";
            }

            // Check if email exists
            if (vendorService.existsByEmail(vendor.getEmail())) {
                redirectAttributes.addFlashAttribute("error", "Email already registered");
                return "redirect:/vendor/register";
            }

            // Check GST number
            if (vendor.getGstNumber() != null && vendorService.existsByGstNumber(vendor.getGstNumber())) {
                redirectAttributes.addFlashAttribute("error", "GST number already registered");
                return "redirect:/vendor/register";
            }

            // Check PAN number
            if (vendor.getPanNumber() != null && vendorService.existsByPanNumber(vendor.getPanNumber())) {
                redirectAttributes.addFlashAttribute("error", "PAN number already registered");
                return "redirect:/vendor/register";
            }

            // Set selected categories
            if (selectedCategories != null && selectedCategories.length > 0) {
                vendor.setProductCategories(String.join(",", selectedCategories));
            }

            // Register vendor
            Vendor savedVendor = vendorService.register(vendor);

            redirectAttributes.addFlashAttribute("success", 
                "Registration successful! Your application is under review. You will be notified once approved.");
            return "redirect:/vendor/login";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Registration failed: " + e.getMessage());
            return "redirect:/vendor/register";
        }
    }

    // ==================== Dashboard ====================

    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public String dashboard(HttpSession session, Model model) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        // Get wallet
        VendorWallet wallet = walletService.getOrCreateWallet(vendor);

        // Get stats
        long totalProducts = productService.countByVendor(vendor.getId());
        long activeProducts = productService.countActiveByVendor(vendor.getId());
        List<Product> lowStockProducts = productService.findLowStockProducts(vendor.getId());
        List<OrderItem> recentOrders = orderService.findOrderItemsByVendorId(vendor.getId());

        model.addAttribute("vendor", vendor);
        model.addAttribute("wallet", wallet);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("activeProducts", activeProducts);
        model.addAttribute("lowStockProducts", lowStockProducts);
        model.addAttribute("recentOrders", recentOrders.size() > 10 ? recentOrders.subList(0, 10) : recentOrders);
        model.addAttribute("totalOrders", vendor.getTotalOrders());
        model.addAttribute("totalRevenue", vendor.getTotalRevenue());

        return "vendor/dashboard";
    }

    // ==================== Products ====================

    @RequestMapping(value = "/products", method = RequestMethod.GET)
    public String products(@RequestParam(defaultValue = "0") int page,
                          @RequestParam(defaultValue = "10") int size,
                          HttpSession session, Model model) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        Page<Product> products = productService.findByVendorId(vendor.getId(), 
                PageRequest.of(page, size, Sort.by("createdAt").descending()));

        model.addAttribute("vendor", vendor);
        model.addAttribute("products", products);
        model.addAttribute("categories", categoryService.findActiveCategories());

        return "vendor/products/list";
    }

    @RequestMapping(value = "/products/add", method = RequestMethod.GET)
    public String addProductPage(HttpSession session, Model model) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        model.addAttribute("vendor", vendor);
        model.addAttribute("product", new Product());
        model.addAttribute("categories", categoryService.findActiveCategories());

        return "vendor/products/add";
    }

    @PostMapping("/products/add")
    public String addProduct(@ModelAttribute Product product,
                            @RequestParam(required = false) Long categoryId,
                            @RequestParam(required = false) String customCategory,
                            @RequestParam(required = false) MultipartFile image,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        try {
            // Handle category
            if (categoryId != null && categoryId > 0) {
                ProductCategory category = categoryService.findById(categoryId).orElse(null);
                product.setCategory(category);
            } else if (customCategory != null && !customCategory.trim().isEmpty()) {
                // Create custom category
                ProductCategory newCategory = categoryService.createCustomCategory(customCategory.trim(), vendor.getEmail());
                product.setCategory(newCategory);
            }

            // Create product
            Product savedProduct = productService.createProduct(product, vendor);

            // Upload image
            if (image != null && !image.isEmpty()) {
                productService.uploadProductImage(image, savedProduct.getId());
            }

            redirectAttributes.addFlashAttribute("success", "Product added successfully!");
            return "redirect:/vendor/products";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to add product: " + e.getMessage());
            return "redirect:/vendor/products/add";
        }
    }

    @RequestMapping(value = "/products/edit/{id}", method = RequestMethod.GET)
    public String editProductPage(@PathVariable Long id, HttpSession session, Model model) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        Product product = productService.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        if (!product.getVendor().getId().equals(vendor.getId())) {
            return "redirect:/vendor/products";
        }

        model.addAttribute("vendor", vendor);
        model.addAttribute("product", product);
        model.addAttribute("categories", categoryService.findActiveCategories());
        model.addAttribute("productImages", productService.getProductImages(id));

        return "vendor/products/edit";
    }

    @PostMapping("/products/edit/{id}")
    public String editProduct(@PathVariable Long id,
                             @ModelAttribute Product product,
                             @RequestParam(required = false) Long categoryId,
                             @RequestParam(required = false) String customCategory,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        try {
            Product existingProduct = productService.findById(id)
                    .orElseThrow(() -> new RuntimeException("Product not found"));

            if (!existingProduct.getVendor().getId().equals(vendor.getId())) {
                redirectAttributes.addFlashAttribute("error", "Unauthorized");
                return "redirect:/vendor/products";
            }

            // Update fields
            existingProduct.setProductName(product.getProductName());
            existingProduct.setDescription(product.getDescription());
            existingProduct.setShortDescription(product.getShortDescription());
            existingProduct.setPrice(product.getPrice());
            existingProduct.setMrp(product.getMrp());
            existingProduct.setDiscountPrice(product.getDiscountPrice());
            existingProduct.setStockQuantity(product.getStockQuantity());
            existingProduct.setMinStockLevel(product.getMinStockLevel());
            existingProduct.setWeight(product.getWeight());
            existingProduct.setManufacturer(product.getManufacturer());
            existingProduct.setBrand(product.getBrand());
            existingProduct.setIngredients(product.getIngredients());
            existingProduct.setBenefits(product.getBenefits());
            existingProduct.setUsageInstructions(product.getUsageInstructions());
            existingProduct.setTags(product.getTags());
            existingProduct.setIsFeatured(product.getIsFeatured());

            // Handle category
            if (categoryId != null && categoryId > 0) {
                ProductCategory category = categoryService.findById(categoryId).orElse(null);
                existingProduct.setCategory(category);
            } else if (customCategory != null && !customCategory.trim().isEmpty()) {
                ProductCategory newCategory = categoryService.createCustomCategory(customCategory.trim(), vendor.getEmail());
                existingProduct.setCategory(newCategory);
            }

            productService.save(existingProduct);

            redirectAttributes.addFlashAttribute("success", "Product updated successfully!");
            return "redirect:/vendor/products";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update product: " + e.getMessage());
            return "redirect:/vendor/products/edit/" + id;
        }
    }

    @PostMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        try {
            productService.delete(id, vendor.getId());
            redirectAttributes.addFlashAttribute("success", "Product deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete product: " + e.getMessage());
        }

        return "redirect:/vendor/products";
    }

    @PostMapping("/products/toggle-status/{id}")
    public String toggleProductStatus(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        try {
            productService.toggleActive(id, vendor.getId());
            redirectAttributes.addFlashAttribute("success", "Product status updated!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/vendor/products";
    }

    @PostMapping("/products/upload-image/{id}")
    public String uploadProductImage(@PathVariable Long id,
                                    @RequestParam MultipartFile image,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        try {
            productService.uploadProductImage(image, id);
            redirectAttributes.addFlashAttribute("success", "Image uploaded successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to upload image: " + e.getMessage());
        }

        return "redirect:/vendor/products/edit/" + id;
    }

    // ==================== Orders ====================

    @RequestMapping(value = "/orders", method = RequestMethod.GET)
    public String orders(@RequestParam(defaultValue = "0") int page,
                        @RequestParam(defaultValue = "10") int size,
                        HttpSession session, Model model) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        Page<OrderItem> orderItems = orderService.findOrderItemsByVendorId(vendor.getId(),
                PageRequest.of(page, size));

        model.addAttribute("vendor", vendor);
        model.addAttribute("orderItems", orderItems);

        return "vendor/orders/list";
    }

    @PostMapping("/orders/update-status/{itemId}")
    public String updateOrderStatus(@PathVariable Long itemId,
                                   @RequestParam String status,
                                   @RequestParam(required = false) String trackingNumber,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        try {
            OrderItem.ItemStatus itemStatus = OrderItem.ItemStatus.valueOf(status);
            OrderItem item = orderService.updateItemStatus(itemId, itemStatus, vendor.getId());

            if (trackingNumber != null && !trackingNumber.isEmpty()) {
                item.setTrackingNumber(trackingNumber);
            }

            redirectAttributes.addFlashAttribute("success", "Order status updated!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/vendor/orders";
    }

    // ==================== Reviews ====================

    @RequestMapping(value = "/reviews", method = RequestMethod.GET)
    public String reviews(@RequestParam(defaultValue = "0") int page,
                         @RequestParam(defaultValue = "10") int size,
                         HttpSession session, Model model) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        Page<ProductReview> reviews = reviewService.getVendorReviews(vendor.getId(),
                PageRequest.of(page, size));

        model.addAttribute("vendor", vendor);
        model.addAttribute("reviews", reviews);

        return "vendor/reviews/list";
    }

    @PostMapping("/reviews/respond/{reviewId}")
    public String respondToReview(@PathVariable Long reviewId,
                                 @RequestParam String response,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        try {
            reviewService.addVendorResponse(reviewId, vendor.getId(), response);
            redirectAttributes.addFlashAttribute("success", "Response added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/vendor/reviews";
    }

    // ==================== Wallet & Earnings ====================

    @RequestMapping(value = "/wallet", method = RequestMethod.GET)
    public String wallet(@RequestParam(defaultValue = "0") int page,
                        @RequestParam(defaultValue = "20") int size,
                        HttpSession session, Model model) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        VendorWallet wallet = walletService.getOrCreateWallet(vendor);
        Page<WalletTransaction> transactions = walletService.getTransactions(wallet.getId(),
                PageRequest.of(page, size));

        model.addAttribute("vendor", vendor);
        model.addAttribute("wallet", wallet);
        model.addAttribute("transactions", transactions);

        return "vendor/wallet";
    }

    // ==================== Profile & Settings ====================

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String profile(HttpSession session, Model model) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        List<VendorDocument> documents = documentService.getVendorDocuments(vendor.getId());

        model.addAttribute("vendor", vendor);
        model.addAttribute("documents", documents);
        model.addAttribute("businessTypes", BusinessType.values());
        model.addAttribute("accountTypes", AccountType.values());
        model.addAttribute("documentTypes", DocumentType.values());

        return "vendor/profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@ModelAttribute Vendor vendorData,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        try {
            // Update allowed fields
            vendor.setOwnerFullName(vendorData.getOwnerFullName());
            vendor.setMobileNumber(vendorData.getMobileNumber());
            vendor.setAlternatePhone(vendorData.getAlternatePhone());
            vendor.setStoreDisplayName(vendorData.getStoreDisplayName());
            vendor.setStoreDescription(vendorData.getStoreDescription());
            vendor.setWebsiteUrl(vendorData.getWebsiteUrl());
            vendor.setFacebookUrl(vendorData.getFacebookUrl());
            vendor.setInstagramHandle(vendorData.getInstagramHandle());

            vendorService.save(vendor);
            session.setAttribute("vendor", vendor);

            redirectAttributes.addFlashAttribute("success", "Profile updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update profile: " + e.getMessage());
        }

        return "redirect:/vendor/profile";
    }

    @PostMapping("/profile/upload-document")
    public String uploadDocument(@RequestParam DocumentType documentType,
                                @RequestParam MultipartFile document,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        try {
            documentService.uploadDocument(vendor, document, documentType);
            redirectAttributes.addFlashAttribute("success", "Document uploaded successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to upload document: " + e.getMessage());
        }

        return "redirect:/vendor/profile";
    }

    @PostMapping("/profile/change-password")
    public String changePassword(@RequestParam String currentPassword,
                                @RequestParam String newPassword,
                                @RequestParam String confirmPassword,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        Vendor vendor = getVendorFromSession(session);
        if (vendor == null) return "redirect:/vendor/login";

        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "New passwords do not match");
            return "redirect:/vendor/profile";
        }

        try {
            boolean success = vendorService.changePassword(vendor.getId(), currentPassword, newPassword);
            if (success) {
                redirectAttributes.addFlashAttribute("success", "Password changed successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Current password is incorrect");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to change password: " + e.getMessage());
        }

        return "redirect:/vendor/profile";
    }

    // ==================== Helper Methods ====================

    private Vendor getVendorFromSession(HttpSession session) {
        Long vendorId = (Long) session.getAttribute("vendorId");
        if (vendorId == null) return null;

        return vendorService.findById(vendorId).orElse(null);
    }
}

