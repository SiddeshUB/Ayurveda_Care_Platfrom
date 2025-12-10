package com.ayurveda.controller;

import com.ayurveda.entity.Hospital;
import com.ayurveda.entity.Hospital.CenterType;
import com.ayurveda.entity.HospitalDocument.DocumentType;
import com.ayurveda.service.DocumentService;
import com.ayurveda.service.HospitalService;
import com.ayurveda.service.PhotoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@RequestMapping("/hospital")
public class HospitalRegistrationController {

    private final HospitalService hospitalService;
    private final DocumentService documentService;
    private final PhotoService photoService;

    @Autowired
    public HospitalRegistrationController(HospitalService hospitalService,
                                         DocumentService documentService,
                                         PhotoService photoService) {
        this.hospitalService = hospitalService;
        this.documentService = documentService;
        this.photoService = photoService;
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(@RequestParam(value = "error", required = false) String error,
                            @RequestParam(value = "logout", required = false) String logout,
                            Model model) {
        if (error != null) {
            model.addAttribute("error", "Invalid email or password");
        }
        if (logout != null) {
            model.addAttribute("message", "You have been logged out successfully");
        }
        return "hospital/login";
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerPage(Model model, HttpSession session) {
        // Initialize registration data in session if not present
        if (session.getAttribute("registrationData") == null) {
            session.setAttribute("registrationData", new Hospital());
        }
        model.addAttribute("centerTypes", CenterType.values());
        model.addAttribute("currentStep", session.getAttribute("currentStep") != null ? 
                session.getAttribute("currentStep") : 1);
        return "hospital/register";
    }

    // Step 1: Basic Account Creation
    @PostMapping("/register/step1")
    public String registerStep1(@RequestParam String email,
                                @RequestParam String password,
                                @RequestParam String contactPersonName,
                                @RequestParam String contactPersonPhone,
                                HttpSession session, RedirectAttributes redirectAttributes) {
        
        // Check if email already exists
        if (hospitalService.findByEmail(email).isPresent()) {
            redirectAttributes.addFlashAttribute("error", "Email already registered");
            return "redirect:/hospital/register";
        }

        Hospital hospital = (Hospital) session.getAttribute("registrationData");
        if (hospital == null) {
            hospital = new Hospital();
        }
        
        hospital.setEmail(email);
        hospital.setPassword(password);
        hospital.setContactPersonName(contactPersonName);
        hospital.setContactPersonPhone(contactPersonPhone);
        
        session.setAttribute("registrationData", hospital);
        session.setAttribute("currentStep", 2);
        
        return "redirect:/hospital/register";
    }

    // Step 2: Hospital/Center Basic Information
    @PostMapping("/register/step2")
    public String registerStep2(@RequestParam String centerName,
                                @RequestParam String centerType,
                                @RequestParam(required = false) Integer yearEstablished,
                                @RequestParam(required = false) String description,
                                HttpSession session) {
        
        Hospital hospital = (Hospital) session.getAttribute("registrationData");
        
        hospital.setCenterName(centerName);
        hospital.setCenterType(CenterType.valueOf(centerType));
        hospital.setYearEstablished(yearEstablished);
        hospital.setDescription(description);
        
        session.setAttribute("registrationData", hospital);
        session.setAttribute("currentStep", 3);
        
        return "redirect:/hospital/register";
    }

    // Step 3: Location & Contact Details
    @PostMapping("/register/step3")
    public String registerStep3(@RequestParam String streetAddress,
                                @RequestParam String city,
                                @RequestParam String state,
                                @RequestParam String pinCode,
                                @RequestParam(defaultValue = "India") String country,
                                @RequestParam(required = false) String googleMapsUrl,
                                @RequestParam(required = false) String receptionPhone,
                                @RequestParam(required = false) String emergencyPhone,
                                @RequestParam(required = false) String bookingPhone,
                                @RequestParam(required = false) String publicEmail,
                                @RequestParam(required = false) String website,
                                @RequestParam(required = false) String instagramUrl,
                                @RequestParam(required = false) String facebookUrl,
                                @RequestParam(required = false) String youtubeUrl,
                                HttpSession session) {
        
        Hospital hospital = (Hospital) session.getAttribute("registrationData");
        
        hospital.setStreetAddress(streetAddress);
        hospital.setCity(city);
        hospital.setState(state);
        hospital.setPinCode(pinCode);
        hospital.setCountry(country);
        hospital.setGoogleMapsUrl(googleMapsUrl);
        hospital.setReceptionPhone(receptionPhone);
        hospital.setEmergencyPhone(emergencyPhone);
        hospital.setBookingPhone(bookingPhone);
        hospital.setPublicEmail(publicEmail);
        hospital.setWebsite(website);
        hospital.setInstagramUrl(instagramUrl);
        hospital.setFacebookUrl(facebookUrl);
        hospital.setYoutubeUrl(youtubeUrl);
        
        session.setAttribute("registrationData", hospital);
        session.setAttribute("currentStep", 4);
        
        return "redirect:/hospital/register";
    }

    // Step 4: Medical Credentials
    @PostMapping("/register/step4")
    public String registerStep4(@RequestParam(required = false) Boolean ayushCertified,
                                @RequestParam(required = false) Boolean nabhCertified,
                                @RequestParam(required = false) Boolean isoCertified,
                                @RequestParam(required = false) Boolean stateGovtApproved,
                                @RequestParam(required = false) String medicalLicenseNumber,
                                @RequestParam(required = false) Integer doctorsCount,
                                @RequestParam(required = false) Integer therapistsCount,
                                @RequestParam(required = false) Integer bedsCapacity,
                                HttpSession session) {
        
        Hospital hospital = (Hospital) session.getAttribute("registrationData");
        
        hospital.setAyushCertified(ayushCertified != null && ayushCertified);
        hospital.setNabhCertified(nabhCertified != null && nabhCertified);
        hospital.setIsoCertified(isoCertified != null && isoCertified);
        hospital.setStateGovtApproved(stateGovtApproved != null && stateGovtApproved);
        hospital.setMedicalLicenseNumber(medicalLicenseNumber);
        hospital.setDoctorsCount(doctorsCount);
        hospital.setTherapistsCount(therapistsCount);
        hospital.setBedsCapacity(bedsCapacity);
        
        session.setAttribute("registrationData", hospital);
        session.setAttribute("currentStep", 5);
        
        return "redirect:/hospital/register";
    }

    // Step 5: Document Uploads - Just save the hospital first, then handle uploads
    @PostMapping("/register/step5")
    public String registerStep5(HttpSession session, RedirectAttributes redirectAttributes) {
        
        Hospital hospital = (Hospital) session.getAttribute("registrationData");
        
        // Register the hospital
        try {
            Hospital savedHospital = hospitalService.registerHospital(hospital);
            session.setAttribute("registeredHospitalId", savedHospital.getId());
            session.setAttribute("currentStep", 6);
            return "redirect:/hospital/register";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/hospital/register";
        }
    }

    // Handle document uploads after registration
    @PostMapping("/register/upload-documents")
    public String uploadDocuments(@RequestParam(required = false) MultipartFile registrationCertificate,
                                  @RequestParam(required = false) MultipartFile medicalLicense,
                                  @RequestParam(required = false) MultipartFile ayushCertificate,
                                  @RequestParam(required = false) MultipartFile nabhCertificate,
                                  @RequestParam(required = false) MultipartFile ownerIdProof,
                                  HttpSession session, RedirectAttributes redirectAttributes) {
        
        Long hospitalId = (Long) session.getAttribute("registeredHospitalId");
        if (hospitalId == null) {
            redirectAttributes.addFlashAttribute("error", "Please complete registration first");
            return "redirect:/hospital/register";
        }
        
        try {
            if (registrationCertificate != null && !registrationCertificate.isEmpty()) {
                documentService.uploadDocument(hospitalId, registrationCertificate, 
                        DocumentType.REGISTRATION_CERTIFICATE, "Registration Certificate");
            }
            if (medicalLicense != null && !medicalLicense.isEmpty()) {
                documentService.uploadDocument(hospitalId, medicalLicense, 
                        DocumentType.MEDICAL_LICENSE, "Medical License");
            }
            if (ayushCertificate != null && !ayushCertificate.isEmpty()) {
                documentService.uploadDocument(hospitalId, ayushCertificate, 
                        DocumentType.AYUSH_CERTIFICATE, "AYUSH Certificate");
            }
            if (nabhCertificate != null && !nabhCertificate.isEmpty()) {
                documentService.uploadDocument(hospitalId, nabhCertificate, 
                        DocumentType.NABH_CERTIFICATE, "NABH Certificate");
            }
            if (ownerIdProof != null && !ownerIdProof.isEmpty()) {
                documentService.uploadDocument(hospitalId, ownerIdProof, 
                        DocumentType.OWNER_ID_PROOF, "Owner ID Proof");
            }
            
            session.setAttribute("currentStep", 6);
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Error uploading documents: " + e.getMessage());
        }
        
        return "redirect:/hospital/register";
    }

    // Step 6: Specializations & Facilities
    @PostMapping("/register/step6")
    public String registerStep6(@RequestParam(required = false) String therapiesOffered,
                                @RequestParam(required = false) String specialTreatments,
                                @RequestParam(required = false) String facilitiesAvailable,
                                @RequestParam(required = false) String languagesSpoken,
                                HttpSession session, RedirectAttributes redirectAttributes) {
        
        Long hospitalId = (Long) session.getAttribute("registeredHospitalId");
        if (hospitalId == null) {
            // If not registered yet, get from session and register
            Hospital hospital = (Hospital) session.getAttribute("registrationData");
            hospital.setTherapiesOffered(therapiesOffered);
            hospital.setSpecialTreatments(specialTreatments);
            hospital.setFacilitiesAvailable(facilitiesAvailable);
            hospital.setLanguagesSpoken(languagesSpoken);
            
            try {
                Hospital savedHospital = hospitalService.registerHospital(hospital);
                hospitalId = savedHospital.getId();
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", e.getMessage());
                return "redirect:/hospital/register";
            }
        } else {
            // Update existing hospital
            Hospital hospital = hospitalService.findById(hospitalId)
                    .orElseThrow(() -> new RuntimeException("Hospital not found"));
            hospital.setTherapiesOffered(therapiesOffered);
            hospital.setSpecialTreatments(specialTreatments);
            hospital.setFacilitiesAvailable(facilitiesAvailable);
            hospital.setLanguagesSpoken(languagesSpoken);
            hospital.setProfileComplete(true);
            hospitalService.updateHospital(hospital);
        }
        
        // Clear session
        session.removeAttribute("registrationData");
        session.removeAttribute("registeredHospitalId");
        session.removeAttribute("currentStep");
        
        redirectAttributes.addFlashAttribute("success", 
                "Registration successful! Your profile is under review. You can login now.");
        return "redirect:/hospital/login";
    }

    // Go back to previous step
    @RequestMapping(value = "/register/back", method = RequestMethod.GET)
    public String goBack(HttpSession session) {
        Integer currentStep = (Integer) session.getAttribute("currentStep");
        if (currentStep != null && currentStep > 1) {
            session.setAttribute("currentStep", currentStep - 1);
        }
        return "redirect:/hospital/register";
    }
}
