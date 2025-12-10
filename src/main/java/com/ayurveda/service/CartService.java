package com.ayurveda.service;

import com.ayurveda.entity.Cart;
import com.ayurveda.entity.Product;
import com.ayurveda.entity.User;
import com.ayurveda.repository.CartRepository;
import com.ayurveda.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class CartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private ProductRepository productRepository;

    // ==================== Add to Cart ====================

    public Cart addToCart(User user, Long productId, int quantity) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        if (!product.getIsActive() || !product.getIsAvailable()) {
            throw new RuntimeException("Product is not available");
        }

        // Check stock
        if (product.getTrackInventory() && product.getStockQuantity() < quantity) {
            throw new RuntimeException("Insufficient stock. Available: " + product.getStockQuantity());
        }

        // Check if already in cart
        Optional<Cart> existingItem = cartRepository.findByUserIdAndProductId(user.getId(), productId);

        if (existingItem.isPresent()) {
            // Update quantity
            Cart cart = existingItem.get();
            int newQuantity = cart.getQuantity() + quantity;

            // Check stock for new quantity
            if (product.getTrackInventory() && product.getStockQuantity() < newQuantity) {
                throw new RuntimeException("Cannot add more. Only " + product.getStockQuantity() + " available");
            }

            cart.setQuantity(newQuantity);
            return cartRepository.save(cart);
        } else {
            // Create new cart item
            BigDecimal price = product.getEffectivePrice();
            Cart cart = new Cart(user, product, product.getVendor(), quantity, price);
            return cartRepository.save(cart);
        }
    }

    // ==================== Update Cart ====================

    public Cart updateQuantity(Long userId, Long productId, int quantity) {
        Cart cart = cartRepository.findByUserIdAndProductId(userId, productId)
                .orElseThrow(() -> new RuntimeException("Item not in cart"));

        Product product = cart.getProduct();

        if (quantity <= 0) {
            cartRepository.delete(cart);
            return null;
        }

        // Check stock
        if (product.getTrackInventory() && product.getStockQuantity() < quantity) {
            throw new RuntimeException("Insufficient stock. Available: " + product.getStockQuantity());
        }

        cart.setQuantity(quantity);
        return cartRepository.save(cart);
    }

    // ==================== Remove from Cart ====================

    public void removeFromCart(Long userId, Long productId) {
        cartRepository.deleteByUserIdAndProductId(userId, productId);
    }

    public void clearCart(Long userId) {
        cartRepository.clearUserCart(userId);
    }

    // ==================== Get Cart ====================

    public List<Cart> getCartItems(Long userId) {
        return cartRepository.findByUserIdAndSavedForLaterFalseOrderByCreatedAtDesc(userId);
    }

    public List<Cart> getSavedForLaterItems(Long userId) {
        return cartRepository.findByUserIdAndSavedForLaterTrueOrderByCreatedAtDesc(userId);
    }

    public Optional<Cart> getCartItem(Long userId, Long productId) {
        return cartRepository.findByUserIdAndProductId(userId, productId);
    }

    public boolean isInCart(Long userId, Long productId) {
        return cartRepository.existsByUserIdAndProductId(userId, productId);
    }

    // ==================== Cart Totals ====================

    public int getCartItemCount(Long userId) {
        return (int) cartRepository.countByUserIdAndSavedForLaterFalse(userId);
    }

    public BigDecimal getCartTotal(Long userId) {
        BigDecimal total = cartRepository.getCartTotal(userId);
        return total != null ? total : BigDecimal.ZERO;
    }

    public CartSummary getCartSummary(Long userId) {
        List<Cart> items = getCartItems(userId);
        BigDecimal subtotal = BigDecimal.ZERO;
        int itemCount = 0;

        for (Cart item : items) {
            subtotal = subtotal.add(item.getTotalPrice());
            itemCount += item.getQuantity();
        }

        return new CartSummary(items.size(), itemCount, subtotal);
    }

    // ==================== Save for Later ====================

    public Cart saveForLater(Long userId, Long productId) {
        Cart cart = cartRepository.findByUserIdAndProductId(userId, productId)
                .orElseThrow(() -> new RuntimeException("Item not in cart"));
        cart.setSavedForLater(true);
        return cartRepository.save(cart);
    }

    public Cart moveToCart(Long userId, Long productId) {
        Cart cart = cartRepository.findByUserIdAndProductId(userId, productId)
                .orElseThrow(() -> new RuntimeException("Item not found"));
        cart.setSavedForLater(false);
        return cartRepository.save(cart);
    }

    // ==================== Price Update (on checkout) ====================

    public void refreshCartPrices(Long userId) {
        List<Cart> items = getCartItems(userId);
        for (Cart item : items) {
            Product product = item.getProduct();
            BigDecimal currentPrice = product.getEffectivePrice();
            if (!currentPrice.equals(item.getUnitPrice())) {
                item.setUnitPrice(currentPrice);
                cartRepository.save(item);
            }
        }
    }

    // ==================== Validate Cart for Checkout ====================

    public CartValidationResult validateCart(Long userId) {
        List<Cart> items = getCartItems(userId);
        CartValidationResult result = new CartValidationResult();
        result.setValid(true);

        for (Cart item : items) {
            Product product = item.getProduct();

            // Check if product is still active
            if (!product.getIsActive() || !product.getIsAvailable()) {
                result.setValid(false);
                result.addIssue(product.getProductName() + " is no longer available");
                continue;
            }

            // Check stock
            if (product.getTrackInventory() && product.getStockQuantity() < item.getQuantity()) {
                result.setValid(false);
                result.addIssue(product.getProductName() + ": Only " + product.getStockQuantity() + " available");
            }
        }

        return result;
    }

    // ==================== Inner Classes ====================

    public static class CartSummary {
        private int totalItems;
        private int totalQuantity;
        private BigDecimal subtotal;

        public CartSummary(int totalItems, int totalQuantity, BigDecimal subtotal) {
            this.totalItems = totalItems;
            this.totalQuantity = totalQuantity;
            this.subtotal = subtotal;
        }

        public int getTotalItems() { return totalItems; }
        public int getTotalQuantity() { return totalQuantity; }
        public BigDecimal getSubtotal() { return subtotal; }
    }

    public static class CartValidationResult {
        private boolean valid;
        private java.util.List<String> issues = new java.util.ArrayList<>();

        public boolean isValid() { return valid; }
        public void setValid(boolean valid) { this.valid = valid; }
        public java.util.List<String> getIssues() { return issues; }
        public void addIssue(String issue) { this.issues.add(issue); }
    }
}
