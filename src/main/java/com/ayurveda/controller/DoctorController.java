package com.ayurveda.controller;

import com.ayurveda.entity.*;
import com.ayurveda.entity.TreatmentRecommendation.TreatmentType;
import com.ayurveda.service.BookingService;
import com.ayurveda.service.ConsultationService;
import com.ayurveda.service.DoctorService;
import com.ayurveda.service.DoctorHospitalAssociationService;
import com.ayurveda.service.HospitalService;
import com.ayurveda.service.PackageService;
import com.ayurveda.service.PrescriptionService;
import com.ayurveda.service.TreatmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.http.ResponseEntity;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/doctor")
public class DoctorController {

    private final DoctorService doctorService;
    private final DoctorHospitalAssociationService associationService;
    private final HospitalService hospitalService;
    private final ConsultationService consultationService;
    private final PrescriptionService prescriptionService;
    private final TreatmentService treatmentService;
    private final PackageService packageService;
    private final BookingService bookingService;

    @Autowired
    public DoctorController(DoctorService doctorService,
                           DoctorHospitalAssociationService associationService,
                           HospitalService hospitalService,
                           ConsultationService consultationService,
                           PrescriptionService prescriptionService,
                           TreatmentService treatmentService,
                           PackageService packageService,
                           BookingService bookingService) {
        this.doctorService = doctorService;
        this.associationService = associationService;
        this.hospitalService = hospitalService;
        this.consultationService = consultationService;
        this.prescriptionService = prescriptionService;
        this.treatmentService = treatmentService;
        this.packageService = packageService;
        this.bookingService = bookingService;
    }

    // Login Page
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(@RequestParam(required = false) String error,
                           @RequestParam(required = false) String logout,
                           Model model) {
        if (error != null) {
            String errorMessage = "Invalid email or password. ";
            // Add helpful troubleshooting tips
            errorMessage += "Please check: 1) Email is correct (case-insensitive), 2) Password matches what was set during registration, 3) Account is active. ";
            errorMessage += "If you were registered by a hospital, contact them to verify your account status.";
            model.addAttribute("error", errorMessage);
        }
        if (logout != null) {
            model.addAttribute("message", "You have been logged out successfully");
        }
        return "doctor/login";
    }

    // Register Page - DISABLED: Doctors must be registered through hospital dashboard
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerPage(Model model) {
        model.addAttribute("error", "Doctor registration is only available through hospital dashboards. Please contact your hospital administrator to register.");
        return "doctor/login";
    }

    // Register Handler - DISABLED: Doctors must be registered through hospital dashboard
    @PostMapping("/register")
    public String registerDoctor(@ModelAttribute Doctor doctor,
                                @RequestParam String confirmPassword,
                                RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("error", "Doctor registration is only available through hospital dashboards. Please contact your hospital administrator to register.");
        return "redirect:/doctor/login";
    }

    // Dashboard
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public String dashboard(Model model) {
        Doctor doctor = getCurrentDoctor();
        if (doctor != null) {
            doctorService.updateLastLogin(doctor.getId());
            
            // Get approved hospital associations
            List<DoctorHospitalAssociation> associations = 
                    associationService.getApprovedAssociationsByDoctor(doctor.getId());
            model.addAttribute("associations", associations);
            
            // Get today's appointments
            List<Consultation> todayAppointments = consultationService.getTodayAppointments(doctor.getId());
            model.addAttribute("todayAppointments", todayAppointments);
            
            // Get upcoming consultations
            List<Consultation> upcomingConsultations = consultationService.getUpcomingConsultations(doctor.getId());
            model.addAttribute("upcomingConsultations", upcomingConsultations);
            
            // Get pending consultations
            List<Consultation> pendingConsultations = consultationService.getConsultationsByStatus(
                    doctor.getId(), Consultation.ConsultationStatus.PENDING);
            model.addAttribute("pendingConsultations", pendingConsultations);
            
            // Get packages associated with this doctor
            List<TreatmentPackage> packages = doctor.getPackages();
            model.addAttribute("packages", packages != null ? packages : new ArrayList<>());
            
            // Get bookings for packages this doctor is associated with
            List<Booking> packageBookings = new ArrayList<>();
            if (packages != null && !packages.isEmpty()) {
                for (TreatmentPackage pkg : packages) {
                    List<Booking> bookings = bookingService.getBookingsByPackage(pkg.getId());
                    packageBookings.addAll(bookings);
                }
            }
            model.addAttribute("packageBookings", packageBookings);
        }
        
        model.addAttribute("doctor", doctor);
        return "doctor/dashboard/index";
    }

