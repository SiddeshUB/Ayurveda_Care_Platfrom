package com.ayurveda.repository;

import com.ayurveda.entity.SavedCenter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface SavedCenterRepository extends JpaRepository<SavedCenter, Long> {
    
    List<SavedCenter> findByUserId(Long userId);
    
    Optional<SavedCenter> findByUserIdAndHospitalId(Long userId, Long hospitalId);
    
    boolean existsByUserIdAndHospitalId(Long userId, Long hospitalId);
}

