package com.ayurveda.service;

import com.ayurveda.entity.Product;
import com.ayurveda.entity.User;
import com.ayurveda.entity.Wishlist;
import com.ayurveda.repository.ProductRepository;
import com.ayurveda.repository.WishlistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class WishlistService {

    @Autowired
    private WishlistRepository wishlistRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CartService cartService;

    // ==================== Add to Wishlist ====================

    public Wishlist addToWishlist(User user, Long productId) {
        // Check if already in wishlist
        if (wishlistRepository.existsByUserIdAndProductId(user.getId(), productId)) {
            throw new RuntimeException("Product already in wishlist");
        }

        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        Wishlist wishlist = new Wishlist(user, product);
        return wishlistRepository.save(wishlist);
    }

    // ==================== Remove from Wishlist ====================

    public void removeFromWishlist(Long userId, Long productId) {
        wishlistRepository.deleteByUserIdAndProductId(userId, productId);
    }

    public void clearWishlist(Long userId) {
        wishlistRepository.deleteAllByUserId(userId);
    }

    // ==================== Get Wishlist ====================

    public List<Wishlist> getWishlistItems(Long userId) {
        return wishlistRepository.findByUserIdOrderByAddedAtDesc(userId);
    }

    public Optional<Wishlist> getWishlistItem(Long userId, Long productId) {
        return wishlistRepository.findByUserIdAndProductId(userId, productId);
    }

    public boolean isInWishlist(Long userId, Long productId) {
        return wishlistRepository.existsByUserIdAndProductId(userId, productId);
    }

    public int getWishlistCount(Long userId) {
        return wishlistRepository.countByUserId(userId);
    }

    // ==================== Move to Cart ====================

    public void moveToCart(User user, Long productId) {
        // Add to cart
        cartService.addToCart(user, productId, 1);

        // Remove from wishlist
        wishlistRepository.deleteByUserIdAndProductId(user.getId(), productId);
    }

    public void moveAllToCart(User user) {
        List<Wishlist> items = getWishlistItems(user.getId());
        for (Wishlist item : items) {
            try {
                cartService.addToCart(user, item.getProduct().getId(), 1);
                wishlistRepository.delete(item);
            } catch (Exception e) {
                // Skip items that can't be added (out of stock, etc.)
            }
        }
    }

    // ==================== Toggle Wishlist ====================

    public boolean toggleWishlist(User user, Long productId) {
        if (isInWishlist(user.getId(), productId)) {
            removeFromWishlist(user.getId(), productId);
            return false; // Removed
        } else {
            addToWishlist(user, productId);
            return true; // Added
        }
    }
}

