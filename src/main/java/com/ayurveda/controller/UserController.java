package com.ayurveda.controller;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

import com.ayurveda.entity.Booking;
import com.ayurveda.entity.Cart;
import com.ayurveda.entity.Consultation;
import com.ayurveda.entity.Hospital;
import com.ayurveda.entity.Product;
import com.ayurveda.entity.ProductOrder;
import com.ayurveda.entity.RoomBooking;
import com.ayurveda.entity.SavedCenter;
import com.ayurveda.entity.User;
import com.ayurveda.entity.UserEnquiry;
import com.ayurveda.service.BookingService;
import com.ayurveda.service.CartService;
import com.ayurveda.service.ConsultationService;
import com.ayurveda.service.HospitalService;
import com.ayurveda.service.OrderService;
import com.ayurveda.service.ProductService;
import com.ayurveda.service.ProductReviewService;
import com.ayurveda.service.ReviewService;
import com.ayurveda.service.RoomService;
import com.ayurveda.service.UserService;
import com.ayurveda.service.PrescriptionService;
import com.ayurveda.entity.Review;
import com.ayurveda.entity.ProductReview;
import com.ayurveda.entity.Prescription;

@Controller
@RequestMapping("/user")
public class UserController {

    private final UserService userService;
    private final HospitalService hospitalService;
    private final RoomService roomService;
    private final CartService cartService;
    private final OrderService orderService;
    private final ProductService productService;
    private final BookingService bookingService;
    private final ConsultationService consultationService;
    private final ReviewService reviewService;
    private final ProductReviewService productReviewService;
    private final PrescriptionService prescriptionService;

    @Autowired
    public UserController(UserService userService,
                         HospitalService hospitalService,
                         RoomService roomService,
                         CartService cartService,
                         OrderService orderService,
                         ProductService productService,
                         BookingService bookingService,
                         ConsultationService consultationService,
                         ReviewService reviewService,
                         ProductReviewService productReviewService,
                         PrescriptionService prescriptionService) {
        this.userService = userService;
        this.hospitalService = hospitalService;
        this.roomService = roomService;
        this.cartService = cartService;
        this.orderService = orderService;
        this.productService = productService;
        this.bookingService = bookingService;
        this.consultationService = consultationService;
        this.reviewService = reviewService;
        this.productReviewService = productReviewService;
        this.prescriptionService = prescriptionService;
    }

    // Helper method to get current user
    private User getCurrentUser(Authentication auth) {
        return userService.findByEmail(auth.getName())
                .orElseThrow(() -> new RuntimeException("User not found"));
    }

    // ========== REGISTRATION & LOGIN ==========
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerPage(Model model) {
        model.addAttribute("user", new User());
        return "user/register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute User user,
                          RedirectAttributes redirectAttributes) {
        try {
            userService.registerUser(user);
            redirectAttributes.addFlashAttribute("success", "Registration successful! Please login.");
            return "redirect:/user/login";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/user/register";
        }
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(@RequestParam(required = false) String error,
                           @RequestParam(required = false) String logout,
                           @RequestParam(required = false) String redirectUrl,
                           Model model) {
        if (error != null) {
            model.addAttribute("error", "Invalid email or password");
        }
        if (logout != null) {
            model.addAttribute("message", "You have been logged out successfully");
        }
        // Handle redirect URL from flash attributes or query param
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            model.addAttribute("redirectUrl", redirectUrl);
        }
        return "user/login";
    }

