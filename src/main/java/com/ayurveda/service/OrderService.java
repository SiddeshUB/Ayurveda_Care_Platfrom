package com.ayurveda.service;

import com.ayurveda.entity.*;
import com.ayurveda.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class OrderService {

    private final ProductOrderRepository orderRepository;
    private final OrderItemRepository orderItemRepository;
    private final CartRepository cartRepository;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;

    @Autowired
    public OrderService(ProductOrderRepository orderRepository,
                       OrderItemRepository orderItemRepository,
                       CartRepository cartRepository,
                       ProductRepository productRepository,
                       UserRepository userRepository) {
        this.orderRepository = orderRepository;
        this.orderItemRepository = orderItemRepository;
        this.cartRepository = cartRepository;
        this.productRepository = productRepository;
        this.userRepository = userRepository;
    }

    public List<ProductOrder> getUserOrders(Long userId) {
        return orderRepository.findByUserIdOrderByCreatedAtDesc(userId);
    }

    public List<ProductOrder> getVendorOrders(Long vendorId) {
        return orderRepository.findByVendorId(vendorId);
    }

    public Optional<ProductOrder> findById(Long orderId) {
        return orderRepository.findById(orderId);
    }

    public Optional<ProductOrder> findByOrderNumber(String orderNumber) {
        return orderRepository.findByOrderNumber(orderNumber);
    }

    @Transactional
    public ProductOrder createOrderFromCart(Long userId, ProductOrder orderData) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        List<Cart> cartItems = cartRepository.findByUserIdAndSavedForLaterFalseOrderByCreatedAtDesc(userId);
        if (cartItems.isEmpty()) {
            throw new RuntimeException("Cart is empty");
        }

        // Multi-vendor order is supported - each order item tracks its vendor

        // Create order
        ProductOrder order = new ProductOrder();
        order.setUser(user);
        order.setStatus(ProductOrder.OrderStatus.PENDING);
        order.setPaymentStatus(ProductOrder.PaymentStatus.PENDING);
        order.setPaymentMethod(orderData.getPaymentMethod() != null ? orderData.getPaymentMethod() : ProductOrder.PaymentMethod.COD);

        // Set shipping address
        order.setShippingName(orderData.getShippingName());
        order.setShippingPhone(orderData.getShippingPhone());
        order.setShippingEmail(orderData.getShippingEmail());
        order.setShippingAddressLine1(orderData.getShippingAddressLine1());
        order.setShippingAddressLine2(orderData.getShippingAddressLine2());
        order.setShippingCity(orderData.getShippingCity());
        order.setShippingState(orderData.getShippingState());
        order.setShippingPostalCode(orderData.getShippingPostalCode());
        order.setShippingCountry(orderData.getShippingCountry());
        order.setCustomerNotes(orderData.getCustomerNotes());

        // Calculate totals
        BigDecimal subtotal = BigDecimal.ZERO;
        for (Cart cartItem : cartItems) {
            Product product = cartItem.getProduct();
            
            // Check stock
            if (product.getTrackInventory() != null && product.getTrackInventory()) {
                if (product.getStockQuantity() == null || product.getStockQuantity() < cartItem.getQuantity()) {
                    throw new RuntimeException("Insufficient stock for product: " + product.getProductName());
                }
            }

            subtotal = subtotal.add(cartItem.getTotalPrice());
        }

        order.setSubtotal(subtotal);
        order.setShippingCharges(orderData.getShippingCharges() != null ? orderData.getShippingCharges() : BigDecimal.ZERO);
        order.setDiscount(orderData.getDiscount() != null ? orderData.getDiscount() : BigDecimal.ZERO);
        order.setTax(orderData.getTax() != null ? orderData.getTax() : BigDecimal.ZERO);

        // Save order (this will trigger total calculation)
        ProductOrder savedOrder = orderRepository.save(order);

        // Save order items
        for (Cart cartItem : cartItems) {
            Product product = cartItem.getProduct();
            Vendor vendor = cartItem.getVendor();
            
            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(savedOrder);
            orderItem.setProduct(product);
            orderItem.setVendor(vendor);
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setUnitPrice(cartItem.getUnitPrice());
            orderItem.setTotalPrice(cartItem.getTotalPrice());
            orderItem.setProductName(product.getProductName());
            orderItem.setProductSku(product.getSku());
            
            // Calculate vendor commission
            if (vendor != null && vendor.getCommissionPercentage() != null) {
                BigDecimal commissionRate = vendor.getCommissionPercentage();
                BigDecimal commissionAmount = cartItem.getTotalPrice()
                        .multiply(commissionRate)
                        .divide(new BigDecimal("100"), 2, BigDecimal.ROUND_HALF_UP);
                BigDecimal vendorEarning = cartItem.getTotalPrice().subtract(commissionAmount);
                
                orderItem.setCommissionPercentage(commissionRate);
                orderItem.setCommissionAmount(commissionAmount);
                orderItem.setVendorEarning(vendorEarning);
            } else {
                orderItem.setCommissionPercentage(BigDecimal.ZERO);
                orderItem.setCommissionAmount(BigDecimal.ZERO);
                orderItem.setVendorEarning(cartItem.getTotalPrice());
            }
            
            orderItemRepository.save(orderItem);

            // Update product stock
            if (product.getTrackInventory() != null && product.getTrackInventory()) {
                int newStock = product.getStockQuantity() - cartItem.getQuantity();
                product.setStockQuantity(newStock);
                if (newStock <= 0) {
                    product.setIsAvailable(false);
                }
                productRepository.save(product);
            }

            // Update product sales count
            if (product.getTotalSales() == null) {
                product.setTotalSales(0L);
            }
            product.setTotalSales(product.getTotalSales() + cartItem.getQuantity());
            productRepository.save(product);
        }

        // Clear cart
        cartRepository.deleteByUserId(userId);

        return savedOrder;
    }

    @Transactional
    public ProductOrder updateOrderStatus(Long orderId, ProductOrder.OrderStatus status) {
        ProductOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        order.setStatus(status);
        
        if (status == ProductOrder.OrderStatus.SHIPPED) {
            order.setShippedDate(LocalDateTime.now());
        } else if (status == ProductOrder.OrderStatus.DELIVERED) {
            order.setDeliveredDate(LocalDateTime.now());
        }
        
        return orderRepository.save(order);
    }

    @Transactional
    public ProductOrder updatePaymentStatus(Long orderId, ProductOrder.PaymentStatus status) {
        ProductOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        order.setPaymentStatus(status);
        
        if (status == ProductOrder.PaymentStatus.PAID) {
            order.setPaymentDate(LocalDateTime.now());
            order.setStatus(ProductOrder.OrderStatus.CONFIRMED);
        }
        
        return orderRepository.save(order);
    }
}

