package com.ayurveda.repository;

import com.ayurveda.entity.ConsultationSlot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.DayOfWeek;
import java.util.List;

@Repository
public interface ConsultationSlotRepository extends JpaRepository<ConsultationSlot, Long> {
    
    List<ConsultationSlot> findByDoctorId(Long doctorId);
    
    List<ConsultationSlot> findByDoctorIdAndHospitalId(Long doctorId, Long hospitalId);
    
    List<ConsultationSlot> findByDoctorIdAndDayOfWeek(Long doctorId, DayOfWeek dayOfWeek);
    
    List<ConsultationSlot> findByDoctorIdAndIsAvailableTrue(Long doctorId);
    
    List<ConsultationSlot> findByDoctorIdAndHospitalIdAndDayOfWeek(Long doctorId, Long hospitalId, DayOfWeek dayOfWeek);
}

