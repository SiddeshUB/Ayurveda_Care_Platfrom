package com.ayurveda.service;

import com.ayurveda.entity.ProductVariant;
import com.ayurveda.repository.ProductVariantRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Transactional
public class ProductVariantService {

    @Autowired
    private ProductVariantRepository variantRepository;

    public List<ProductVariant> getProductVariants(Long productId) {
        return variantRepository.findByProductIdAndIsActiveTrueOrderByVariantTypeAscSortOrderAsc(productId);
    }

    public Map<ProductVariant.VariantType, List<ProductVariant>> getVariantsGroupedByType(Long productId) {
        List<ProductVariant> variants = getProductVariants(productId);
        return variants.stream()
                .collect(Collectors.groupingBy(ProductVariant::getVariantType));
    }

    public ProductVariant getVariantById(Long variantId) {
        return variantRepository.findByIdAndIsActiveTrue(variantId)
                .orElse(null);
    }

    public ProductVariant getDefaultVariant(Long productId) {
        return variantRepository.findByProductIdAndIsDefaultTrue(productId)
                .orElse(null);
    }
}

