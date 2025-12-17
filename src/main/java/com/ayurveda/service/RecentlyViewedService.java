package com.ayurveda.service;

import com.ayurveda.entity.Product;
import com.ayurveda.entity.RecentlyViewedProduct;
import com.ayurveda.entity.User;
import com.ayurveda.repository.RecentlyViewedProductRepository;
import com.ayurveda.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class RecentlyViewedService {

    @Autowired
    private RecentlyViewedProductRepository viewedRepository;

    @Autowired
    private ProductRepository productRepository;

    public void recordView(User user, Long productId) {
        if (user == null) return;

        Product product = productRepository.findById(productId)
                .orElse(null);
        if (product == null) return;

        Optional<RecentlyViewedProduct> existing = viewedRepository.findByUserIdAndProductId(user.getId(), productId);
        
        if (existing.isPresent()) {
            // Update timestamp
            RecentlyViewedProduct rvp = existing.get();
            rvp.setViewedAt(LocalDateTime.now());
            viewedRepository.save(rvp);
        } else {
            // Create new
            RecentlyViewedProduct rvp = new RecentlyViewedProduct();
            rvp.setUser(user);
            rvp.setProduct(product);
            viewedRepository.save(rvp);
        }

        // Clean up old views (keep last 50)
        List<RecentlyViewedProduct> allViews = viewedRepository.findRecentByUserId(user.getId());
        if (allViews.size() > 50) {
            LocalDateTime cutoff = allViews.get(49).getViewedAt();
            viewedRepository.deleteOldViews(user.getId(), cutoff);
        }
    }

    public List<RecentlyViewedProduct> getRecentViews(User user, int limit) {
        if (user == null) return List.of();
        return viewedRepository.findRecentByUserIdLimit(user.getId(), limit);
    }
}

