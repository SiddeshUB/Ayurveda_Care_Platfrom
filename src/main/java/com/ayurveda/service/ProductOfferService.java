package com.ayurveda.service;

import com.ayurveda.entity.ProductOffer;
import com.ayurveda.repository.ProductOfferRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
public class ProductOfferService {

    @Autowired
    private ProductOfferRepository offerRepository;

    public List<ProductOffer> getProductOffers(Long productId) {
        return offerRepository.findActiveOffersForProduct(productId, LocalDateTime.now());
    }

    public List<ProductOffer> getGlobalOffers() {
        return offerRepository.findActiveGlobalOffers(LocalDateTime.now());
    }

    public List<ProductOffer> getBankOffers() {
        return offerRepository.findByOfferTypeAndStatusOrderBySortOrderAsc(
            ProductOffer.OfferType.BANK_OFFER, 
            ProductOffer.OfferStatus.ACTIVE
        );
    }

    public List<ProductOffer> getPartnerOffers() {
        return offerRepository.findByOfferTypeAndStatusOrderBySortOrderAsc(
            ProductOffer.OfferType.PARTNER_OFFER, 
            ProductOffer.OfferStatus.ACTIVE
        );
    }

    public List<ProductOffer> getEmiOptions() {
        return offerRepository.findByOfferTypeAndStatusOrderBySortOrderAsc(
            ProductOffer.OfferType.EMI, 
            ProductOffer.OfferStatus.ACTIVE
        );
    }
}

