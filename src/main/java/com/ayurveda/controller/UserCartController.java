package com.ayurveda.controller;

import com.ayurveda.entity.*;
import com.ayurveda.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/user/dashboard")
public class UserCartController {

    @Autowired
    private CartService cartService;

    @Autowired
    private WishlistService wishlistService;

    @Autowired
    private VendorProductService productService;

    @Autowired
    private ProductOrderService orderService;

    @Autowired
    private CouponService couponService;

    @Autowired
    private UserService userService;

    @Autowired
    private PaymentService paymentService;

    // ==================== Cart ====================

    @GetMapping("/cart")
    public String viewCart(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login?redirect=/user/dashboard/cart";
        }

        List<Cart> cartItems = cartService.getCartItems(userId);
        BigDecimal subtotal = cartService.getCartTotal(userId);

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("subtotal", subtotal);
        model.addAttribute("user", userService.findById(userId).orElse(null));

        return "user/dashboard/cart";
    }

    @GetMapping("/cart/add/{productId}")
    public String addToCart(@PathVariable Long productId,
                           @RequestParam(defaultValue = "1") int quantity,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login?redirect=/products";
        }

        try {
            User user = userService.findById(userId)
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            cartService.addToCart(user, productId, quantity);
            
            redirectAttributes.addFlashAttribute("success", "Product added to cart!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/user/dashboard/cart";
    }

    @PostMapping("/cart/update/{productId}")
    public String updateCartItem(@PathVariable Long productId,
                                @RequestParam int quantity,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login";
        }

        try {
            cartService.updateQuantity(userId, productId, quantity);
            redirectAttributes.addFlashAttribute("success", "Cart updated!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/user/dashboard/cart";
    }

    @GetMapping("/cart/remove/{productId}")
    public String removeFromCart(@PathVariable Long productId,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login";
        }

        try {
            cartService.removeFromCart(userId, productId);
            redirectAttributes.addFlashAttribute("success", "Item removed from cart");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/user/dashboard/cart";
    }

    @GetMapping("/cart/clear")
    public String clearCart(HttpSession session, RedirectAttributes redirectAttributes) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login";
        }

        try {
            cartService.clearCart(userId);
            redirectAttributes.addFlashAttribute("success", "Cart cleared!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/user/dashboard/cart";
    }

    // ==================== Wishlist ====================

    @GetMapping("/wishlist")
    public String viewWishlist(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login?redirect=/user/dashboard/wishlist";
        }

        List<Wishlist> wishlistItems = wishlistService.getWishlistItems(userId);
        model.addAttribute("wishlistItems", wishlistItems);
        model.addAttribute("user", userService.findById(userId).orElse(null));

        return "user/dashboard/wishlist";
    }

    @GetMapping("/wishlist/toggle/{productId}")
    public String toggleWishlist(@PathVariable Long productId,
                                @RequestParam(required = false) String redirect,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login";
        }

        try {
            if (wishlistService.isInWishlist(userId, productId)) {
                wishlistService.removeFromWishlist(userId, productId);
                redirectAttributes.addFlashAttribute("success", "Removed from wishlist");
            } else {
                User user = userService.findById(userId)
                        .orElseThrow(() -> new RuntimeException("User not found"));
                wishlistService.addToWishlist(user, productId);
                redirectAttributes.addFlashAttribute("success", "Added to wishlist!");
            }
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        if (redirect != null) {
            return "redirect:" + redirect;
        }
        return "redirect:/user/dashboard/wishlist";
    }

    @GetMapping("/wishlist/move-to-cart/{productId}")
    public String moveToCart(@PathVariable Long productId,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login";
        }

        try {
            User user = userService.findById(userId)
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            cartService.addToCart(user, productId, 1);
            wishlistService.removeFromWishlist(userId, productId);
            
            redirectAttributes.addFlashAttribute("success", "Moved to cart!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/user/dashboard/wishlist";
    }

    // ==================== Checkout ====================

    @GetMapping("/checkout")
    public String checkout(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login?redirect=/user/dashboard/checkout";
        }

        User user = userService.findById(userId).orElse(null);
        List<Cart> cartItems = cartService.getCartItems(userId);

        if (cartItems.isEmpty()) {
            return "redirect:/user/dashboard/cart";
        }

        BigDecimal subtotal = cartService.getCartTotal(userId);
        BigDecimal shipping = new BigDecimal("50.00"); // Fixed shipping for now
        BigDecimal total = subtotal.add(shipping);

        model.addAttribute("user", user);
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("subtotal", subtotal);
        model.addAttribute("shipping", shipping);
        model.addAttribute("total", total);

        return "user/dashboard/checkout";
    }

    @PostMapping("/checkout/apply-coupon")
    @ResponseBody
    public String applyCoupon(@RequestParam String code,
                             @RequestParam BigDecimal subtotal,
                             HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "{\"error\": \"Please login first\"}";
        }

        try {
            // Validate coupon with basic parameters (not checking first order/new user for now)
            CouponService.CouponValidationResult result = couponService.validateCoupon(code, subtotal, userId, false, false);
            
            if (!result.isValid()) {
                return "{\"error\": \"" + result.getMessage() + "\"}";
            }
            
            Coupon coupon = result.getCoupon();
            BigDecimal discount = result.getDiscount();
            return "{\"success\": true, \"discount\": " + discount + ", \"couponId\": " + coupon.getId() + "}";
        } catch (RuntimeException e) {
            return "{\"error\": \"" + e.getMessage() + "\"}";
        }
    }

    @PostMapping("/checkout/place-order")
    public String placeOrder(@RequestParam String shippingName,
                            @RequestParam String shippingPhone,
                            @RequestParam String shippingAddressLine1,
                            @RequestParam(required = false) String shippingAddressLine2,
                            @RequestParam String shippingCity,
                            @RequestParam String shippingState,
                            @RequestParam String shippingPinCode,
                            @RequestParam String paymentMethod,
                            @RequestParam(required = false) Long couponId,
                            HttpSession session,
                            Model model,
                            RedirectAttributes redirectAttributes) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login";
        }

        try {
            User user = userService.findById(userId)
                    .orElseThrow(() -> new RuntimeException("User not found"));
            List<Cart> cartItems = cartService.getCartItems(userId);

            if (cartItems.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Your cart is empty");
                return "redirect:/user/dashboard/cart";
            }

            // Create order
            ProductOrder order = new ProductOrder();
            order.setUser(user);
            order.setShippingName(shippingName);
            order.setShippingPhone(shippingPhone);
            order.setShippingAddressLine1(shippingAddressLine1);
            order.setShippingAddressLine2(shippingAddressLine2);
            order.setShippingCity(shippingCity);
            order.setShippingState(shippingState);
            order.setShippingPostalCode(shippingPinCode);
            
            // Validate and set payment method
            try {
                // Convert legacy "ONLINE" to "RAZORPAY" for backward compatibility
                if ("ONLINE".equalsIgnoreCase(paymentMethod)) {
                    paymentMethod = "RAZORPAY";
                }
                order.setPaymentMethod(ProductOrder.PaymentMethod.valueOf(paymentMethod.toUpperCase()));
            } catch (IllegalArgumentException e) {
                redirectAttributes.addFlashAttribute("error", "Invalid payment method selected");
                return "redirect:/user/dashboard/checkout";
            }

            // Apply coupon if provided
            Coupon coupon = null;
            if (couponId != null) {
                coupon = couponService.findById(couponId).orElse(null);
            }

            ProductOrder savedOrder = orderService.createOrder(order, cartItems, coupon);

            // Handle payment based on method
            if ("RAZORPAY".equalsIgnoreCase(paymentMethod)) {
                // Online Payment - Create Razorpay order and show payment page
                try {
                    String razorpayOrderId = paymentService.createRazorpayOrder(savedOrder);
                    savedOrder.setRazorpayOrderId(razorpayOrderId);
                    orderService.save(savedOrder);

                    // Add attributes for payment page
                    model.addAttribute("order", savedOrder);
                    model.addAttribute("razorpayKey", paymentService.getRazorpayKeyId());
                    model.addAttribute("razorpayOrderId", razorpayOrderId);
                    model.addAttribute("user", user);

                    return "user/dashboard/payment";
                } catch (com.razorpay.RazorpayException e) {
                    // If Razorpay fails, cancel the order
                    orderService.cancelOrder(savedOrder.getId(), "Payment gateway error");
                    redirectAttributes.addFlashAttribute("error", "Payment initialization failed. Please try again.");
                    return "redirect:/user/dashboard/checkout";
                }
            } else {
                // Cash on Delivery - directly complete order
                cartService.clearCart(userId);
                redirectAttributes.addFlashAttribute("success", "Order placed successfully!");
                return "redirect:/user/dashboard/orders/" + savedOrder.getId();
            }

        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/user/dashboard/checkout";
        }
    }

    // ==================== Orders ====================

    @GetMapping("/orders")
    public String myOrders(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login?redirect=/user/dashboard/orders";
        }

        List<ProductOrder> orders = orderService.getUserOrders(userId);
        model.addAttribute("orders", orders);
        model.addAttribute("user", userService.findById(userId).orElse(null));

        return "user/dashboard/orders";
    }

    @GetMapping("/orders/{id}")
    public String orderDetails(@PathVariable Long id, HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login";
        }

        ProductOrder order = orderService.findById(id)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        // Verify order belongs to user
        if (!order.getUser().getId().equals(userId)) {
            return "redirect:/user/dashboard/orders";
        }

        model.addAttribute("order", order);
        model.addAttribute("user", userService.findById(userId).orElse(null));

        return "user/dashboard/order-details";
    }
}

