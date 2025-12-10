package com.ayurveda.repository;

import com.ayurveda.entity.Room;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoomRepository extends JpaRepository<Room, Long> {
    
    List<Room> findByHospitalId(Long hospitalId);
    
    List<Room> findByHospitalIdAndIsActive(Long hospitalId, Boolean isActive);
    
    List<Room> findByHospitalIdAndIsActiveAndIsAvailable(Long hospitalId, Boolean isActive, Boolean isAvailable);
}

