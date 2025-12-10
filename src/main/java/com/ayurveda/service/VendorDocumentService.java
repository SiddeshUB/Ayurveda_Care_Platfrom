package com.ayurveda.service;

import com.ayurveda.entity.Vendor;
import com.ayurveda.entity.VendorDocument;
import com.ayurveda.entity.VendorDocument.DocumentType;
import com.ayurveda.entity.VendorDocument.VerificationStatus;
import com.ayurveda.repository.VendorDocumentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class VendorDocumentService {

    @Autowired
    private VendorDocumentRepository documentRepository;

    @Value("${app.upload.dir:uploads}")
    private String uploadDir;

    // ==================== Upload Document ====================

    public VendorDocument uploadDocument(Vendor vendor, MultipartFile file, DocumentType documentType) throws IOException {
        // Check if document already exists
        Optional<VendorDocument> existing = documentRepository.findByVendorIdAndDocumentType(vendor.getId(), documentType);
        if (existing.isPresent()) {
            // Delete old file and update record
            VendorDocument doc = existing.get();
            deleteFile(doc.getDocumentUrl());
            
            String newUrl = saveFile(file, vendor.getId());
            doc.setDocumentName(file.getOriginalFilename());
            doc.setDocumentUrl(newUrl);
            doc.setFileType(getFileExtension(file.getOriginalFilename()));
            doc.setFileSize(file.getSize());
            doc.setVerificationStatus(VerificationStatus.PENDING);
            doc.setVerifiedAt(null);
            doc.setVerifiedBy(null);
            
            return documentRepository.save(doc);
        }

        // Create new document
        String fileUrl = saveFile(file, vendor.getId());

        VendorDocument document = new VendorDocument();
        document.setVendor(vendor);
        document.setDocumentType(documentType);
        document.setDocumentName(file.getOriginalFilename());
        document.setDocumentUrl(fileUrl);
        document.setFileType(getFileExtension(file.getOriginalFilename()));
        document.setFileSize(file.getSize());
        document.setVerificationStatus(VerificationStatus.PENDING);

        return documentRepository.save(document);
    }

    private String saveFile(MultipartFile file, Long vendorId) throws IOException {
        String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
        Path uploadPath = Paths.get(uploadDir, "vendors", vendorId.toString(), "documents");

        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        Path filePath = uploadPath.resolve(fileName);
        Files.copy(file.getInputStream(), filePath);

        return "/uploads/vendors/" + vendorId + "/documents/" + fileName;
    }

    private void deleteFile(String fileUrl) {
        try {
            if (fileUrl != null && !fileUrl.isEmpty()) {
                String relativePath = fileUrl.replace("/uploads/", "");
                Path filePath = Paths.get(uploadDir, relativePath);
                Files.deleteIfExists(filePath);
            }
        } catch (IOException e) {
            // Log error but don't fail
        }
    }

    private String getFileExtension(String fileName) {
        if (fileName != null && fileName.contains(".")) {
            return fileName.substring(fileName.lastIndexOf(".") + 1).toUpperCase();
        }
        return "UNKNOWN";
    }

    // ==================== Get Documents ====================

    public List<VendorDocument> getVendorDocuments(Long vendorId) {
        return documentRepository.findByVendorId(vendorId);
    }

    public Optional<VendorDocument> getDocument(Long vendorId, DocumentType documentType) {
        return documentRepository.findByVendorIdAndDocumentType(vendorId, documentType);
    }

    public List<VendorDocument> getPendingDocuments(Long vendorId) {
        return documentRepository.findByVendorIdAndVerificationStatus(vendorId, VerificationStatus.PENDING);
    }

    public List<VendorDocument> getAllPendingDocuments() {
        return documentRepository.findByVerificationStatus(VerificationStatus.PENDING);
    }

    // ==================== Delete Document ====================

    public void deleteDocument(Long documentId) {
        VendorDocument document = documentRepository.findById(documentId)
                .orElseThrow(() -> new RuntimeException("Document not found"));
        
        deleteFile(document.getDocumentUrl());
        documentRepository.delete(document);
    }

    public void deleteDocument(Long vendorId, DocumentType documentType) {
        Optional<VendorDocument> document = documentRepository.findByVendorIdAndDocumentType(vendorId, documentType);
        if (document.isPresent()) {
            deleteFile(document.get().getDocumentUrl());
            documentRepository.delete(document.get());
        }
    }

    // ==================== Verification ====================

    public VendorDocument verifyDocument(Long documentId, String adminId) {
        VendorDocument document = documentRepository.findById(documentId)
                .orElseThrow(() -> new RuntimeException("Document not found"));

        document.setVerificationStatus(VerificationStatus.VERIFIED);
        document.setVerifiedAt(LocalDateTime.now());
        document.setVerifiedBy(adminId);

        return documentRepository.save(document);
    }

    public VendorDocument rejectDocument(Long documentId, String reason, String adminId) {
        VendorDocument document = documentRepository.findById(documentId)
                .orElseThrow(() -> new RuntimeException("Document not found"));

        document.setVerificationStatus(VerificationStatus.REJECTED);
        document.setVerificationNotes(reason);
        document.setVerifiedAt(LocalDateTime.now());
        document.setVerifiedBy(adminId);

        return documentRepository.save(document);
    }

    // ==================== Check Document Exists ====================

    public boolean hasDocument(Long vendorId, DocumentType documentType) {
        return documentRepository.existsByVendorIdAndDocumentType(vendorId, documentType);
    }

    public boolean hasAllRequiredDocuments(Long vendorId) {
        // Required documents
        DocumentType[] required = {
            DocumentType.PAN_CARD,
            DocumentType.GST_CERTIFICATE,
            DocumentType.ADDRESS_PROOF,
            DocumentType.ID_PROOF,
            DocumentType.CANCELLED_CHEQUE
        };

        for (DocumentType type : required) {
            if (!hasDocument(vendorId, type)) {
                return false;
            }
        }
        return true;
    }

    public boolean areAllDocumentsVerified(Long vendorId) {
        List<VendorDocument> documents = getVendorDocuments(vendorId);
        if (documents.isEmpty()) {
            return false;
        }

        for (VendorDocument doc : documents) {
            if (doc.getVerificationStatus() != VerificationStatus.VERIFIED) {
                return false;
            }
        }
        return true;
    }
}

