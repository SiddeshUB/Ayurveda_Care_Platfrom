package com.ayurveda.service;

import com.ayurveda.entity.Hospital;
import com.ayurveda.entity.HospitalDocument;
import com.ayurveda.entity.HospitalDocument.DocumentType;
import com.ayurveda.entity.HospitalDocument.VerificationStatus;
import com.ayurveda.repository.HospitalDocumentRepository;
import com.ayurveda.repository.HospitalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Service
public class DocumentService {

    private final HospitalDocumentRepository documentRepository;
    private final HospitalRepository hospitalRepository;
    private final FileStorageService fileStorageService;

    @Autowired
    public DocumentService(HospitalDocumentRepository documentRepository,
                          HospitalRepository hospitalRepository,
                          FileStorageService fileStorageService) {
        this.documentRepository = documentRepository;
        this.hospitalRepository = hospitalRepository;
        this.fileStorageService = fileStorageService;
    }

    public List<HospitalDocument> getDocumentsByHospital(Long hospitalId) {
        return documentRepository.findByHospitalId(hospitalId);
    }

    public List<HospitalDocument> getDocumentsByType(Long hospitalId, DocumentType type) {
        return documentRepository.findByHospitalIdAndDocumentType(hospitalId, type);
    }

    public Optional<HospitalDocument> findById(Long id) {
        return documentRepository.findById(id);
    }

    @Transactional
    public HospitalDocument uploadDocument(Long hospitalId, MultipartFile file, 
                                           DocumentType documentType, String description) throws IOException {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        String fileName = fileStorageService.storeFile(file, "documents");
        
        HospitalDocument document = new HospitalDocument();
        document.setHospital(hospital);
        document.setDocumentUrl("/uploads/documents/" + fileName);
        document.setOriginalFileName(file.getOriginalFilename());
        document.setDocumentType(documentType);
        document.setDescription(description);
        document.setVerificationStatus(VerificationStatus.PENDING);
        
        return documentRepository.save(document);
    }

    @Transactional
    public void deleteDocument(Long documentId) throws IOException {
        HospitalDocument document = documentRepository.findById(documentId)
                .orElseThrow(() -> new RuntimeException("Document not found"));
        
        fileStorageService.deleteFile(document.getDocumentUrl());
        documentRepository.delete(document);
    }
}
