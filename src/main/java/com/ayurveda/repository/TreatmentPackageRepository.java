package com.ayurveda.repository;

import com.ayurveda.entity.TreatmentPackage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TreatmentPackageRepository extends JpaRepository<TreatmentPackage, Long> {
    
    List<TreatmentPackage> findByHospitalId(Long hospitalId);
    
    List<TreatmentPackage> findByHospitalIdAndIsActiveTrue(Long hospitalId);
    
    List<TreatmentPackage> findTop3ByHospitalIdAndIsActiveTrueOrderBySortOrderAsc(Long hospitalId);
}