    // ========== APPOINTMENTS MANAGEMENT ==========
    @RequestMapping(value = "/appointments", method = RequestMethod.GET)
    public String appointments(@RequestParam(required = false) String status, Model model) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        List<Consultation> consultations;
        if (status != null && !status.isEmpty()) {
            try {
                Consultation.ConsultationStatus consultationStatus = 
                        Consultation.ConsultationStatus.valueOf(status.toUpperCase());
                consultations = consultationService.getConsultationsByStatus(doctor.getId(), consultationStatus);
            } catch (IllegalArgumentException e) {
                consultations = consultationService.getConsultationsByDoctor(doctor.getId());
            }
        } else {
            consultations = consultationService.getConsultationsByDoctor(doctor.getId());
        }
        
        model.addAttribute("doctor", doctor);
        model.addAttribute("consultations", consultations);
        model.addAttribute("currentStatus", status);
        return "doctor/dashboard/appointments";
    }

    @RequestMapping(value = "/appointments/{id}", method = RequestMethod.GET)
    public String appointmentDetails(@PathVariable Long id, Model model) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        Consultation consultation = consultationService.findById(id)
                .orElseThrow(() -> new RuntimeException("Consultation not found"));
        
        // Security check
        if (!consultation.getDoctor().getId().equals(doctor.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        model.addAttribute("doctor", doctor);
        model.addAttribute("consultation", consultation);
        return "doctor/dashboard/appointment-details";
    }

    @PostMapping("/appointments/{id}/confirm")
    public String confirmAppointment(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        try {
            consultationService.confirmConsultation(id);
            redirectAttributes.addFlashAttribute("success", "Appointment confirmed");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        
        return "redirect:/doctor/appointments/" + id;
    }

    @PostMapping("/appointments/{id}/complete")
    public String completeAppointment(@PathVariable Long id,
                                     @RequestParam(required = false) String doctorNotes,
                                     @RequestParam(required = false) String prescriptionNotes,
                                     @RequestParam(required = false) Boolean requiresFollowUp,
                                     @RequestParam(required = false) String followUpDate,
                                     RedirectAttributes redirectAttributes) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        try {
            java.time.LocalDate parsedFollowUpDate = null;
            if (requiresFollowUp != null && requiresFollowUp && followUpDate != null && !followUpDate.isEmpty()) {
                parsedFollowUpDate = java.time.LocalDate.parse(followUpDate);
            }
            
            consultationService.completeConsultation(id, doctorNotes, prescriptionNotes, 
                    requiresFollowUp, parsedFollowUpDate);
            redirectAttributes.addFlashAttribute("success", "Consultation completed");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        
        return "redirect:/doctor/appointments/" + id;
    }

    @PostMapping("/appointments/{id}/cancel")
    public String cancelAppointment(@PathVariable Long id,
                                   @RequestParam String reason,
                                   RedirectAttributes redirectAttributes) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        try {
            consultationService.cancelConsultation(id, reason);
            redirectAttributes.addFlashAttribute("success", "Appointment cancelled");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        
        return "redirect:/doctor/appointments";
    }

    @PostMapping("/appointments/{id}/reject")
    public String rejectAppointment(@PathVariable Long id,
                                   @RequestParam String reason,
                                   RedirectAttributes redirectAttributes) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        try {
            Consultation consultation = consultationService.findById(id)
                    .orElseThrow(() -> new RuntimeException("Consultation not found"));
            
            // Security check
            if (!consultation.getDoctor().getId().equals(doctor.getId())) {
                throw new RuntimeException("Unauthorized");
            }
            
            // Reject is essentially cancelling with a reason
            consultationService.cancelConsultation(id, "REJECTED: " + reason);
            
            redirectAttributes.addFlashAttribute("success", "Appointment rejected");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        
        return "redirect:/doctor/appointments/" + id;
    }

    @PostMapping("/appointments/{id}/reschedule")
    public String rescheduleAppointment(@PathVariable Long id,
                                       @RequestParam String newDate,
                                       @RequestParam String newTime,
                                       @RequestParam(required = false) String reason,
                                       RedirectAttributes redirectAttributes) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        try {
            Consultation consultation = consultationService.findById(id)
                    .orElseThrow(() -> new RuntimeException("Consultation not found"));
            
            // Security check
            if (!consultation.getDoctor().getId().equals(doctor.getId())) {
                throw new RuntimeException("Unauthorized");
            }
            
            java.time.LocalDate parsedDate = java.time.LocalDate.parse(newDate);
            java.time.LocalTime parsedTime = java.time.LocalTime.parse(newTime);
            
            consultationService.rescheduleConsultation(id, parsedDate, parsedTime);
            
            if (reason != null && !reason.trim().isEmpty()) {
                Consultation updated = consultationService.findById(id).orElse(null);
                if (updated != null && updated.getDoctorNotes() == null) {
                    updated.setDoctorNotes("Rescheduled: " + reason);
                    // Note: We'd need to save this, but rescheduleConsultation already saves
                }
            }
            
            redirectAttributes.addFlashAttribute("success", "Appointment rescheduled successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        
        return "redirect:/doctor/appointments/" + id;
    }

    // ========== AVAILABILITY MANAGEMENT ==========
    @RequestMapping(value = "/availability", method = RequestMethod.GET)
    public String availability(Model model) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        // Reload doctor with hospital relationship to ensure it's loaded
        doctor = doctorService.findById(doctor.getId())
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        List<ConsultationSlot> slots = consultationService.getSlotsByDoctor(doctor.getId());
        
        // Get approved associations
        List<DoctorHospitalAssociation> associations = 
                associationService.getApprovedAssociationsByDoctor(doctor.getId());
        
        model.addAttribute("doctor", doctor);
        model.addAttribute("slots", slots);
        model.addAttribute("associations", associations);
        return "doctor/dashboard/availability";
    }

    @PostMapping("/availability/slots/add")
    public String addSlot(@RequestParam Long hospitalId,
                         @RequestParam String dayOfWeek,
                         @RequestParam String startTime,
                         @RequestParam String endTime,
                         @RequestParam Integer durationMinutes,
                         @RequestParam(required = false) Integer maxBookingsPerSlot,
                         @RequestParam(required = false) String slotType,
                         RedirectAttributes redirectAttributes) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        try {
            ConsultationSlot slot = new ConsultationSlot();
            slot.setDayOfWeek(java.time.DayOfWeek.valueOf(dayOfWeek.toUpperCase()));
            slot.setStartTime(java.time.LocalTime.parse(startTime));
            slot.setEndTime(java.time.LocalTime.parse(endTime));
            slot.setDurationMinutes(durationMinutes);
            slot.setMaxBookingsPerSlot(maxBookingsPerSlot != null ? maxBookingsPerSlot : 1);
            slot.setSlotType(slotType);
            slot.setIsRecurring(true);
            slot.setIsAvailable(true);
            
            consultationService.createSlot(doctor.getId(), hospitalId, slot);
            redirectAttributes.addFlashAttribute("success", "Time slot added successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        
        return "redirect:/doctor/availability";
    }

    @PostMapping("/availability/slots/{id}/delete")
    public String deleteSlot(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        try {
            consultationService.deleteSlot(id);
            redirectAttributes.addFlashAttribute("success", "Time slot deleted");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        
        return "redirect:/doctor/availability";
    }

    // ========== PROFILE MANAGEMENT ==========
    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String profile(Model model) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        model.addAttribute("doctor", doctor);
        return "doctor/dashboard/profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@ModelAttribute Doctor doctor,
                               @RequestParam(required = false) org.springframework.web.multipart.MultipartFile photoFile,
                               RedirectAttributes redirectAttributes) {
        Doctor currentDoctor = getCurrentDoctor();
        if (currentDoctor == null) {
            return "redirect:/doctor/login";
        }
        
        try {
            doctorService.updateDoctor(currentDoctor.getId(), doctor);
            
            // Upload photo if provided
            if (photoFile != null && !photoFile.isEmpty()) {
                doctorService.uploadDoctorPhoto(currentDoctor.getId(), photoFile);
            }
            
            redirectAttributes.addFlashAttribute("success", "Profile updated successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        
        return "redirect:/doctor/profile";
    }

    // ========== PRESCRIPTION MANAGEMENT ==========
    @RequestMapping(value = "/prescriptions", method = RequestMethod.GET)
    public String prescriptions(Model model) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        List<Prescription> prescriptions = prescriptionService.getPrescriptionsByDoctor(doctor.getId());
        
        model.addAttribute("doctor", doctor);
        model.addAttribute("prescriptions", prescriptions);
        return "doctor/dashboard/prescriptions";
    }

    @RequestMapping(value = "/prescriptions/create/{consultationId}", method = RequestMethod.GET)
    public String createPrescriptionForm(@PathVariable Long consultationId, Model model) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        Consultation consultation = consultationService.findById(consultationId)
                .orElseThrow(() -> new RuntimeException("Consultation not found"));
        
        // Security check
        if (!consultation.getDoctor().getId().equals(doctor.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        // Check if prescription already exists
        Optional<Prescription> existingPrescription = prescriptionService.findByConsultationId(consultationId);
        
        List<Medicine> medicines = prescriptionService.getAllActiveMedicines();
        
        model.addAttribute("doctor", doctor);
        model.addAttribute("consultation", consultation);
        model.addAttribute("prescription", existingPrescription.orElse(new Prescription()));
        model.addAttribute("medicines", medicines);
        model.addAttribute("isEdit", existingPrescription.isPresent());
        
        return "doctor/dashboard/prescription-form";
    }

    @PostMapping("/prescriptions/create/{consultationId}")
    public String createPrescription(@PathVariable Long consultationId,
                                    @ModelAttribute Prescription prescription,
                                    @RequestParam(required = false) String[] medicineNames,
                                    @RequestParam(required = false) Long[] medicineIds,
                                    @RequestParam(required = false) String[] dosages,
                                    @RequestParam(required = false) String[] frequencies,
                                    @RequestParam(required = false) String[] timings,
                                    @RequestParam(required = false) Integer[] durationDays,
                                    @RequestParam(required = false) String[] medicineInstructions,
                                    RedirectAttributes redirectAttributes) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        try {
            // Build medicine list
            List<PrescriptionMedicine> medicines = new ArrayList<>();
            if (medicineNames != null && medicineNames.length > 0) {
                for (int i = 0; i < medicineNames.length; i++) {
                    if (medicineNames[i] != null && !medicineNames[i].trim().isEmpty()) {
                        final int index = i; // Make final copy for lambda
                        PrescriptionMedicine pm = new PrescriptionMedicine();
                        pm.setMedicineName(medicineNames[i]);
                        
                        if (medicineIds != null && i < medicineIds.length && medicineIds[i] != null) {
                            final Long medicineId = medicineIds[i]; // Make final copy for lambda
                            Medicine medicine = prescriptionService.searchMedicines("").stream()
                                    .filter(m -> m.getId().equals(medicineId))
                                    .findFirst()
                                    .orElse(null);
                            if (medicine != null) {
                                pm.setMedicine(medicine);
                                pm.setMedicineName(medicine.getName());
                            }
                        }
                        
                        if (dosages != null && i < dosages.length) pm.setDosage(dosages[i]);
                        if (frequencies != null && i < frequencies.length) pm.setFrequency(frequencies[i]);
                        if (timings != null && i < timings.length) pm.setTiming(timings[i]);
                        if (durationDays != null && i < durationDays.length) pm.setDurationDays(durationDays[i]);
                        if (medicineInstructions != null && i < medicineInstructions.length) pm.setInstructions(medicineInstructions[i]);
                        
                        medicines.add(pm);
                    }
                }
            }
            
            // Check if prescription exists
            Optional<Prescription> existing = prescriptionService.findByConsultationId(consultationId);
            if (existing.isPresent()) {
                prescriptionService.updatePrescription(existing.get().getId(), prescription, medicines);
                redirectAttributes.addFlashAttribute("success", "Prescription updated successfully");
            } else {
                prescriptionService.createPrescription(consultationId, prescription, medicines);
                redirectAttributes.addFlashAttribute("success", "Prescription created successfully");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
            return "redirect:/doctor/prescriptions/create/" + consultationId;
        }
        
        return "redirect:/doctor/prescriptions";
    }

    @RequestMapping(value = "/prescriptions/{id}", method = RequestMethod.GET)
    public String viewPrescription(@PathVariable Long id, Model model) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        Prescription prescription = prescriptionService.findById(id)
                .orElseThrow(() -> new RuntimeException("Prescription not found"));
        
        // Security check
        if (!prescription.getDoctor().getId().equals(doctor.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        model.addAttribute("doctor", doctor);
        model.addAttribute("prescription", prescription);
        return "doctor/dashboard/prescription-view";
    }

    // ========== TREATMENT RECOMMENDATIONS ==========
    @RequestMapping(value = "/treatments", method = RequestMethod.GET)
    public String treatments(Model model) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        List<TreatmentRecommendation> treatments = treatmentService.getTreatmentsByDoctor(doctor.getId());
        
        model.addAttribute("doctor", doctor);
        model.addAttribute("treatments", treatments);
        return "doctor/dashboard/treatments";
    }

    @RequestMapping(value = "/treatments/create/{consultationId}", method = RequestMethod.GET)
    public String createTreatmentForm(@PathVariable Long consultationId, Model model) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        Consultation consultation = consultationService.findById(consultationId)
                .orElseThrow(() -> new RuntimeException("Consultation not found"));
        
        // Security check
        if (!consultation.getDoctor().getId().equals(doctor.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        model.addAttribute("doctor", doctor);
        model.addAttribute("consultation", consultation);
        model.addAttribute("treatment", new TreatmentRecommendation());
        model.addAttribute("treatmentTypes", treatmentService.getAllTreatmentTypes());
        
        return "doctor/dashboard/treatment-form";
    }

    @PostMapping("/treatments/create/{consultationId}")
    public String createTreatment(@PathVariable Long consultationId,
                                 @ModelAttribute TreatmentRecommendation treatment,
                                 RedirectAttributes redirectAttributes) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        try {
            treatmentService.createTreatmentRecommendation(consultationId, treatment);
            redirectAttributes.addFlashAttribute("success", "Treatment recommendation created successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
            return "redirect:/doctor/treatments/create/" + consultationId;
        }
        
        return "redirect:/doctor/treatments";
    }

    @RequestMapping(value = "/treatments/{id}", method = RequestMethod.GET)
    public String viewTreatment(@PathVariable Long id, Model model) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        TreatmentRecommendation treatment = treatmentService.findById(id)
                .orElseThrow(() -> new RuntimeException("Treatment not found"));
        
        // Security check
        if (!treatment.getDoctor().getId().equals(doctor.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        model.addAttribute("doctor", doctor);
        model.addAttribute("treatment", treatment);
        return "doctor/dashboard/treatment-view";
    }

    // Search medicines (AJAX endpoint)
    @RequestMapping(value = "/medicines/search", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<List<Medicine>> searchMedicines(@RequestParam(required = false) String query) {
        return ResponseEntity.ok(prescriptionService.searchMedicines(query));
    }

    // Search Hospitals
    @RequestMapping(value = "/hospitals/search", method = RequestMethod.GET)
    public String searchHospitals(@RequestParam(required = false) String query, Model model) {
        Doctor doctor = getCurrentDoctor();
        List<Hospital> hospitals;
        
        if (query != null && !query.trim().isEmpty()) {
            hospitals = hospitalService.getAllHospitals().stream()
                    .filter(h -> h.getStatus() == Hospital.HospitalStatus.APPROVED && 
                               h.getIsActive() &&
                               (h.getCenterName().toLowerCase().contains(query.toLowerCase()) ||
                                h.getCity().toLowerCase().contains(query.toLowerCase())))
                    .limit(20)
                    .toList();
        } else {
            hospitals = hospitalService.getAllHospitals().stream()
                    .filter(h -> h.getStatus() == Hospital.HospitalStatus.APPROVED && h.getIsActive())
                    .limit(20)
                    .toList();
        }
        
        model.addAttribute("doctor", doctor);
        model.addAttribute("hospitals", hospitals);
        model.addAttribute("query", query);
        return "doctor/hospitals/search";
    }

    // Request Hospital Association
    @RequestMapping(value = "/hospitals/{hospitalId}/request", method = RequestMethod.GET)
    public String requestAssociationForm(@PathVariable Long hospitalId, Model model) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        Hospital hospital = hospitalService.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        // Check if already associated
        boolean alreadyAssociated = associationService.associationExists(doctor.getId(), hospitalId);
        
        model.addAttribute("doctor", doctor);
        model.addAttribute("hospital", hospital);
        model.addAttribute("alreadyAssociated", alreadyAssociated);
        return "doctor/hospitals/request-association";
    }

    @PostMapping("/hospitals/{hospitalId}/request")
    public String requestAssociation(@PathVariable Long hospitalId,
                                    @RequestParam(required = false) String requestMessage,
                                    RedirectAttributes redirectAttributes) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        try {
            associationService.requestAssociation(doctor.getId(), hospitalId, requestMessage);
            redirectAttributes.addFlashAttribute("success", 
                    "Association request sent successfully! The hospital will review your request.");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        
        return "redirect:/doctor/hospitals/associations";
    }

    // View Hospital Associations
    @RequestMapping(value = "/hospitals/associations", method = RequestMethod.GET)
    public String viewAssociations(Model model) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        List<DoctorHospitalAssociation> allAssociations = 
                associationService.getAssociationsByDoctor(doctor.getId());
        
        List<DoctorHospitalAssociation> approved = allAssociations.stream()
                .filter(a -> a.getStatus() == DoctorHospitalAssociation.AssociationStatus.APPROVED)
                .toList();
        
        List<DoctorHospitalAssociation> pending = allAssociations.stream()
                .filter(a -> a.getStatus() == DoctorHospitalAssociation.AssociationStatus.PENDING)
                .toList();
        
        List<DoctorHospitalAssociation> rejected = allAssociations.stream()
                .filter(a -> a.getStatus() == DoctorHospitalAssociation.AssociationStatus.REJECTED)
                .toList();
        
        model.addAttribute("doctor", doctor);
        model.addAttribute("approvedAssociations", approved);
        model.addAttribute("pendingAssociations", pending);
        model.addAttribute("rejectedAssociations", rejected);
        return "doctor/hospitals/associations";
    }

    // Remove Association
    @PostMapping("/hospitals/associations/{id}/remove")
    public String removeAssociation(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        Doctor doctor = getCurrentDoctor();
        if (doctor == null) {
            return "redirect:/doctor/login";
        }
        
        try {
            associationService.removeAssociation(id);
            redirectAttributes.addFlashAttribute("success", "Association removed successfully");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        
        return "redirect:/doctor/hospitals/associations";
    }

    // Helper method to get current doctor
    private Doctor getCurrentDoctor() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            String email = auth.getName();
            return doctorService.findByEmail(email).orElse(null);
        }
        return null;
    }
}

