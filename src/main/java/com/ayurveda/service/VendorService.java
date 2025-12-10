package com.ayurveda.service;

import com.ayurveda.entity.Vendor;
import com.ayurveda.entity.Vendor.VendorStatus;
import com.ayurveda.entity.VendorWallet;
import com.ayurveda.repository.VendorRepository;
import com.ayurveda.repository.VendorWalletRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class VendorService {

    @Autowired
    private VendorRepository vendorRepository;

    @Autowired
    private VendorWalletRepository vendorWalletRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // ==================== Registration ====================

    public Vendor register(Vendor vendor) {
        // Encode password
        vendor.setPassword(passwordEncoder.encode(vendor.getPassword()));
        vendor.setStatus(VendorStatus.PENDING);
        vendor.setIsActive(false);
        vendor.setIsVerified(false);

        // Set terms agreement timestamp
        if (Boolean.TRUE.equals(vendor.getAgreedToTerms())) {
            vendor.setTermsAgreedAt(LocalDateTime.now());
        }

        Vendor savedVendor = vendorRepository.save(vendor);

        // Create wallet for vendor
        VendorWallet wallet = new VendorWallet(savedVendor);
        vendorWalletRepository.save(wallet);

        return savedVendor;
    }

    // ==================== Authentication ====================

    public Optional<Vendor> authenticate(String email, String password) {
        Optional<Vendor> vendorOpt = vendorRepository.findByEmail(email);
        if (vendorOpt.isPresent()) {
            Vendor vendor = vendorOpt.get();
            if (passwordEncoder.matches(password, vendor.getPassword())) {
                // Update last login
                vendor.setLastLoginAt(LocalDateTime.now());
                vendorRepository.save(vendor);
                return Optional.of(vendor);
            }
        }
        return Optional.empty();
    }

    // ==================== CRUD Operations ====================

    public Vendor save(Vendor vendor) {
        return vendorRepository.save(vendor);
    }

    public Optional<Vendor> findById(Long id) {
        return vendorRepository.findById(id);
    }

    public Optional<Vendor> findByEmail(String email) {
        return vendorRepository.findByEmail(email);
    }

    public List<Vendor> findAll() {
        return vendorRepository.findAll();
    }

    public Page<Vendor> findAll(Pageable pageable) {
        return vendorRepository.findAll(pageable);
    }

    public void delete(Long id) {
        vendorRepository.deleteById(id);
    }

    // ==================== Validation ====================

    public boolean existsByEmail(String email) {
        return vendorRepository.existsByEmail(email);
    }

    public boolean existsByGstNumber(String gstNumber) {
        return vendorRepository.existsByGstNumber(gstNumber);
    }

    public boolean existsByPanNumber(String panNumber) {
        return vendorRepository.existsByPanNumber(panNumber);
    }

    // ==================== Status Management ====================

    public List<Vendor> findByStatus(VendorStatus status) {
        return vendorRepository.findByStatus(status);
    }

    public Page<Vendor> findByStatus(VendorStatus status, Pageable pageable) {
        return vendorRepository.findByStatus(status, pageable);
    }

    public List<Vendor> findPendingApprovals() {
        return vendorRepository.findByStatus(VendorStatus.PENDING);
    }

    public List<Vendor> findActiveVendors() {
        return vendorRepository.findByIsActiveTrue();
    }

    // ==================== Admin Approval ====================

    public Vendor approveVendor(Long vendorId, BigDecimal commissionPercentage, String approvedBy) {
        Vendor vendor = vendorRepository.findById(vendorId)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));

        vendor.setStatus(VendorStatus.APPROVED);
        vendor.setIsActive(true);
        vendor.setIsVerified(true);
        vendor.setCommissionPercentage(commissionPercentage);
        vendor.setApprovedAt(LocalDateTime.now());
        vendor.setApprovedBy(approvedBy);

        return vendorRepository.save(vendor);
    }

    public Vendor rejectVendor(Long vendorId, String reason, String rejectedBy) {
        Vendor vendor = vendorRepository.findById(vendorId)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));

        vendor.setStatus(VendorStatus.REJECTED);
        vendor.setRejectionReason(reason);
        vendor.setIsActive(false);

        return vendorRepository.save(vendor);
    }

    public Vendor suspendVendor(Long vendorId, String reason) {
        Vendor vendor = vendorRepository.findById(vendorId)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));

        vendor.setStatus(VendorStatus.SUSPENDED);
        vendor.setIsActive(false);
        vendor.setRejectionReason(reason);

        return vendorRepository.save(vendor);
    }

    public Vendor blockVendor(Long vendorId, String reason) {
        Vendor vendor = vendorRepository.findById(vendorId)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));

        vendor.setStatus(VendorStatus.BLOCKED);
        vendor.setIsActive(false);
        vendor.setRejectionReason(reason);

        return vendorRepository.save(vendor);
    }

    public Vendor activateVendor(Long vendorId) {
        Vendor vendor = vendorRepository.findById(vendorId)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));

        vendor.setStatus(VendorStatus.APPROVED);
        vendor.setIsActive(true);
        vendor.setRejectionReason(null);

        return vendorRepository.save(vendor);
    }

    // ==================== Search ====================

    public Page<Vendor> searchVendors(String keyword, Pageable pageable) {
        return vendorRepository.searchVendors(keyword, pageable);
    }

    // ==================== Statistics ====================

    public long countByStatus(VendorStatus status) {
        return vendorRepository.countByStatus(status);
    }

    public long countPendingApprovals() {
        return vendorRepository.countPendingApprovals();
    }

    public long countTotalVendors() {
        return vendorRepository.count();
    }

    public List<Vendor> getTopVendorsByRevenue(int limit) {
        return vendorRepository.findTopVendorsByRevenue(PageRequest.of(0, limit));
    }

    public List<Vendor> getTopVendorsByOrders(int limit) {
        return vendorRepository.findTopVendorsByOrders(PageRequest.of(0, limit));
    }

    // ==================== Update Stats ====================

    public void updateVendorStats(Long vendorId) {
        Vendor vendor = vendorRepository.findById(vendorId)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));

        // This would typically be called after order completion
        // Stats are updated incrementally in other services
        vendorRepository.save(vendor);
    }

    public void incrementProductCount(Long vendorId) {
        Vendor vendor = vendorRepository.findById(vendorId).orElse(null);
        if (vendor != null) {
            vendor.setTotalProducts(vendor.getTotalProducts() + 1);
            vendorRepository.save(vendor);
        }
    }

    public void decrementProductCount(Long vendorId) {
        Vendor vendor = vendorRepository.findById(vendorId).orElse(null);
        if (vendor != null && vendor.getTotalProducts() > 0) {
            vendor.setTotalProducts(vendor.getTotalProducts() - 1);
            vendorRepository.save(vendor);
        }
    }

    public void incrementOrderCount(Long vendorId) {
        Vendor vendor = vendorRepository.findById(vendorId).orElse(null);
        if (vendor != null) {
            vendor.setTotalOrders(vendor.getTotalOrders() + 1);
            vendorRepository.save(vendor);
        }
    }

    public void addRevenue(Long vendorId, BigDecimal amount) {
        Vendor vendor = vendorRepository.findById(vendorId).orElse(null);
        if (vendor != null) {
            vendor.setTotalRevenue(vendor.getTotalRevenue().add(amount));
            vendorRepository.save(vendor);
        }
    }

    // ==================== Password Management ====================

    public boolean changePassword(Long vendorId, String currentPassword, String newPassword) {
        Vendor vendor = vendorRepository.findById(vendorId).orElse(null);
        if (vendor != null && passwordEncoder.matches(currentPassword, vendor.getPassword())) {
            vendor.setPassword(passwordEncoder.encode(newPassword));
            vendorRepository.save(vendor);
            return true;
        }
        return false;
    }

    public void resetPassword(Long vendorId, String newPassword) {
        Vendor vendor = vendorRepository.findById(vendorId)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));
        vendor.setPassword(passwordEncoder.encode(newPassword));
        vendorRepository.save(vendor);
    }

    // Password Reset Token Methods
    @Transactional
    public void generatePasswordResetToken(String email, String phone) {
        Vendor vendor = vendorRepository.findByEmail(email.toLowerCase().trim())
                .orElseThrow(() -> new RuntimeException("Vendor not found with this email"));

        if (vendor.getMobileNumber() == null || !vendor.getMobileNumber().equals(phone)) {
            throw new RuntimeException("Phone number does not match the registered phone number");
        }

        String token = java.util.UUID.randomUUID().toString();
        vendor.setPasswordResetToken(token);
        vendor.setPasswordResetTokenExpiry(java.time.LocalDateTime.now().plusHours(1));
        vendorRepository.save(vendor);
    }

    public Optional<Vendor> findByPasswordResetToken(String token) {
        return vendorRepository.findByPasswordResetToken(token)
                .filter(vendor -> vendor.getPasswordResetTokenExpiry() != null &&
                        vendor.getPasswordResetTokenExpiry().isAfter(java.time.LocalDateTime.now()));
    }

    @Transactional
    public void resetPasswordByToken(String token, String newPassword) {
        Vendor vendor = findByPasswordResetToken(token)
                .orElseThrow(() -> new RuntimeException("Invalid or expired reset token"));

        vendor.setPassword(passwordEncoder.encode(newPassword));
        vendor.setPasswordResetToken(null);
        vendor.setPasswordResetTokenExpiry(null);
        vendorRepository.save(vendor);
    }
}

