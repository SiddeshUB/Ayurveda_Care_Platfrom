package com.ayurveda.service;

import com.ayurveda.entity.*;
import com.ayurveda.entity.ProductOrder.OrderStatus;
import com.ayurveda.entity.ProductOrder.PaymentStatus;
import com.ayurveda.entity.ProductOrder.PaymentMethod;
import com.ayurveda.entity.OrderItem.ItemStatus;
import com.ayurveda.repository.ProductOrderRepository;
import com.ayurveda.repository.OrderItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ProductOrderService {

    @Autowired
    private ProductOrderRepository orderRepository;

    @Autowired
    private OrderItemRepository orderItemRepository;

    @Autowired
    private CartService cartService;

    @Autowired
    private VendorProductService productService;

    @Autowired
    private VendorWalletService walletService;

    @Autowired
    private VendorService vendorService;

    // ==================== Create Order ====================

    public ProductOrder createOrder(User user, List<Cart> cartItems, ProductOrder orderDetails) {
        if (cartItems == null || cartItems.isEmpty()) {
            throw new RuntimeException("Cart is empty");
        }

        // Create order
        ProductOrder order = new ProductOrder();
        order.setUser(user);

        // Copy shipping details
        order.setShippingName(orderDetails.getShippingName());
        order.setShippingPhone(orderDetails.getShippingPhone());
        order.setShippingEmail(orderDetails.getShippingEmail());
        order.setShippingAddressLine1(orderDetails.getShippingAddressLine1());
        order.setShippingAddressLine2(orderDetails.getShippingAddressLine2());
        order.setShippingCity(orderDetails.getShippingCity());
        order.setShippingState(orderDetails.getShippingState());
        order.setShippingPostalCode(orderDetails.getShippingPostalCode());
        order.setShippingCountry(orderDetails.getShippingCountry() != null ? orderDetails.getShippingCountry() : "India");

        // Billing address
        order.setBillingAddressSame(orderDetails.getBillingAddressSame());
        if (!orderDetails.getBillingAddressSame()) {
            order.setBillingName(orderDetails.getBillingName());
            order.setBillingAddressLine1(orderDetails.getBillingAddressLine1());
            order.setBillingAddressLine2(orderDetails.getBillingAddressLine2());
            order.setBillingCity(orderDetails.getBillingCity());
            order.setBillingState(orderDetails.getBillingState());
            order.setBillingPostalCode(orderDetails.getBillingPostalCode());
        }

        // Payment method
        order.setPaymentMethod(orderDetails.getPaymentMethod());
        order.setCustomerNotes(orderDetails.getCustomerNotes());

        // Calculate totals
        BigDecimal subtotal = BigDecimal.ZERO;
        List<OrderItem> orderItems = new ArrayList<>();

        for (Cart cartItem : cartItems) {
            Product product = cartItem.getProduct();
            Vendor vendor = cartItem.getVendor();

            OrderItem item = new OrderItem();
            item.setOrder(order);
            item.setProduct(product);
            item.setVendor(vendor);
            item.setQuantity(cartItem.getQuantity());
            item.setUnitPrice(cartItem.getUnitPrice());
            item.setTotalPrice(cartItem.getTotalPrice());

            // Store product snapshot
            item.setProductName(product.getProductName());
            item.setProductSku(product.getSku());
            item.setProductImageUrl(product.getImageUrl());

            // Commission calculation
            if (vendor.getCommissionPercentage() != null) {
                item.setCommissionPercentage(vendor.getCommissionPercentage());
                BigDecimal commission = cartItem.getTotalPrice()
                        .multiply(vendor.getCommissionPercentage())
                        .divide(new BigDecimal(100), 2, java.math.RoundingMode.HALF_UP);
                item.setCommissionAmount(commission);
                item.setVendorEarning(cartItem.getTotalPrice().subtract(commission));
            } else {
                item.setVendorEarning(cartItem.getTotalPrice());
            }

            item.setStatus(ItemStatus.PENDING);
            orderItems.add(item);
            subtotal = subtotal.add(cartItem.getTotalPrice());
        }

        order.setSubtotal(subtotal);
        order.setShippingCharges(orderDetails.getShippingCharges() != null ? orderDetails.getShippingCharges() : BigDecimal.ZERO);
        order.setTax(orderDetails.getTax() != null ? orderDetails.getTax() : BigDecimal.ZERO);
        order.setDiscount(orderDetails.getDiscount() != null ? orderDetails.getDiscount() : BigDecimal.ZERO);
        order.setCouponDiscount(orderDetails.getCouponDiscount() != null ? orderDetails.getCouponDiscount() : BigDecimal.ZERO);
        order.setCouponCode(orderDetails.getCouponCode());

        // Set status based on payment method
        if (order.getPaymentMethod() == PaymentMethod.COD) {
            order.setStatus(OrderStatus.CONFIRMED);
            order.setPaymentStatus(PaymentStatus.COD_PENDING);
        } else {
            order.setStatus(OrderStatus.PENDING);
            order.setPaymentStatus(PaymentStatus.PENDING);
        }

        // Save order
        ProductOrder savedOrder = orderRepository.save(order);

        // Save order items
        for (OrderItem item : orderItems) {
            item.setOrder(savedOrder);
            orderItemRepository.save(item);
        }

        // Reduce stock for each product
        for (Cart cartItem : cartItems) {
            productService.reduceStock(cartItem.getProduct().getId(), cartItem.getQuantity());
        }

        // Clear cart
        cartService.clearCart(user.getId());

        return savedOrder;
    }

    // ==================== Payment Confirmation ====================

    public ProductOrder confirmPayment(String orderNumber, String razorpayPaymentId, String razorpaySignature) {
        ProductOrder order = orderRepository.findByOrderNumber(orderNumber)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        order.setRazorpayPaymentId(razorpayPaymentId);
        order.setRazorpaySignature(razorpaySignature);
        order.setPaymentStatus(PaymentStatus.PAID);
        order.setPaymentDate(LocalDateTime.now());
        order.setStatus(OrderStatus.CONFIRMED);

        // Generate invoice
        order.generateInvoiceNumber();

        // Credit vendor wallets
        creditVendorWallets(order);

        return orderRepository.save(order);
    }

    private void creditVendorWallets(ProductOrder order) {
        List<OrderItem> items = orderItemRepository.findByOrderId(order.getId());
        for (OrderItem item : items) {
            if (item.getVendorEarning() != null) {
                walletService.creditPendingBalance(
                    item.getVendor().getId(), 
                    item.getVendorEarning(),
                    item.getCommissionAmount(),
                    order.getId(),
                    order.getOrderNumber()
                );
            }
        }
    }

    // ==================== Order Status Updates ====================

    public ProductOrder updateOrderStatus(Long orderId, OrderStatus status) {
        ProductOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        order.setStatus(status);

        // Update timestamps based on status
        switch (status) {
            case SHIPPED:
                order.setShippedDate(LocalDateTime.now());
                break;
            case DELIVERED:
                order.setDeliveredDate(LocalDateTime.now());
                // Release pending balance to available
                releasePendingBalances(order);
                break;
            case CANCELLED:
                order.setCancelledAt(LocalDateTime.now());
                // Restore stock
                restoreStock(order);
                break;
            default:
                break;
        }

        return orderRepository.save(order);
    }

    public OrderItem updateItemStatus(Long itemId, ItemStatus status, Long vendorId) {
        OrderItem item = orderItemRepository.findById(itemId)
                .orElseThrow(() -> new RuntimeException("Order item not found"));

        // Verify vendor ownership
        if (!item.getVendor().getId().equals(vendorId)) {
            throw new RuntimeException("Unauthorized");
        }

        item.setStatus(status);

        if (status == ItemStatus.DELIVERED) {
            // Release this item's pending balance
            walletService.releasePendingBalance(
                vendorId, 
                item.getVendorEarning(),
                item.getOrder().getId()
            );

            // Update vendor stats
            vendorService.incrementOrderCount(vendorId);
            vendorService.addRevenue(vendorId, item.getVendorEarning());
            productService.incrementSales(item.getProduct().getId(), item.getQuantity());
        }

        return orderItemRepository.save(item);
    }

    private void releasePendingBalances(ProductOrder order) {
        List<OrderItem> items = orderItemRepository.findByOrderId(order.getId());
        for (OrderItem item : items) {
            if (item.getVendorEarning() != null && item.getStatus() != ItemStatus.DELIVERED) {
                walletService.releasePendingBalance(
                    item.getVendor().getId(),
                    item.getVendorEarning(),
                    order.getId()
                );
                item.setStatus(ItemStatus.DELIVERED);
                orderItemRepository.save(item);

                // Update vendor stats
                vendorService.incrementOrderCount(item.getVendor().getId());
                vendorService.addRevenue(item.getVendor().getId(), item.getVendorEarning());
                productService.incrementSales(item.getProduct().getId(), item.getQuantity());
            }
        }
    }

    private void restoreStock(ProductOrder order) {
        List<OrderItem> items = orderItemRepository.findByOrderId(order.getId());
        for (OrderItem item : items) {
            Product product = item.getProduct();
            product.setStockQuantity(product.getStockQuantity() + item.getQuantity());
            if (product.getStockQuantity() > 0) {
                product.setIsAvailable(true);
            }
            productService.save(product);
        }
    }

    // ==================== Get Orders ====================

    public Optional<ProductOrder> findById(Long id) {
        return orderRepository.findById(id);
    }

    public Optional<ProductOrder> findByOrderNumber(String orderNumber) {
        return orderRepository.findByOrderNumber(orderNumber);
    }

    public Optional<ProductOrder> findByRazorpayOrderId(String razorpayOrderId) {
        return orderRepository.findByRazorpayOrderId(razorpayOrderId);
    }

    public ProductOrder save(ProductOrder order) {
        return orderRepository.save(order);
    }

    public List<ProductOrder> getUserOrders(Long userId) {
        return orderRepository.findByUserIdOrderByCreatedAtDesc(userId);
    }

    // Create order from Cart list (used by UserCartController)
    public ProductOrder createOrder(ProductOrder order, List<Cart> cartItems, Coupon coupon) {
        if (cartItems == null || cartItems.isEmpty()) {
            throw new RuntimeException("Cart is empty");
        }

        // Calculate totals
        BigDecimal subtotal = BigDecimal.ZERO;
        List<OrderItem> orderItems = new ArrayList<>();

        for (Cart cartItem : cartItems) {
            Product product = cartItem.getProduct();
            Vendor vendor = cartItem.getVendor();

            OrderItem item = new OrderItem();
            item.setProduct(product);
            item.setVendor(vendor);
            item.setQuantity(cartItem.getQuantity());
            item.setUnitPrice(cartItem.getUnitPrice());
            item.setTotalPrice(cartItem.getTotalPrice());

            // Store product snapshot
            item.setProductName(product.getProductName());
            item.setProductSku(product.getSku());
            item.setProductImageUrl(product.getImageUrl());

            // Commission calculation
            if (vendor.getCommissionPercentage() != null) {
                item.setCommissionPercentage(vendor.getCommissionPercentage());
                BigDecimal commission = cartItem.getTotalPrice()
                        .multiply(vendor.getCommissionPercentage())
                        .divide(new BigDecimal(100), 2, java.math.RoundingMode.HALF_UP);
                item.setCommissionAmount(commission);
                item.setVendorEarning(cartItem.getTotalPrice().subtract(commission));
            } else {
                item.setVendorEarning(cartItem.getTotalPrice());
                item.setCommissionAmount(BigDecimal.ZERO);
            }

            item.setStatus(ItemStatus.PENDING);
            orderItems.add(item);
            subtotal = subtotal.add(cartItem.getTotalPrice());
        }

        order.setSubtotal(subtotal);
        order.setShippingCharges(new BigDecimal("50.00")); // Fixed shipping

        // Apply coupon discount
        if (coupon != null) {
            BigDecimal discount = calculateCouponDiscount(coupon, subtotal);
            order.setCouponDiscount(discount);
            order.setCouponCode(coupon.getCode());
        } else {
            order.setCouponDiscount(BigDecimal.ZERO);
        }

        // Set status based on payment method
        if (order.getPaymentMethod() == PaymentMethod.COD) {
            order.setStatus(OrderStatus.CONFIRMED);
            order.setPaymentStatus(PaymentStatus.COD_PENDING);
        } else {
            order.setStatus(OrderStatus.PENDING);
            order.setPaymentStatus(PaymentStatus.PENDING);
        }

        // Save order
        ProductOrder savedOrder = orderRepository.save(order);

        // Save order items
        for (OrderItem item : orderItems) {
            item.setOrder(savedOrder);
            orderItemRepository.save(item);
        }

        savedOrder.setOrderItems(orderItems);

        // Reduce stock for each product
        for (Cart cartItem : cartItems) {
            productService.reduceStock(cartItem.getProduct().getId(), cartItem.getQuantity());
        }

        return savedOrder;
    }

    private BigDecimal calculateCouponDiscount(Coupon coupon, BigDecimal subtotal) {
        if (coupon == null || subtotal == null) {
            return BigDecimal.ZERO;
        }
        
        // Check minimum order amount
        if (coupon.getMinOrderAmount() != null && subtotal.compareTo(coupon.getMinOrderAmount()) < 0) {
            return BigDecimal.ZERO;
        }

        BigDecimal discount;
        if (coupon.getDiscountType() != null && coupon.getDiscountType().name().equals("PERCENTAGE")) {
            discount = subtotal.multiply(coupon.getDiscountValue())
                    .divide(new BigDecimal(100), 2, java.math.RoundingMode.HALF_UP);
            // Apply max discount cap
            if (coupon.getMaxDiscountAmount() != null && discount.compareTo(coupon.getMaxDiscountAmount()) > 0) {
                discount = coupon.getMaxDiscountAmount();
            }
        } else {
            discount = coupon.getDiscountValue();
        }

        return discount != null ? discount : BigDecimal.ZERO;
    }

    public void cancelOrder(Long orderId, String reason) {
        ProductOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        order.setStatus(OrderStatus.CANCELLED);
        order.setCancellationReason(reason);
        order.setCancelledAt(LocalDateTime.now());

        // Restore stock
        restoreStock(order);

        orderRepository.save(order);
    }

    public List<ProductOrder> findByUserId(Long userId) {
        return orderRepository.findByUserIdOrderByCreatedAtDesc(userId);
    }

    public Page<ProductOrder> findByUserId(Long userId, Pageable pageable) {
        return orderRepository.findByUserId(userId, pageable);
    }

    public Page<ProductOrder> findByVendorId(Long vendorId, Pageable pageable) {
        return orderRepository.findByVendorId(vendorId, pageable);
    }

    public List<OrderItem> findOrderItemsByVendorId(Long vendorId) {
        return orderItemRepository.findByVendorIdOrderByOrderCreatedAtDesc(vendorId);
    }

    public Page<OrderItem> findOrderItemsByVendorId(Long vendorId, Pageable pageable) {
        return orderItemRepository.findByVendorId(vendorId, pageable);
    }

    public List<OrderItem> getOrderItems(Long orderId) {
        return orderItemRepository.findByOrderId(orderId);
    }

    // ==================== Admin Operations ====================

    public Page<ProductOrder> findAll(Pageable pageable) {
        return orderRepository.findAll(pageable);
    }

    public Page<ProductOrder> searchOrders(String keyword, Pageable pageable) {
        return orderRepository.searchOrders(keyword, pageable);
    }

    public List<ProductOrder> findByStatus(OrderStatus status) {
        return orderRepository.findByStatus(status);
    }

    public long countPendingOrders() {
        return orderRepository.countPendingOrders();
    }

    // ==================== Statistics ====================

    public BigDecimal getTotalRevenue() {
        BigDecimal revenue = orderRepository.getTotalRevenue();
        return revenue != null ? revenue : BigDecimal.ZERO;
    }

    public BigDecimal getRevenueInDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        BigDecimal revenue = orderRepository.getRevenueInDateRange(startDate, endDate);
        return revenue != null ? revenue : BigDecimal.ZERO;
    }

    public long countOrdersInDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        return orderRepository.countOrdersInDateRange(startDate, endDate);
    }

    // ==================== Cancel Order ====================

    public ProductOrder cancelOrder(Long orderId, String reason, Long userId) {
        ProductOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        // Verify user ownership
        if (!order.getUser().getId().equals(userId)) {
            throw new RuntimeException("Unauthorized");
        }

        // Can only cancel pending/confirmed orders
        if (order.getStatus() != OrderStatus.PENDING && 
            order.getStatus() != OrderStatus.CONFIRMED &&
            order.getStatus() != OrderStatus.PROCESSING) {
            throw new RuntimeException("Order cannot be cancelled at this stage");
        }

        order.setStatus(OrderStatus.CANCELLED);
        order.setCancellationReason(reason);
        order.setCancelledAt(LocalDateTime.now());

        // Restore stock
        restoreStock(order);

        // Handle refund if paid
        if (order.getPaymentStatus() == PaymentStatus.PAID) {
            order.setPaymentStatus(PaymentStatus.REFUNDED);
            order.setRefundAmount(order.getTotalAmount());
            order.setRefundedAt(LocalDateTime.now());
            // TODO: Process actual refund via Razorpay
        }

        return orderRepository.save(order);
    }
}

