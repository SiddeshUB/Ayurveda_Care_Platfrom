package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.DayOfWeek;
import java.time.LocalTime;

@Entity
@Table(name = "consultation_slots")
public class ConsultationSlot {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doctor_id", nullable = false)
    private Doctor doctor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id")
    private Hospital hospital;

    @Enumerated(EnumType.STRING)
    private DayOfWeek dayOfWeek; // MONDAY, TUESDAY, etc.

    private LocalTime startTime;
    private LocalTime endTime;

    private Integer durationMinutes; // Slot duration (30, 60, 90)

    private Integer maxBookingsPerSlot; // Maximum bookings for this slot

    private Boolean isAvailable;

    private Boolean isRecurring; // Recurring weekly slot

    private String slotType; // MORNING, AFTERNOON, EVENING

    @Column(columnDefinition = "TEXT")
    private String notes;

    public ConsultationSlot() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Doctor getDoctor() { return doctor; }
    public void setDoctor(Doctor doctor) { this.doctor = doctor; }

    public Hospital getHospital() { return hospital; }
    public void setHospital(Hospital hospital) { this.hospital = hospital; }

    public DayOfWeek getDayOfWeek() { return dayOfWeek; }
    public void setDayOfWeek(DayOfWeek dayOfWeek) { this.dayOfWeek = dayOfWeek; }

    public LocalTime getStartTime() { return startTime; }
    public void setStartTime(LocalTime startTime) { this.startTime = startTime; }

    public LocalTime getEndTime() { return endTime; }
    public void setEndTime(LocalTime endTime) { this.endTime = endTime; }

    public Integer getDurationMinutes() { return durationMinutes; }
    public void setDurationMinutes(Integer durationMinutes) { this.durationMinutes = durationMinutes; }

    public Integer getMaxBookingsPerSlot() { return maxBookingsPerSlot; }
    public void setMaxBookingsPerSlot(Integer maxBookingsPerSlot) { this.maxBookingsPerSlot = maxBookingsPerSlot; }

    public Boolean getIsAvailable() { return isAvailable; }
    public void setIsAvailable(Boolean isAvailable) { this.isAvailable = isAvailable; }

    public Boolean getIsRecurring() { return isRecurring; }
    public void setIsRecurring(Boolean isRecurring) { this.isRecurring = isRecurring; }

    public String getSlotType() { return slotType; }
    public void setSlotType(String slotType) { this.slotType = slotType; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}

