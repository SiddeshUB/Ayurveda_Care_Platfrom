package com.ayurveda.repository;

import com.ayurveda.entity.HospitalPhoto;
import com.ayurveda.entity.HospitalPhoto.PhotoCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HospitalPhotoRepository extends JpaRepository<HospitalPhoto, Long> {
    
    List<HospitalPhoto> findByHospitalIdOrderBySortOrderAsc(Long hospitalId);
    
    List<HospitalPhoto> findByHospitalIdAndIsActiveTrueOrderBySortOrderAsc(Long hospitalId);
    
    List<HospitalPhoto> findByHospitalIdAndCategory(Long hospitalId, PhotoCategory category);
    
    @Modifying
    @Query("UPDATE HospitalPhoto p SET p.isCoverPhoto = false WHERE p.hospital.id = :hospitalId")
    void resetCoverPhoto(@Param("hospitalId") Long hospitalId);
}
