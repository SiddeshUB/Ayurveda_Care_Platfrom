package com.ayurveda.repository;

import com.ayurveda.entity.HospitalDocument;
import com.ayurveda.entity.HospitalDocument.DocumentType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HospitalDocumentRepository extends JpaRepository<HospitalDocument, Long> {
    
    List<HospitalDocument> findByHospitalId(Long hospitalId);
    
    List<HospitalDocument> findByHospitalIdAndDocumentType(Long hospitalId, DocumentType documentType);
}