    // ========== DASHBOARD ==========
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public String dashboard(Authentication auth, Model model, HttpSession session) {
        User user = getCurrentUser(auth);
        userService.updateLastLogin(user.getId());

        Map<String, Object> stats = userService.getDashboardStats(user.getId());
        List<SavedCenter> savedCenters = userService.getSavedCenters(user.getId());
        List<UserEnquiry> recentEnquiries = userService.getUserEnquiries(user.getId()).stream()
                .sorted((e1, e2) -> e2.getCreatedAt().compareTo(e1.getCreatedAt()))
                .limit(5)
                .collect(Collectors.toList());
        
        // Get recent bookings for the user
        List<Booking> recentBookings = bookingService.getBookingsByUser(user.getId()).stream()
                .sorted((b1, b2) -> b2.getCreatedAt().compareTo(b1.getCreatedAt()))
                .limit(5)
                .collect(Collectors.toList());

        // Get recent room bookings for the user
        List<RoomBooking> recentRoomBookings = roomService.getRoomBookingsByUser(user.getId()).stream()
                .sorted((b1, b2) -> b2.getCreatedAt().compareTo(b1.getCreatedAt()))
                .limit(5)
                .collect(Collectors.toList());
        
        // Check if this is first visit after login (show welcome message)
        Boolean showWelcome = (Boolean) session.getAttribute("showWelcome");
        if (showWelcome == null) {
            showWelcome = true;
            session.setAttribute("showWelcome", false);
        } else {
            showWelcome = false;
        }

        model.addAttribute("user", user);
        model.addAttribute("stats", stats);
        model.addAttribute("savedCenters", savedCenters);
        model.addAttribute("recentEnquiries", recentEnquiries);
        model.addAttribute("recentBookings", recentBookings);
        model.addAttribute("recentRoomBookings", recentRoomBookings);
        model.addAttribute("showWelcome", showWelcome);

        return "user/dashboard/index";
    }

