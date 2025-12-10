package com.ayurveda.repository;

import com.ayurveda.entity.VendorDocument;
import com.ayurveda.entity.VendorDocument.DocumentType;
import com.ayurveda.entity.VendorDocument.VerificationStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface VendorDocumentRepository extends JpaRepository<VendorDocument, Long> {

    List<VendorDocument> findByVendorId(Long vendorId);

    Optional<VendorDocument> findByVendorIdAndDocumentType(Long vendorId, DocumentType documentType);

    List<VendorDocument> findByVendorIdAndVerificationStatus(Long vendorId, VerificationStatus status);

    List<VendorDocument> findByVerificationStatus(VerificationStatus status);

    boolean existsByVendorIdAndDocumentType(Long vendorId, DocumentType documentType);

    void deleteByVendorIdAndDocumentType(Long vendorId, DocumentType documentType);
}

