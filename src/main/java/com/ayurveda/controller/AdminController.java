package com.ayurveda.controller;

import com.ayurveda.entity.*;
import com.ayurveda.entity.Hospital.HospitalStatus;
import com.ayurveda.entity.Vendor.VendorStatus;
import com.ayurveda.service.AdminService;
import com.ayurveda.service.VendorService;
import com.ayurveda.service.VendorDocumentService;
import com.ayurveda.service.ProductCategoryService;
import com.ayurveda.service.ProductReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;
    
    @Autowired
    private VendorService vendorService;
    
    @Autowired
    private VendorDocumentService vendorDocumentService;
    
    @Autowired
    private ProductCategoryService categoryService;
    
    @Autowired
    private ProductReviewService reviewService;

    @Autowired
    public AdminController(AdminService adminService) {
        this.adminService = adminService;
    }

    // Login Page
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(@RequestParam(required = false) String error,
                           @RequestParam(required = false) String logout,
                           Model model) {
        if (error != null) {
            model.addAttribute("error", "Invalid email or password");
        }
        if (logout != null) {
            model.addAttribute("message", "You have been logged out successfully");
        }
        return "admin/login";
    }

    // Register Page
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerPage(Model model) {
        model.addAttribute("admin", new Admin());
        return "admin/register";
    }

    // Register Handler
    @PostMapping("/register")
    public String registerAdmin(@ModelAttribute Admin admin,
                               RedirectAttributes redirectAttributes) {
        try {
            adminService.registerAdmin(admin);
            redirectAttributes.addFlashAttribute("success", "Registration successful! Please login.");
            return "redirect:/admin/login";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/register";
        }
    }

    // Dashboard
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public String dashboard(Model model) {
        Admin admin = getCurrentAdmin();
        if (admin != null) {
            adminService.updateLastLogin(admin.getId());
        }
        
        Map<String, Object> stats = adminService.getEnhancedDashboardStats();
        
        // Add vendor stats to the stats map
        stats.put("pendingVendors", vendorService.countPendingApprovals());
        stats.put("totalVendors", vendorService.countTotalVendors());
        
        List<Hospital> pendingHospitals = adminService.getPendingHospitals();
        List<Hospital> recentHospitals = adminService.getAllHospitals().stream()
                .sorted((h1, h2) -> h2.getCreatedAt().compareTo(h1.getCreatedAt()))
                .limit(5)
                .collect(Collectors.toList());
        
        // Get recent bookings
        List<Booking> recentBookings = adminService.getAllBookings().stream()
                .sorted((b1, b2) -> b2.getCreatedAt().compareTo(b1.getCreatedAt()))
                .limit(5)
                .collect(Collectors.toList());
        
        model.addAttribute("admin", admin);
        model.addAttribute("stats", stats);
        model.addAttribute("pendingHospitals", pendingHospitals);
        model.addAttribute("recentHospitals", recentHospitals);
        model.addAttribute("recentBookings", recentBookings);
        
        return "admin/dashboard/index";
    }

    // All Hospitals List
    @RequestMapping(value = "/hospitals", method = RequestMethod.GET)
    public String allHospitals(@RequestParam(required = false) String status, Model model) {
        Admin admin = getCurrentAdmin();
        List<Hospital> hospitals;
        
        if (status != null && !status.isEmpty()) {
            try {
                HospitalStatus hospitalStatus = HospitalStatus.valueOf(status.toUpperCase());
                hospitals = adminService.getHospitalsByStatus(hospitalStatus);
            } catch (IllegalArgumentException e) {
                hospitals = adminService.getAllHospitals();
            }
        } else {
            hospitals = adminService.getAllHospitals();
        }
        
        model.addAttribute("admin", admin);
        model.addAttribute("hospitals", hospitals);
        model.addAttribute("currentStatus", status);
        model.addAttribute("stats", adminService.getEnhancedDashboardStats());
        
        return "admin/dashboard/hospitals";
    }

    // Hospital Details
    @RequestMapping(value = "/hospitals/{id}", method = RequestMethod.GET)
    public String hospitalDetails(@PathVariable Long id, Model model) {
        Admin admin = getCurrentAdmin();
        Optional<Hospital> hospitalOpt = adminService.getHospitalById(id);
        
        if (hospitalOpt.isEmpty()) {
            return "redirect:/admin/hospitals";
        }
        
        model.addAttribute("admin", admin);
        model.addAttribute("hospital", hospitalOpt.get());
        
        return "admin/dashboard/hospital-details";
    }

    // Hospital Complete Details
    @RequestMapping(value = "/hospitals/{id}/complete", method = RequestMethod.GET)
    public String hospitalCompleteDetails(@PathVariable Long id, Model model) {
        Admin admin = getCurrentAdmin();
        
        try {
            Map<String, Object> details = adminService.getHospitalCompleteDetails(id);
            
            model.addAttribute("admin", admin);
            model.addAttribute("hospital", details.get("hospital"));
            model.addAttribute("doctors", details.get("doctors"));
            model.addAttribute("users", details.get("users"));
            model.addAttribute("bookings", details.get("bookings"));
            model.addAttribute("enquiries", details.get("enquiries"));
            model.addAttribute("associations", details.get("associations"));
            
            return "admin/dashboard/hospital-complete-details";
        } catch (RuntimeException e) {
            return "redirect:/admin/hospitals";
        }
    }

    // Approve Hospital
    @PostMapping("/hospitals/{id}/approve")
    public String approveHospital(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            adminService.approveHospital(id);
            redirectAttributes.addFlashAttribute("success", "Hospital approved successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/hospitals/" + id;
    }

    // Reject Hospital
    @PostMapping("/hospitals/{id}/reject")
    public String rejectHospital(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            adminService.rejectHospital(id);
            redirectAttributes.addFlashAttribute("success", "Hospital rejected.");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/hospitals/" + id;
    }

    // Verify Hospital
    @PostMapping("/hospitals/{id}/verify")
    public String verifyHospital(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            adminService.verifyHospital(id);
            redirectAttributes.addFlashAttribute("success", "Hospital verified successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/hospitals/" + id;
    }

    // Unverify Hospital
    @PostMapping("/hospitals/{id}/unverify")
    public String unverifyHospital(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            adminService.unverifyHospital(id);
            redirectAttributes.addFlashAttribute("success", "Hospital verification removed.");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/hospitals/" + id;
    }

    // Suspend Hospital
    @PostMapping("/hospitals/{id}/suspend")
    public String suspendHospital(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            adminService.suspendHospital(id);
            redirectAttributes.addFlashAttribute("success", "Hospital suspended.");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/hospitals/" + id;
    }

    // Activate Hospital
    @PostMapping("/hospitals/{id}/activate")
    public String activateHospital(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            adminService.activateHospital(id);
            redirectAttributes.addFlashAttribute("success", "Hospital activated.");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/hospitals/" + id;
    }

    // Toggle Featured
    @PostMapping("/hospitals/{id}/toggle-featured")
    public String toggleFeatured(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            Hospital hospital = adminService.toggleFeatured(id);
            String message = Boolean.TRUE.equals(hospital.getIsFeatured()) 
                    ? "Hospital marked as featured!" 
                    : "Hospital removed from featured.";
            redirectAttributes.addFlashAttribute("success", message);
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/hospitals/" + id;
    }

    // ========== USERS (VIEW ONLY) ==========
    @RequestMapping(value = "/users", method = RequestMethod.GET)
    public String allUsers(Model model) {
        Admin admin = getCurrentAdmin();
        List<User> users = adminService.getAllUsers();
        
        model.addAttribute("admin", admin);
        model.addAttribute("users", users);
        model.addAttribute("stats", adminService.getEnhancedDashboardStats());
        
        return "admin/dashboard/users";
    }

    @RequestMapping(value = "/users/{id}", method = RequestMethod.GET)
    public String userDetails(@PathVariable Long id, Model model) {
        Admin admin = getCurrentAdmin();
        Optional<User> userOpt = adminService.getUserById(id);
        
        if (userOpt.isEmpty()) {
            return "redirect:/admin/users";
        }
        
        model.addAttribute("admin", admin);
        model.addAttribute("user", userOpt.get());
        
        return "admin/dashboard/user-details";
    }

    // ========== DOCTORS (VIEW ONLY) ==========
    @RequestMapping(value = "/doctors", method = RequestMethod.GET)
    public String allDoctors(Model model) {
        Admin admin = getCurrentAdmin();
        List<Doctor> doctors = adminService.getAllDoctors();
        
        model.addAttribute("admin", admin);
        model.addAttribute("doctors", doctors);
        model.addAttribute("stats", adminService.getEnhancedDashboardStats());
        
        return "admin/dashboard/doctors";
    }

    @RequestMapping(value = "/doctors/{id}", method = RequestMethod.GET)
    public String doctorDetails(@PathVariable Long id, Model model) {
        Admin admin = getCurrentAdmin();
        Optional<Doctor> doctorOpt = adminService.getDoctorById(id);
        
        if (doctorOpt.isEmpty()) {
            return "redirect:/admin/doctors";
        }
        
        model.addAttribute("admin", admin);
        model.addAttribute("doctor", doctorOpt.get());
        
        return "admin/dashboard/doctor-details";
    }

    // ========== BOOKINGS (VIEW ONLY) ==========
    @RequestMapping(value = "/bookings", method = RequestMethod.GET)
    public String allBookings(Model model) {
        Admin admin = getCurrentAdmin();
        List<Booking> bookings = adminService.getAllBookings();
        
        model.addAttribute("admin", admin);
        model.addAttribute("bookings", bookings);
        model.addAttribute("stats", adminService.getEnhancedDashboardStats());
        
        return "admin/dashboard/bookings";
    }

    @RequestMapping(value = "/bookings/{id}", method = RequestMethod.GET)
    public String bookingDetails(@PathVariable Long id, Model model) {
        Admin admin = getCurrentAdmin();
        Optional<Booking> bookingOpt = adminService.getBookingById(id);
        
        if (bookingOpt.isEmpty()) {
            return "redirect:/admin/bookings";
        }
        
        model.addAttribute("admin", admin);
        model.addAttribute("booking", bookingOpt.get());
        
        return "admin/dashboard/booking-details";
    }

    // ========== PRODUCTS (VIEW ONLY) ==========
    @RequestMapping(value = "/products", method = RequestMethod.GET)
    public String allProducts(Model model) {
        Admin admin = getCurrentAdmin();
        List<Product> products = adminService.getAllProducts();
        
        model.addAttribute("admin", admin);
        model.addAttribute("products", products);
        model.addAttribute("stats", adminService.getEnhancedDashboardStats());
        
        return "admin/dashboard/products";
    }

    @RequestMapping(value = "/products/{id}", method = RequestMethod.GET)
    public String productDetails(@PathVariable Long id, Model model) {
        Admin admin = getCurrentAdmin();
        Optional<Product> productOpt = adminService.getProductById(id);
        
        if (productOpt.isEmpty()) {
            return "redirect:/admin/products";
        }
        
        model.addAttribute("admin", admin);
        model.addAttribute("product", productOpt.get());
        
        return "admin/dashboard/product-details";
    }

    // ========== ENQUIRIES (VIEW ONLY) ==========
    @RequestMapping(value = "/enquiries", method = RequestMethod.GET)
    public String allEnquiries(Model model) {
        Admin admin = getCurrentAdmin();
        List<UserEnquiry> enquiries = adminService.getAllEnquiries();
        
        model.addAttribute("admin", admin);
        model.addAttribute("enquiries", enquiries);
        model.addAttribute("stats", adminService.getEnhancedDashboardStats());
        
        return "admin/dashboard/enquiries";
    }

    @RequestMapping(value = "/enquiries/{id}", method = RequestMethod.GET)
    public String enquiryDetails(@PathVariable Long id, Model model) {
        Admin admin = getCurrentAdmin();
        Optional<UserEnquiry> enquiryOpt = adminService.getEnquiryById(id);
        
        if (enquiryOpt.isEmpty()) {
            return "redirect:/admin/enquiries";
        }
        
        model.addAttribute("admin", admin);
        model.addAttribute("enquiry", enquiryOpt.get());
        
        return "admin/dashboard/enquiry-details";
    }

    // ========== VENDOR MANAGEMENT ==========
    
    @RequestMapping(value = "/vendors", method = RequestMethod.GET)
    public String allVendors(@RequestParam(required = false) String status,
                            @RequestParam(defaultValue = "0") int page,
                            @RequestParam(defaultValue = "10") int size,
                            Model model) {
        Admin admin = getCurrentAdmin();
        Page<Vendor> vendors;
        
        if (status != null && !status.isEmpty() && !status.equals("all")) {
            try {
                VendorStatus vendorStatus = VendorStatus.valueOf(status.toUpperCase());
                vendors = vendorService.findByStatus(vendorStatus, PageRequest.of(page, size, Sort.by("createdAt").descending()));
            } catch (IllegalArgumentException e) {
                vendors = vendorService.findAll(PageRequest.of(page, size, Sort.by("createdAt").descending()));
            }
        } else {
            vendors = vendorService.findAll(PageRequest.of(page, size, Sort.by("createdAt").descending()));
        }
        
        model.addAttribute("admin", admin);
        model.addAttribute("vendors", vendors);
        model.addAttribute("currentStatus", status);
        model.addAttribute("pendingCount", vendorService.countPendingApprovals());
        model.addAttribute("totalVendors", vendorService.countTotalVendors());
        model.addAttribute("stats", adminService.getEnhancedDashboardStats());
        
        return "admin/dashboard/vendors";
    }
    
    @RequestMapping(value = "/vendors/{id}", method = RequestMethod.GET)
    public String vendorDetails(@PathVariable Long id, Model model) {
        Admin admin = getCurrentAdmin();
        Optional<Vendor> vendorOpt = vendorService.findById(id);
        
        if (vendorOpt.isEmpty()) {
            return "redirect:/admin/vendors";
        }
        
        Vendor vendor = vendorOpt.get();
        List<VendorDocument> documents = vendorDocumentService.getVendorDocuments(id);
        
        model.addAttribute("admin", admin);
        model.addAttribute("vendor", vendor);
        model.addAttribute("documents", documents);
        model.addAttribute("vendorStatuses", VendorStatus.values());
        
        return "admin/dashboard/vendor-details";
    }
    
    @PostMapping("/vendors/{id}/approve")
    public String approveVendor(@PathVariable Long id,
                               @RequestParam BigDecimal commissionPercentage,
                               RedirectAttributes redirectAttributes) {
        try {
            Admin admin = getCurrentAdmin();
            String approvedBy = admin != null ? admin.getEmail() : "admin";
            vendorService.approveVendor(id, commissionPercentage, approvedBy);
            redirectAttributes.addFlashAttribute("success", "Vendor approved successfully with " + commissionPercentage + "% commission!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/vendors/" + id;
    }
    
    @PostMapping("/vendors/{id}/reject")
    public String rejectVendor(@PathVariable Long id,
                              @RequestParam String reason,
                              RedirectAttributes redirectAttributes) {
        try {
            Admin admin = getCurrentAdmin();
            String rejectedBy = admin != null ? admin.getEmail() : "admin";
            vendorService.rejectVendor(id, reason, rejectedBy);
            redirectAttributes.addFlashAttribute("success", "Vendor rejected.");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/vendors/" + id;
    }
    
    @PostMapping("/vendors/{id}/suspend")
    public String suspendVendor(@PathVariable Long id,
                               @RequestParam String reason,
                               RedirectAttributes redirectAttributes) {
        try {
            vendorService.suspendVendor(id, reason);
            redirectAttributes.addFlashAttribute("success", "Vendor suspended.");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/vendors/" + id;
    }
    
    @PostMapping("/vendors/{id}/block")
    public String blockVendor(@PathVariable Long id,
                             @RequestParam String reason,
                             RedirectAttributes redirectAttributes) {
        try {
            vendorService.blockVendor(id, reason);
            redirectAttributes.addFlashAttribute("success", "Vendor blocked.");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/vendors/" + id;
    }
    
    @PostMapping("/vendors/{id}/activate")
    public String activateVendor(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            vendorService.activateVendor(id);
            redirectAttributes.addFlashAttribute("success", "Vendor activated successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/vendors/" + id;
    }
    
    @PostMapping("/vendors/{id}/update-commission")
    public String updateVendorCommission(@PathVariable Long id,
                                        @RequestParam BigDecimal commissionPercentage,
                                        RedirectAttributes redirectAttributes) {
        try {
            Vendor vendor = vendorService.findById(id)
                    .orElseThrow(() -> new RuntimeException("Vendor not found"));
            vendor.setCommissionPercentage(commissionPercentage);
            vendorService.save(vendor);
            redirectAttributes.addFlashAttribute("success", "Commission updated to " + commissionPercentage + "%");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/vendors/" + id;
    }
    
    // ========== PRODUCT CATEGORIES ==========
    
    @RequestMapping(value = "/categories", method = RequestMethod.GET)
    public String allCategories(Model model) {
        Admin admin = getCurrentAdmin();
        List<ProductCategory> categories = categoryService.findAll();
        
        model.addAttribute("admin", admin);
        model.addAttribute("categories", categories);
        model.addAttribute("stats", adminService.getEnhancedDashboardStats());
        
        return "admin/dashboard/categories";
    }
    
    @PostMapping("/categories/add")
    public String addCategory(@RequestParam String name,
                             @RequestParam(required = false) String description,
                             RedirectAttributes redirectAttributes) {
        try {
            Admin admin = getCurrentAdmin();
            ProductCategory category = new ProductCategory();
            category.setName(name);
            category.setDisplayName(name);
            category.setDescription(description);
            category.setIsDefault(false);
            category.setCreatedBy(admin != null ? admin.getEmail() : "admin");
            categoryService.save(category);
            redirectAttributes.addFlashAttribute("success", "Category added successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/categories";
    }
    
    @PostMapping("/categories/{id}/toggle")
    public String toggleCategory(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            categoryService.toggleActive(id);
            redirectAttributes.addFlashAttribute("success", "Category status updated!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/categories";
    }
    
    // ========== REVIEW MODERATION ==========
    
    @RequestMapping(value = "/reviews", method = RequestMethod.GET)
    public String allReviews(@RequestParam(defaultValue = "0") int page,
                            @RequestParam(defaultValue = "20") int size,
                            Model model) {
        Admin admin = getCurrentAdmin();
        
        model.addAttribute("admin", admin);
        model.addAttribute("pendingCount", reviewService.countPendingReviews());
        model.addAttribute("stats", adminService.getEnhancedDashboardStats());
        
        return "admin/dashboard/reviews";
    }
    
    @PostMapping("/reviews/{id}/approve")
    public String approveReview(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            Admin admin = getCurrentAdmin();
            String adminId = admin != null ? admin.getEmail() : "admin";
            reviewService.approveReview(id, adminId);
            redirectAttributes.addFlashAttribute("success", "Review approved!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/reviews";
    }
    
    @PostMapping("/reviews/{id}/reject")
    public String rejectReview(@PathVariable Long id,
                              @RequestParam String reason,
                              RedirectAttributes redirectAttributes) {
        try {
            Admin admin = getCurrentAdmin();
            String adminId = admin != null ? admin.getEmail() : "admin";
            reviewService.rejectReview(id, reason, adminId);
            redirectAttributes.addFlashAttribute("success", "Review rejected.");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/reviews";
    }

    // Helper method to get current admin
    private Admin getCurrentAdmin() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            String email = auth.getName();
            return adminService.findByEmail(email).orElse(null);
        }
        return null;
    }
}

