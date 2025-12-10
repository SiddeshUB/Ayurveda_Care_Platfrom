package com.ayurveda.repository;

import com.ayurveda.entity.UserEnquiry;
import com.ayurveda.entity.UserEnquiry.EnquiryStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserEnquiryRepository extends JpaRepository<UserEnquiry, Long> {
    
    List<UserEnquiry> findByUserId(Long userId);
    
    List<UserEnquiry> findByHospitalId(Long hospitalId);
    
    Optional<UserEnquiry> findByEnquiryNumber(String enquiryNumber);
    
    List<UserEnquiry> findByHospitalIdAndStatus(Long hospitalId, EnquiryStatus status);
    
    long countByHospitalIdAndStatus(Long hospitalId, EnquiryStatus status);
}