    // ========== SEARCH HOSPITALS ==========
    @RequestMapping(value = "/hospitals", method = RequestMethod.GET)
    public String searchHospitals(@RequestParam(defaultValue = "") String search,
                                  @RequestParam(defaultValue = "") String location,
                                  @RequestParam(defaultValue = "") String therapy,
                                  @RequestParam(defaultValue = "0") int page,
                                  Authentication auth,
                                  Model model) {
        User user = getCurrentUser(auth);
        Pageable pageable = PageRequest.of(page, 12, Sort.by(Sort.Direction.DESC, "averageRating"));
        // Show all approved hospitals (all registered hospitals that have been approved)
        Page<Hospital> hospitalPage = hospitalService.searchAllApprovedHospitals(search, pageable);

        model.addAttribute("user", user);
        model.addAttribute("hospitals", hospitalPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", hospitalPage.getTotalPages());
        model.addAttribute("search", search);
        model.addAttribute("location", location);
        model.addAttribute("therapy", therapy);

        return "user/dashboard/hospitals";
    }

    // ========== SAVED CENTERS ==========
    @RequestMapping(value = "/saved-centers", method = RequestMethod.GET)
    public String savedCenters(Authentication auth, Model model) {
        User user = getCurrentUser(auth);
        List<SavedCenter> savedCenters = userService.getSavedCenters(user.getId());

        model.addAttribute("user", user);
        model.addAttribute("savedCenters", savedCenters);

        return "user/dashboard/saved-centers";
    }

    @PostMapping("/save-center/{hospitalId}")
    public String saveCenter(@PathVariable Long hospitalId,
                            Authentication auth,
                            RedirectAttributes redirectAttributes) {
        try {
            User user = getCurrentUser(auth);
            userService.saveCenter(user.getId(), hospitalId);
            redirectAttributes.addFlashAttribute("success", "Hospital saved to your list");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/user/saved-centers";
    }

    @RequestMapping(value = "/save-center/{hospitalId}", method = RequestMethod.GET)
    public String saveCenterGet(@PathVariable Long hospitalId,
                                Authentication auth,
                                RedirectAttributes redirectAttributes) {
        return saveCenter(hospitalId, auth, redirectAttributes);
    }

    @PostMapping("/remove-saved-center/{savedCenterId}")
    public String removeSavedCenter(@PathVariable Long savedCenterId,
                                   Authentication auth,
                                   RedirectAttributes redirectAttributes) {
        try {
            User user = getCurrentUser(auth);
            userService.removeSavedCenter(user.getId(), savedCenterId);
            redirectAttributes.addFlashAttribute("success", "Hospital removed from saved list");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/user/saved-centers";
    }

    // ========== ENQUIRIES ==========
    @RequestMapping(value = "/enquiries", method = RequestMethod.GET)
    public String enquiries(Authentication auth, Model model) {
        User user = getCurrentUser(auth);
        List<UserEnquiry> enquiries = userService.getUserEnquiries(user.getId());

        model.addAttribute("user", user);
        model.addAttribute("enquiries", enquiries);

        return "user/dashboard/enquiries";
    }

    @RequestMapping(value = "/enquiry/{hospitalId}", method = RequestMethod.GET)
    public String enquiryForm(@PathVariable Long hospitalId,
                              Authentication auth,
                              Model model) {
        User user = getCurrentUser(auth);
        Hospital hospital = hospitalService.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));

        model.addAttribute("user", user);
        model.addAttribute("hospital", hospital);
        model.addAttribute("enquiry", new UserEnquiry());

        return "user/dashboard/enquiry-form";
    }

    @PostMapping("/enquiry/{hospitalId}")
    public String submitEnquiry(@PathVariable Long hospitalId,
                               @ModelAttribute UserEnquiry enquiry,
                               @RequestParam(required = false) String preferredStartDate,
                               @RequestParam(required = false) String preferredEndDate,
                               Authentication auth,
                               RedirectAttributes redirectAttributes) {
        try {
            User user = getCurrentUser(auth);
            // Parse dates if provided
            if (preferredStartDate != null && !preferredStartDate.isEmpty()) {
                enquiry.setPreferredStartDate(java.time.LocalDate.parse(preferredStartDate));
            }
            if (preferredEndDate != null && !preferredEndDate.isEmpty()) {
                enquiry.setPreferredEndDate(java.time.LocalDate.parse(preferredEndDate));
            }
            userService.createEnquiry(user.getId(), hospitalId, enquiry);
            redirectAttributes.addFlashAttribute("success", "Enquiry submitted successfully!");
            return "redirect:/user/enquiries";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/user/enquiry/" + hospitalId;
        }
    }

    @RequestMapping(value = "/enquiry/details/{enquiryId}", method = RequestMethod.GET)
    public String enquiryDetails(@PathVariable Long enquiryId,
                                Authentication auth,
                                Model model) {
        User user = getCurrentUser(auth);
        UserEnquiry enquiry = userService.getEnquiryById(enquiryId)
                .orElseThrow(() -> new RuntimeException("Enquiry not found"));

        if (!enquiry.getUser().getId().equals(user.getId())) {
            return "redirect:/user/enquiries";
        }

        model.addAttribute("user", user);
        model.addAttribute("enquiry", enquiry);

        return "user/dashboard/enquiry-details";
    }

    // ========== PROFILE ==========
    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String profile(Authentication auth, Model model) {
        User user = getCurrentUser(auth);
        model.addAttribute("user", user);
        return "user/dashboard/profile";
    }

    @PostMapping("/profile")
    public String updateProfile(@ModelAttribute User updateData,
                               @RequestParam(required = false) String dateOfBirth,
                               Authentication auth,
                               RedirectAttributes redirectAttributes) {
        try {
            User user = getCurrentUser(auth);
            // Parse date if provided
            if (dateOfBirth != null && !dateOfBirth.isEmpty()) {
                try {
                    updateData.setDateOfBirth(java.time.LocalDateTime.parse(dateOfBirth + "T00:00:00"));
                } catch (Exception e) {
                    // Date parsing failed, ignore
                }
            }
            userService.updateProfile(user.getId(), updateData);
            redirectAttributes.addFlashAttribute("success", "Profile updated successfully");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/user/profile";
    }

    @PostMapping("/change-password")
    public String changePassword(@RequestParam String oldPassword,
                                 @RequestParam String newPassword,
                                 Authentication auth,
                                 RedirectAttributes redirectAttributes) {
        try {
            User user = getCurrentUser(auth);
            userService.changePassword(user.getId(), oldPassword, newPassword);
            redirectAttributes.addFlashAttribute("success", "Password changed successfully");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/user/profile";
    }

    // ========== PACKAGE BOOKINGS ==========
    @RequestMapping(value = "/bookings", method = RequestMethod.GET)
    public String packageBookings(Authentication auth, Model model) {
        User user = getCurrentUser(auth);
        List<Booking> bookings = bookingService.getBookingsByUser(user.getId());
        model.addAttribute("user", user);
        model.addAttribute("bookings", bookings);
        return "user/dashboard/bookings";
    }
    
    // ========== ROOM BOOKINGS ==========
    @RequestMapping(value = "/room-bookings", method = RequestMethod.GET)
    public String roomBookings(Authentication auth, Model model) {
        User user = getCurrentUser(auth);
        List<RoomBooking> bookings = roomService.getRoomBookingsByUser(user.getId());

        model.addAttribute("user", user);
        model.addAttribute("bookings", bookings);

        return "user/dashboard/room-bookings";
    }

    @RequestMapping(value = "/room-booking/details/{bookingId}", method = RequestMethod.GET)
    public String roomBookingDetails(@PathVariable Long bookingId,
                                    Authentication auth,
                                    Model model) {
        User user = getCurrentUser(auth);
        RoomBooking booking = roomService.findRoomBookingById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        if (booking.getUser() == null || !booking.getUser().getId().equals(user.getId())) {
            return "redirect:/user/room-bookings";
        }

        model.addAttribute("user", user);
        model.addAttribute("booking", booking);

        return "user/dashboard/room-booking-details";
    }

    @PostMapping("/room/booking/{roomId}")
    public String submitRoomBooking(@PathVariable Long roomId,
                                   @ModelAttribute RoomBooking booking,
                                   Authentication auth,
                                   RedirectAttributes redirectAttributes) {
        try {
            User user = getCurrentUser(auth);
            RoomBooking savedBooking = roomService.createRoomBooking(roomId, user.getId(), booking);
            
            return "redirect:/room/booking/confirmation/" + savedBooking.getBookingNumber();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
            return "redirect:/room/booking/" + roomId;
        }
    }

    // ========== PRODUCTS & CART ==========
    // Note: Main product browsing is now handled by ShopController (/products)
    // This is a simplified version for the user dashboard
    @RequestMapping(value = "/products", method = RequestMethod.GET)
    public String browseProducts(@RequestParam(defaultValue = "") String search,
                                 @RequestParam(defaultValue = "0") int page,
                                 Authentication auth,
                                 Model model) {
        User user = getCurrentUser(auth);
        
        // Get all active products
        List<Product> products = productService.getAllActiveProducts();
        
        // Filter by search term
        if (search != null && !search.isEmpty()) {
            final String searchLower = search.toLowerCase();
            products = products.stream()
                .filter(p -> p.getProductName().toLowerCase().contains(searchLower) ||
                           (p.getDescription() != null && p.getDescription().toLowerCase().contains(searchLower)))
                .collect(Collectors.toList());
        }
        
        int cartCount = cartService.getCartItemCount(user.getId());
        
        model.addAttribute("user", user);
        model.addAttribute("products", products);
        model.addAttribute("search", search);
        model.addAttribute("cartCount", cartCount);
        
        return "user/dashboard/products";
    }

    @RequestMapping(value = "/cart", method = RequestMethod.GET)
    public String viewCart(Authentication auth, Model model) {
        User user = getCurrentUser(auth);
        List<Cart> cartItems = cartService.getCartItems(user.getId());
        BigDecimal cartTotal = cartService.getCartTotal(user.getId());
        
        model.addAttribute("user", user);
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotal", cartTotal);
        
        return "user/dashboard/cart";
    }

    @PostMapping("/cart/add/{productId}")
    public String addToCart(@PathVariable Long productId,
                           @RequestParam(defaultValue = "1") Integer quantity,
                           Authentication auth,
                           RedirectAttributes redirectAttributes) {
        try {
            User user = getCurrentUser(auth);
            cartService.addToCart(user, productId, quantity);
            redirectAttributes.addFlashAttribute("success", "Product added to cart");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/user/cart";
    }

    @PostMapping("/cart/update/{productId}")
    public String updateCartItem(@PathVariable Long productId,
                                 @RequestParam Integer quantity,
                                 Authentication auth,
                                 RedirectAttributes redirectAttributes) {
        try {
            User user = getCurrentUser(auth);
            cartService.updateQuantity(user.getId(), productId, quantity);
            redirectAttributes.addFlashAttribute("success", "Cart updated");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/user/cart";
    }

    @PostMapping("/cart/remove/{productId}")
    public String removeFromCart(@PathVariable Long productId,
                                Authentication auth,
                                RedirectAttributes redirectAttributes) {
        try {
            User user = getCurrentUser(auth);
            cartService.removeFromCart(user.getId(), productId);
            redirectAttributes.addFlashAttribute("success", "Item removed from cart");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/user/cart";
    }

    @RequestMapping(value = "/checkout", method = RequestMethod.GET)
    public String checkout(Authentication auth, Model model) {
        User user = getCurrentUser(auth);
        List<Cart> cartItems = cartService.getCartItems(user.getId());
        
        if (cartItems.isEmpty()) {
            return "redirect:/user/cart";
        }
        
        BigDecimal cartTotal = cartService.getCartTotal(user.getId());
        
        model.addAttribute("user", user);
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotal", cartTotal);
        model.addAttribute("order", new ProductOrder());
        
        return "user/dashboard/checkout";
    }

    @PostMapping("/checkout")
    public String placeOrder(@ModelAttribute ProductOrder order,
                             Authentication auth,
                             RedirectAttributes redirectAttributes) {
        try {
            User user = getCurrentUser(auth);
            ProductOrder savedOrder = orderService.createOrderFromCart(user.getId(), order);
            return "redirect:/user/order/confirmation/" + savedOrder.getOrderNumber();
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/user/checkout";
        }
    }

    @RequestMapping(value = "/order/confirmation/{orderNumber}", method = RequestMethod.GET)
    public String orderConfirmation(@PathVariable String orderNumber,
                                   Authentication auth,
                                   Model model) {
        User user = getCurrentUser(auth);
        ProductOrder order = orderService.findByOrderNumber(orderNumber)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        
        if (!order.getUser().getId().equals(user.getId())) {
            return "redirect:/user/orders";
        }
        
        model.addAttribute("user", user);
        model.addAttribute("order", order);
        
        return "user/dashboard/order-confirmation";
    }

    @RequestMapping(value = "/orders", method = RequestMethod.GET)
    public String myOrders(Authentication auth, Model model) {
        User user = getCurrentUser(auth);
        List<ProductOrder> orders = orderService.getUserOrders(user.getId());
        
        model.addAttribute("user", user);
        model.addAttribute("orders", orders);
        
        return "user/dashboard/orders";
    }

    @RequestMapping(value = "/order/details/{orderId}", method = RequestMethod.GET)
    public String orderDetails(@PathVariable Long orderId,
                              Authentication auth,
                              Model model) {
        User user = getCurrentUser(auth);
        ProductOrder order = orderService.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        
        if (!order.getUser().getId().equals(user.getId())) {
            return "redirect:/user/orders";
        }
        
        model.addAttribute("user", user);
        model.addAttribute("order", order);
        
        return "user/dashboard/order-details";
    }

    // ========== CONSULTATIONS ==========
    @RequestMapping(value = "/dashboard/consultations", method = RequestMethod.GET)
    public String consultations(Authentication auth, Model model) {
        User user = getCurrentUser(auth);
        
        List<Consultation> consultations = consultationService.getConsultationsByUser(user.getId());
        
        model.addAttribute("user", user);
        model.addAttribute("consultations", consultations);
        
        return "user/dashboard/consultations";
    }

    @RequestMapping(value = "/dashboard/consultations/{id}", method = RequestMethod.GET)
    public String consultationDetails(@PathVariable Long id, Authentication auth, Model model) {
        User user = getCurrentUser(auth);
        
        // Use findByIdWithRelations to eagerly fetch doctor, hospital, and user
        Consultation consultation = consultationService.findByIdWithRelations(id)
                .orElseThrow(() -> new RuntimeException("Consultation not found"));
        
        // Security check - ensure user owns this consultation
        if (consultation.getUser() == null || !consultation.getUser().getId().equals(user.getId())) {
            throw new RuntimeException("Unauthorized access");
        }
        
        // Check if prescription exists for this consultation
        var prescription = prescriptionService.findByConsultationId(id);
        
        model.addAttribute("user", user);
        model.addAttribute("consultation", consultation);
        model.addAttribute("prescription", prescription.orElse(null));
        
        return "user/dashboard/consultation-details";
    }

    // ========== PRESCRIPTIONS ==========
    @RequestMapping(value = "/dashboard/prescriptions", method = RequestMethod.GET)
    public String prescriptions(Authentication auth, Model model) {
        User user = getCurrentUser(auth);
        
        List<Prescription> prescriptions = prescriptionService.getPrescriptionsByPatient(user.getEmail());
        
        model.addAttribute("user", user);
        model.addAttribute("prescriptions", prescriptions);
        
        return "user/dashboard/prescriptions";
    }

    @RequestMapping(value = "/dashboard/prescriptions/{id}", method = RequestMethod.GET)
    public String prescriptionDetails(@PathVariable Long id, Authentication auth, Model model) {
        User user = getCurrentUser(auth);
        
        Prescription prescription = prescriptionService.findById(id)
                .orElseThrow(() -> new RuntimeException("Prescription not found"));
        
        // Security check - ensure user owns this prescription
        if (prescription.getPatientEmail() == null || !prescription.getPatientEmail().equals(user.getEmail())) {
            throw new RuntimeException("Unauthorized access");
        }
        
        model.addAttribute("user", user);
        model.addAttribute("prescription", prescription);
        
        return "user/dashboard/prescription-details";
    }

    // ========== REVIEW FORM ==========
    @RequestMapping(value = "/review", method = RequestMethod.GET)
    public String reviewForm(Authentication auth, Model model) {
        User user = getCurrentUser(auth);
        
        // Get list of hospitals for dropdown
        List<Hospital> hospitals = hospitalService.getAllHospitals();
        
        // Get list of products for dropdown
        List<Product> products = productService.getAllProducts();
        
        model.addAttribute("user", user);
        model.addAttribute("hospitals", hospitals);
        model.addAttribute("products", products);
        
        return "user/dashboard/review-form";
    }
    
    // ========== VIEW REVIEWS ==========
    @RequestMapping(value = "/dashboard/reviews", method = RequestMethod.GET)
    public String reviews(Authentication auth, Model model) {
        User user = getCurrentUser(auth);
        
        // Get hospital reviews by user email
        List<Review> hospitalReviews = reviewService.getReviewsByUserEmail(user.getEmail());
        
        // Get product reviews by user
        List<ProductReview> productReviews = productReviewService.getUserReviews(user.getId());
        
        model.addAttribute("user", user);
        model.addAttribute("hospitalReviews", hospitalReviews);
        model.addAttribute("productReviews", productReviews);
        
        return "user/dashboard/reviews";
    }

    // ========== SUBMIT REVIEW ==========
    @RequestMapping(value = "/review/submit", method = RequestMethod.GET)
    public String showReviewForm(@RequestParam(required = false) String type,
                                @RequestParam(required = false) Long id,
                                Authentication auth,
                                Model model) {
        User user = getCurrentUser(auth);
        model.addAttribute("user", user);
        model.addAttribute("reviewType", type);
        model.addAttribute("reviewId", id);
        
        if ("hospital".equals(type) && id != null) {
            Hospital hospital = hospitalService.findById(id)
                    .orElseThrow(() -> new RuntimeException("Hospital not found"));
            model.addAttribute("hospital", hospital);
            model.addAttribute("review", new Review());
        } else if ("product".equals(type) && id != null) {
            Product product = productService.findById(id)
                    .orElseThrow(() -> new RuntimeException("Product not found"));
            model.addAttribute("product", product);
            model.addAttribute("review", new ProductReview());
        }
        
        return "public/review-form";
    }

    @PostMapping("/review/hospital/{hospitalId}")
    public String submitHospitalReview(@PathVariable Long hospitalId,
                                      @RequestParam Integer rating,
                                      @RequestParam String reviewText,
                                      @RequestParam(required = false) String title,
                                      @RequestParam(required = false) String treatmentTaken,
                                      @RequestParam(required = false) Integer treatmentRating,
                                      @RequestParam(required = false) Integer accommodationRating,
                                      @RequestParam(required = false) Integer staffRating,
                                      @RequestParam(required = false) Integer foodRating,
                                      @RequestParam(required = false) Integer valueForMoneyRating,
                                      Authentication auth,
                                      RedirectAttributes redirectAttributes) {
        try {
            User user = getCurrentUser(auth);
            Review review = new Review();
            review.setRating(rating);
            review.setReviewText(reviewText);
            review.setTreatmentTaken(treatmentTaken);
            review.setTreatmentRating(treatmentRating);
            review.setAccommodationRating(accommodationRating);
            review.setStaffRating(staffRating);
            review.setFoodRating(foodRating);
            review.setValueForMoneyRating(valueForMoneyRating);
            review.setPatientName(user.getFullName());
            review.setPatientEmail(user.getEmail());
            review.setPatientCountry(user.getCountry() != null ? user.getCountry() : "");
            
            reviewService.createReview(hospitalId, review);
            redirectAttributes.addFlashAttribute("success", "Review submitted successfully! It will be visible after moderation.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to submit review: " + e.getMessage());
        }
        return "redirect:/user/review";
    }

    @PostMapping("/review/product/{productId}")
    public String submitProductReview(@PathVariable Long productId,
                                     @RequestParam Integer rating,
                                     @RequestParam String reviewText,
                                     @RequestParam(required = false) String title,
                                     @RequestParam(required = false) String pros,
                                     @RequestParam(required = false) String cons,
                                     @RequestParam(required = false) Boolean isRecommended,
                                     @RequestParam(required = false) Long orderId,
                                     Authentication auth,
                                     RedirectAttributes redirectAttributes) {
        try {
            User user = getCurrentUser(auth);
            ProductReview review = new ProductReview();
            review.setRating(rating);
            review.setComment(reviewText);
            review.setTitle(title);
            review.setPros(pros);
            review.setCons(cons);
            review.setIsRecommended(isRecommended != null ? isRecommended : true);
            
            productReviewService.createReview(user, productId, review, orderId);
            redirectAttributes.addFlashAttribute("success", "Review submitted successfully! It will be visible after moderation.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to submit review: " + e.getMessage());
        }
        return "redirect:/user/review";
    }

    // ========== WEBSITE REVIEW ==========
    @PostMapping("/review/website")
    public String submitWebsiteReview(@RequestParam Integer rating,
                                     @RequestParam(required = false) String title,
                                     @RequestParam String reviewText,
                                     @RequestParam(required = false) String pros,
                                     @RequestParam(required = false) String cons,
                                     @RequestParam(required = false) Boolean isRecommended,
                                     Authentication auth,
                                     RedirectAttributes redirectAttributes) {
        try {
            User user = getCurrentUser(auth);
            
            // For now, we'll create a general feedback entry
            // You can create a WebsiteReview entity later if needed
            // For now, we'll just show a success message
            
            redirectAttributes.addFlashAttribute("success", "Thank you for your feedback! Your review has been submitted successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to submit review: " + e.getMessage());
        }
        return "redirect:/user/review";
    }
}

