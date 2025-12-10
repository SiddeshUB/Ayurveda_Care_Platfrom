package com.ayurveda.controller;

import com.ayurveda.entity.*;
import com.ayurveda.service.*;
import com.razorpay.RazorpayException;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private ProductOrderService orderService;

    @Autowired
    private CartService cartService;

    @Autowired
    private CouponService couponService;

    @Autowired
    private UserService userService;

    @Autowired
    private VendorWalletService walletService;

    @Autowired
    private BookingService bookingService;

    /**
     * Initiate payment - Create order and show payment page
     */
    @PostMapping("/initiate")
    public String initiatePayment(@RequestParam String shippingName,
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
            order.setPaymentMethod(ProductOrder.PaymentMethod.valueOf(paymentMethod));

            // Apply coupon if provided
            Coupon coupon = null;
            if (couponId != null) {
                coupon = couponService.findById(couponId).orElse(null);
            }

            ProductOrder savedOrder = orderService.createOrder(order, cartItems, coupon);

            if ("COD".equals(paymentMethod)) {
                // Cash on Delivery - directly complete order
                cartService.clearCart(userId);
                redirectAttributes.addFlashAttribute("success", "Order placed successfully!");
                return "redirect:/user/dashboard/orders/" + savedOrder.getId();
            } else {
                // Online Payment - Create Razorpay order
                try {
                    String razorpayOrderId = paymentService.createRazorpayOrder(savedOrder);
                    savedOrder.setRazorpayOrderId(razorpayOrderId);
                    orderService.save(savedOrder);

                    model.addAttribute("order", savedOrder);
                    model.addAttribute("razorpayKey", paymentService.getRazorpayKeyId());
                    model.addAttribute("razorpayOrderId", razorpayOrderId);
                    model.addAttribute("user", user);

                    return "user/dashboard/payment";

                } catch (RazorpayException e) {
                    // If Razorpay fails, cancel the order
                    orderService.cancelOrder(savedOrder.getId(), "Payment gateway error");
                    redirectAttributes.addFlashAttribute("error", "Payment initialization failed. Please try again.");
                    return "redirect:/user/dashboard/checkout";
                }
            }

        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/user/dashboard/checkout";
        }
    }

    /**
     * Verify payment callback from Razorpay
     */
    @PostMapping("/verify")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> verifyPayment(
            @RequestParam String razorpay_order_id,
            @RequestParam String razorpay_payment_id,
            @RequestParam String razorpay_signature,
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        Long userId = (Long) session.getAttribute("userId");

        if (userId == null) {
            response.put("success", false);
            response.put("message", "Session expired");
            return ResponseEntity.ok(response);
        }

        try {
            // Find order by Razorpay order ID
            ProductOrder order = orderService.findByRazorpayOrderId(razorpay_order_id)
                    .orElseThrow(() -> new RuntimeException("Order not found"));

            // Verify signature
            boolean isValid = paymentService.verifyPaymentSignature(
                    razorpay_order_id, razorpay_payment_id, razorpay_signature);

            if (isValid) {
                // Update order with payment details
                order.setRazorpayPaymentId(razorpay_payment_id);
                order.setRazorpaySignature(razorpay_signature);
                order.setPaymentStatus(ProductOrder.PaymentStatus.PAID);
                order.setStatus(ProductOrder.OrderStatus.CONFIRMED);
                orderService.save(order);

                // Clear cart
                cartService.clearCart(userId);

                // Credit vendor wallets
                walletService.creditVendorWallets(order);

                response.put("success", true);
                response.put("orderId", order.getId());
                response.put("message", "Payment successful!");
            } else {
                order.setPaymentStatus(ProductOrder.PaymentStatus.FAILED);
                orderService.save(order);

                response.put("success", false);
                response.put("message", "Payment verification failed");
            }

        } catch (RuntimeException e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    /**
     * Payment success page - redirects to dashboard with success message
     */
    @GetMapping("/success/{orderId}")
    public String paymentSuccess(@PathVariable Long orderId, HttpSession session, RedirectAttributes redirectAttributes) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login";
        }

        ProductOrder order = orderService.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        if (!order.getUser().getId().equals(userId)) {
            return "redirect:/user/dashboard/orders";
        }

        redirectAttributes.addFlashAttribute("success", "Payment successful! Your order has been confirmed.");
        return "redirect:/user/dashboard";
    }

    /**
     * Payment failure page
     */
    @GetMapping("/failed/{orderId}")
    public String paymentFailed(@PathVariable Long orderId, HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login";
        }

        ProductOrder order = orderService.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        if (!order.getUser().getId().equals(userId)) {
            return "redirect:/user/dashboard/orders";
        }

        model.addAttribute("order", order);
        return "user/dashboard/payment-failed";
    }

    // ========== BOOKING PAYMENT METHODS ==========

    /**
     * Initiate booking payment - Create Razorpay order and show payment page
     */
    @PostMapping("/booking/initiate")
    public String initiateBookingPayment(@RequestParam String bookingNumber,
                                        HttpSession session,
                                        Model model,
                                        RedirectAttributes redirectAttributes) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            redirectAttributes.addFlashAttribute("error", "Please login to make payment");
            return "redirect:/user/login";
        }

        try {
            Booking booking = bookingService.findByBookingNumber(bookingNumber)
                    .orElseThrow(() -> new RuntimeException("Booking not found"));

            // Verify booking belongs to user
            if (booking.getUser() == null || !booking.getUser().getId().equals(userId)) {
                redirectAttributes.addFlashAttribute("error", "Unauthorized access");
                return "redirect:/user/dashboard";
            }

            // Check if booking is confirmed
            if (booking.getStatus() != Booking.BookingStatus.CONFIRMED) {
                redirectAttributes.addFlashAttribute("error", "Booking must be confirmed before payment");
                return "redirect:/booking/confirmation/" + bookingNumber;
            }

            // Check if already paid
            if (booking.getPaymentStatus() == Booking.PaymentStatus.PAID) {
                redirectAttributes.addFlashAttribute("info", "Payment already completed");
                return "redirect:/user/dashboard";
            }

            // Create Razorpay order
            try {
                String razorpayOrderId = paymentService.createRazorpayOrderForBooking(booking);
                booking.setRazorpayOrderId(razorpayOrderId);
                bookingService.save(booking);

                model.addAttribute("booking", booking);
                model.addAttribute("razorpayKey", paymentService.getRazorpayKeyId());
                model.addAttribute("razorpayOrderId", razorpayOrderId);
                model.addAttribute("user", booking.getUser());

                return "user/dashboard/booking-payment";

            } catch (RazorpayException e) {
                redirectAttributes.addFlashAttribute("error", "Payment initialization failed. Please try again.");
                return "redirect:/booking/confirmation/" + bookingNumber;
            }

        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/user/dashboard";
        }
    }

    /**
     * Verify booking payment callback from Razorpay
     */
    @PostMapping("/booking/verify")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> verifyBookingPayment(
            @RequestParam String razorpay_order_id,
            @RequestParam String razorpay_payment_id,
            @RequestParam String razorpay_signature,
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        Long userId = (Long) session.getAttribute("userId");

        if (userId == null) {
            response.put("success", false);
            response.put("message", "Session expired");
            return ResponseEntity.ok(response);
        }

        try {
            // Find booking by Razorpay order ID
            Booking booking = bookingService.findByRazorpayOrderId(razorpay_order_id)
                    .orElseThrow(() -> new RuntimeException("Booking not found"));

            // Verify signature
            boolean isValid = paymentService.verifyPaymentSignature(
                    razorpay_order_id, razorpay_payment_id, razorpay_signature);

            if (isValid) {
                // Update booking with payment details
                bookingService.updatePaymentDetails(booking.getId(), razorpay_order_id, 
                        razorpay_payment_id, razorpay_signature);

                response.put("success", true);
                response.put("bookingNumber", booking.getBookingNumber());
                response.put("message", "Payment successful!");
            } else {
                booking.setPaymentStatus(Booking.PaymentStatus.PENDING);
                bookingService.save(booking);

                response.put("success", false);
                response.put("message", "Payment verification failed");
            }

        } catch (RuntimeException e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    /**
     * Booking payment success redirect
     */
    @GetMapping("/booking/success")
    public String bookingPaymentSuccess(HttpSession session, RedirectAttributes redirectAttributes) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/user/login";
        }

        redirectAttributes.addFlashAttribute("success", "Payment successful! Your booking has been confirmed.");
        return "redirect:/user/dashboard";
    }
}

