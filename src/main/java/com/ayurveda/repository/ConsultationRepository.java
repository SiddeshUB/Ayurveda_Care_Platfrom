package com.ayurveda.repository;

import com.ayurveda.entity.Consultation;
import com.ayurveda.entity.Consultation.ConsultationStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface ConsultationRepository extends JpaRepository<Consultation, Long> {
    
    Optional<Consultation> findByConsultationNumber(String consultationNumber);
    
    List<Consultation> findByDoctorId(Long doctorId);
    
    List<Consultation> findByDoctorIdAndStatus(Long doctorId, ConsultationStatus status);
    
    List<Consultation> findByDoctorIdAndConsultationDate(Long doctorId, LocalDate date);
    
    @Query("SELECT c FROM Consultation c WHERE c.doctor.id = :doctorId AND c.consultationDate = :date AND c.status IN ('PENDING', 'CONFIRMED') ORDER BY c.consultationTime")
    List<Consultation> findTodayAppointments(@Param("doctorId") Long doctorId, @Param("date") LocalDate date);
    
    @Query("SELECT c FROM Consultation c WHERE c.doctor.id = :doctorId AND c.consultationDate >= :startDate ORDER BY c.consultationDate, c.consultationTime")
    List<Consultation> findUpcomingConsultations(@Param("doctorId") Long doctorId, @Param("startDate") LocalDate startDate);
    
    @Query("SELECT COUNT(c) FROM Consultation c WHERE c.doctor.id = :doctorId AND c.consultationDate = :date AND c.status IN ('PENDING', 'CONFIRMED')")
    Long countAppointmentsForDate(@Param("doctorId") Long doctorId, @Param("date") LocalDate date);
    
    List<Consultation> findByHospitalId(Long hospitalId);
    
    List<Consultation> findByUserId(Long userId);
    
    List<Consultation> findByUserIdOrderByConsultationDateDesc(Long userId);
    
    @Query("SELECT c FROM Consultation c LEFT JOIN FETCH c.doctor LEFT JOIN FETCH c.hospital LEFT JOIN FETCH c.user WHERE c.id = :id")
    Optional<Consultation> findByIdWithRelations(@Param("id") Long id);
}

