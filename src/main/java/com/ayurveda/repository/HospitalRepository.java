package com.ayurveda.repository;

import com.ayurveda.entity.Hospital;
import com.ayurveda.entity.Hospital.HospitalStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface HospitalRepository extends JpaRepository<Hospital, Long> {
    
    Optional<Hospital> findByEmail(String email);
    
    List<Hospital> findByCity(String city);
    
    List<Hospital> findByState(String state);
    
    Page<Hospital> findByStatusAndIsActive(HospitalStatus status, Boolean isActive, Pageable pageable);
    
    @Query("SELECT h FROM Hospital h WHERE h.status = 'APPROVED' AND h.isActive = true AND h.isFeatured = true ORDER BY h.averageRating DESC")
    List<Hospital> findFeaturedHospitals();
    
    @Query("SELECT h FROM Hospital h WHERE h.status = 'APPROVED' AND h.isActive = true AND " +
           "(LOWER(h.centerName) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(h.city) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(h.state) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(h.therapiesOffered) LIKE LOWER(CONCAT('%', :query, '%')))")
    Page<Hospital> searchHospitals(@Param("query") String query, Pageable pageable);
    
    @Query("SELECT h FROM Hospital h WHERE h.status = 'APPROVED' AND h.isActive = true ORDER BY h.averageRating DESC")
    List<Hospital> findTopRatedHospitals(Pageable pageable);
    
    // Get all approved hospitals (all registered hospitals that have been approved)
    Page<Hospital> findByStatus(HospitalStatus status, Pageable pageable);
    
    // Search all approved hospitals (not just active ones)
    @Query("SELECT h FROM Hospital h WHERE h.status = 'APPROVED' AND " +
           "(LOWER(h.centerName) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(h.city) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(h.state) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(h.therapiesOffered) LIKE LOWER(CONCAT('%', :query, '%')))")
    Page<Hospital> searchAllApprovedHospitals(@Param("query") String query, Pageable pageable);
}
