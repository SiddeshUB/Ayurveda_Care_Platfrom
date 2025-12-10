package com.ayurveda.controller;

import com.ayurveda.entity.*;
import com.ayurveda.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/")
public class PublicProfileController {

    private final HospitalService hospitalService;
    private final PackageService packageService;
    private final DoctorService doctorService;
    private final PhotoService photoService;
    private final ReviewService reviewService;
    private final BookingService bookingService;
    private final RoomService roomService;
    private final ProductService productService;
    private final UserService userService;
    private final ConsultationService consultationService;

    @Autowired
    public PublicProfileController(HospitalService hospitalService,
                                  PackageService packageService,
                                  DoctorService doctorService,
                                  PhotoService photoService,
                                  ReviewService reviewService,
                                  BookingService bookingService,
                                  RoomService roomService,
                                  ProductService productService,
                                  UserService userService,
                                  ConsultationService consultationService) {
        this.hospitalService = hospitalService;
        this.packageService = packageService;
        this.doctorService = doctorService;
        this.photoService = photoService;
        this.reviewService = reviewService;
        this.bookingService = bookingService;
        this.roomService = roomService;
        this.productService = productService;
        this.userService = userService;
        this.consultationService = consultationService;
    }

    @RequestMapping(value = "/hospitals", method = RequestMethod.GET)
    public String listHospitals(@RequestParam(defaultValue = "") String search,
                                @RequestParam(defaultValue = "0") int page,
                                org.springframework.security.core.Authentication auth,
                                Model model) {
        Pageable pageable = PageRequest.of(page, 12, Sort.by(Sort.Direction.DESC, "averageRating"));
        Page<Hospital> hospitalPage = hospitalService.searchHospitals(search, pageable);
        
        model.addAttribute("hospitals", hospitalPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", hospitalPage.getTotalPages());
        model.addAttribute("search", search);
        
        // Add user info if logged in
        addUserToModel(auth, model);
        
        return "public/hospitals";
    }
    
    // Helper method to add user info to model
    private void addUserToModel(org.springframework.security.core.Authentication auth, Model model) {
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            try {
                com.ayurveda.entity.User user = userService.findByEmail(auth.getName()).orElse(null);
                if (user != null) {
                    model.addAttribute("currentUser", user);
                }
            } catch (Exception e) {
                // User not found or not a USER role - ignore
            }
        }
    }

    @RequestMapping(value = "/hospital/profile/{id}", method = RequestMethod.GET)
    public String hospitalProfile(@PathVariable Long id,
                                  @RequestParam(defaultValue = "overview") String tab,
                                  org.springframework.security.core.Authentication auth,
                                  Model model) {
        Hospital hospital = hospitalService.getPublicProfile(id);
        
        if (hospital.getStatus() != Hospital.HospitalStatus.APPROVED || !hospital.getIsActive()) {
            return "error/hospital-not-found";
        }
        
        // Check if user is authenticated
        boolean isUserLoggedIn = (auth != null && auth.isAuthenticated() && 
                                 !"anonymousUser".equals(auth.getPrincipal()) &&
                                 auth.getAuthorities().stream()
                                     .anyMatch(a -> a.getAuthority().equals("ROLE_USER")));
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("activeTab", tab);
        model.addAttribute("isUserLoggedIn", isUserLoggedIn);
        
        if ("packages".equals(tab)) {
            model.addAttribute("packages", packageService.getActivePackagesByHospital(id));
        } else if ("doctors".equals(tab)) {
            model.addAttribute("doctors", doctorService.getActiveDoctorsByHospital(id));
        } else if ("rooms".equals(tab)) {
            model.addAttribute("rooms", roomService.getActiveRoomsByHospital(id));
        } else if ("products".equals(tab)) {
            // Products are now managed by Vendors, not Hospitals
            // Redirect to the main products page
            model.addAttribute("products", productService.getFeaturedProducts());
        } else if ("gallery".equals(tab)) {
            model.addAttribute("photos", photoService.getActivePhotos(id));
        } else if ("reviews".equals(tab)) {
            model.addAttribute("reviews", reviewService.getPublicReviews(id, PageRequest.of(0, 10)).getContent());
            model.addAttribute("ratingBreakdown", reviewService.getRatingBreakdown(id));
        } else {
            model.addAttribute("photos", photoService.getActivePhotos(id));
            model.addAttribute("popularPackages", packageService.getTop3Packages(id));
            model.addAttribute("featuredReviews", reviewService.getFeaturedReviews(id));
        }
        
        // Add user info if logged in
        addUserToModel(auth, model);
        
        return "public/hospital-profile";
    }

    @RequestMapping(value = "/booking/enquiry/{hospitalId}", method = RequestMethod.GET)
    public String bookingEnquiryForm(@PathVariable Long hospitalId,
                                     @RequestParam(required = false) Long packageId,
                                     org.springframework.security.core.Authentication auth,
                                     Model model) {
        // Spring Security ensures only authenticated USER role can access this endpoint
        // If not authenticated, Spring Security redirects to /user/login automatically
        
        Hospital hospital = hospitalService.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        // Create a new Booking object and pre-populate with logged-in user's information
        Booking booking = new Booking();
        
        // Fetch the logged-in user and pre-populate booking form
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            userService.findByEmail(auth.getName()).ifPresent(user -> {
                // Pre-populate user information
                booking.setPatientName(user.getFullName());
                booking.setPatientEmail(user.getEmail());
                booking.setPatientPhone(user.getPhone());
                booking.setPatientCountry(user.getCountry() != null ? user.getCountry() : "India");
                booking.setPatientGender(user.getGender());
                
                // Calculate age from dateOfBirth if available
                if (user.getDateOfBirth() != null) {
                    java.time.LocalDate birthDate = user.getDateOfBirth().toLocalDate();
                    java.time.LocalDate currentDate = java.time.LocalDate.now();
                    int age = currentDate.getYear() - birthDate.getYear();
                    if (currentDate.getDayOfYear() < birthDate.getDayOfYear()) {
                        age--;
                    }
                    booking.setPatientAge(age);
                }
            });
        }
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("booking", booking);
        
        TreatmentPackage selectedPackage = null;
        if (packageId != null) {
            selectedPackage = packageService.findById(packageId).orElse(null);
            model.addAttribute("selectedPackage", selectedPackage);
        }
        
        List<TreatmentPackage> packages = packageService.getActivePackagesByHospital(hospitalId);
        model.addAttribute("packages", packages);
        model.addAttribute("roomTypes", Booking.RoomType.values());
        
        // Pass pricing info for ALL packages (not just selected one) for JavaScript calculation
        // Create a map where key is packageId and value is pricing map
        java.util.Map<Long, java.util.Map<String, Object>> allPackagesPricing = new java.util.HashMap<>();
        for (TreatmentPackage pkg : packages) {
            allPackagesPricing.put(pkg.getId(), createPricingMap(pkg));
        }
        model.addAttribute("allPackagesPricing", allPackagesPricing);
        
        // Also pass selected package pricing if available (for backward compatibility)
        if (selectedPackage != null) {
            model.addAttribute("packagePricing", createPricingMap(selectedPackage));
        }
        
        return "public/booking-enquiry";
    }
    
    private java.util.Map<String, Object> createPricingMap(TreatmentPackage pkg) {
        java.util.Map<String, Object> pricing = new java.util.HashMap<>();
        
        // Budget Room
        if (pkg.getBudgetRoomPrice() != null) {
            java.util.Map<String, Object> budget = new java.util.HashMap<>();
            budget.put("basePrice", pkg.getBudgetRoomPrice());
            budget.put("gstPercent", pkg.getBudgetRoomGstPercent() != null ? pkg.getBudgetRoomGstPercent() : java.math.BigDecimal.ZERO);
            budget.put("cgstPercent", pkg.getBudgetRoomCgstPercent() != null ? pkg.getBudgetRoomCgstPercent() : java.math.BigDecimal.ZERO);
            pricing.put("BUDGET", budget);
        }
        
        // Standard Room
        if (pkg.getStandardRoomPrice() != null) {
            java.util.Map<String, Object> standard = new java.util.HashMap<>();
            standard.put("basePrice", pkg.getStandardRoomPrice());
            standard.put("gstPercent", pkg.getStandardRoomGstPercent() != null ? pkg.getStandardRoomGstPercent() : java.math.BigDecimal.ZERO);
            standard.put("cgstPercent", pkg.getStandardRoomCgstPercent() != null ? pkg.getStandardRoomCgstPercent() : java.math.BigDecimal.ZERO);
            pricing.put("STANDARD", standard);
        }
        
        // Deluxe Room
        if (pkg.getDeluxeRoomPrice() != null) {
            java.util.Map<String, Object> deluxe = new java.util.HashMap<>();
            deluxe.put("basePrice", pkg.getDeluxeRoomPrice());
            deluxe.put("gstPercent", pkg.getDeluxeRoomGstPercent() != null ? pkg.getDeluxeRoomGstPercent() : java.math.BigDecimal.ZERO);
            deluxe.put("cgstPercent", pkg.getDeluxeRoomCgstPercent() != null ? pkg.getDeluxeRoomCgstPercent() : java.math.BigDecimal.ZERO);
            pricing.put("DELUXE", deluxe);
        }
        
        // Suite Room
        if (pkg.getSuiteRoomPrice() != null) {
            java.util.Map<String, Object> suite = new java.util.HashMap<>();
            suite.put("basePrice", pkg.getSuiteRoomPrice());
            suite.put("gstPercent", pkg.getSuiteRoomGstPercent() != null ? pkg.getSuiteRoomGstPercent() : java.math.BigDecimal.ZERO);
            suite.put("cgstPercent", pkg.getSuiteRoomCgstPercent() != null ? pkg.getSuiteRoomCgstPercent() : java.math.BigDecimal.ZERO);
            pricing.put("SUITE", suite);
        }
        
        // Villa
        if (pkg.getVillaPrice() != null) {
            java.util.Map<String, Object> villa = new java.util.HashMap<>();
            villa.put("basePrice", pkg.getVillaPrice());
            villa.put("gstPercent", pkg.getVillaGstPercent() != null ? pkg.getVillaGstPercent() : java.math.BigDecimal.ZERO);
            villa.put("cgstPercent", pkg.getVillaCgstPercent() != null ? pkg.getVillaCgstPercent() : java.math.BigDecimal.ZERO);
            pricing.put("VILLA", villa);
        }
        
        // VIP Room
        if (pkg.getVipRoomPrice() != null) {
            java.util.Map<String, Object> vip = new java.util.HashMap<>();
            vip.put("basePrice", pkg.getVipRoomPrice());
            vip.put("gstPercent", pkg.getVipRoomGstPercent() != null ? pkg.getVipRoomGstPercent() : java.math.BigDecimal.ZERO);
            vip.put("cgstPercent", pkg.getVipRoomCgstPercent() != null ? pkg.getVipRoomCgstPercent() : java.math.BigDecimal.ZERO);
            pricing.put("VIP", vip);
        }
        
        return pricing;
    }

    @PostMapping("/booking/enquiry/{hospitalId}")
    public String submitBookingEnquiry(@PathVariable Long hospitalId,
                                       @RequestParam(required = false) Long packageId,
                                       @ModelAttribute Booking booking,
                                       org.springframework.security.core.Authentication auth,
                                       RedirectAttributes redirectAttributes) {
        // Check if user is logged in
        if (auth == null || !auth.isAuthenticated() || "anonymousUser".equals(auth.getPrincipal())) {
            redirectAttributes.addFlashAttribute("error", "Please login to submit a booking");
            redirectAttributes.addFlashAttribute("redirectUrl", "/booking/enquiry/" + hospitalId + 
                (packageId != null ? "?packageId=" + packageId : ""));
            return "redirect:/user/login";
        }

        try {
            // Get the logged-in user
            User currentUser = userService.findByEmail(auth.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            // Validate required fields
            if (booking.getPatientName() == null || booking.getPatientName().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Patient name is required");
                return "redirect:/booking/enquiry/" + hospitalId + (packageId != null ? "?packageId=" + packageId : "");
            }
            if (booking.getPatientEmail() == null || booking.getPatientEmail().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Patient email is required");
                return "redirect:/booking/enquiry/" + hospitalId + (packageId != null ? "?packageId=" + packageId : "");
            }
            if (booking.getPatientPhone() == null || booking.getPatientPhone().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Patient phone is required");
                return "redirect:/booking/enquiry/" + hospitalId + (packageId != null ? "?packageId=" + packageId : "");
            }
            if (packageId == null) {
                redirectAttributes.addFlashAttribute("error", "Please select a package");
                return "redirect:/booking/enquiry/" + hospitalId;
            }
            if (booking.getRoomType() == null) {
                redirectAttributes.addFlashAttribute("error", "Please select a room type");
                return "redirect:/booking/enquiry/" + hospitalId + "?packageId=" + packageId;
            }
            if (booking.getCheckInDate() == null) {
                redirectAttributes.addFlashAttribute("error", "Check-in date is required");
                return "redirect:/booking/enquiry/" + hospitalId + "?packageId=" + packageId;
            }
            if (booking.getCheckOutDate() == null) {
                redirectAttributes.addFlashAttribute("error", "Check-out date is required");
                return "redirect:/booking/enquiry/" + hospitalId + "?packageId=" + packageId;
            }
            
            Booking savedBooking = bookingService.createBooking(hospitalId, packageId, booking, currentUser);
            redirectAttributes.addFlashAttribute("success", "Booking submitted successfully! Booking Number: " + savedBooking.getBookingNumber());
            return "redirect:/booking/confirmation/" + savedBooking.getBookingNumber();
        } catch (RuntimeException e) {
            e.printStackTrace(); // Log the exception
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
            return "redirect:/booking/enquiry/" + hospitalId + (packageId != null ? "?packageId=" + packageId : "");
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            redirectAttributes.addFlashAttribute("error", "An unexpected error occurred. Please try again.");
            return "redirect:/booking/enquiry/" + hospitalId + (packageId != null ? "?packageId=" + packageId : "");
        }
    }

    @RequestMapping(value = "/booking/confirmation/{bookingNumber}", method = RequestMethod.GET)
    public String bookingConfirmation(@PathVariable String bookingNumber, Model model) {
        Booking booking = bookingService.findByBookingNumber(bookingNumber)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        model.addAttribute("booking", booking);
        return "public/booking-confirmation";
    }

    @PostMapping("/hospital/profile/{hospitalId}/review")
    public String submitReview(@PathVariable Long hospitalId,
                               @ModelAttribute Review review,
                               RedirectAttributes redirectAttributes) {
        try {
            reviewService.createReview(hospitalId, review);
            redirectAttributes.addFlashAttribute("success", "Thank you for your review!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/hospital/profile/" + hospitalId + "?tab=reviews";
    }

    // ========== PUBLIC DOCTOR PAGES ==========
    @RequestMapping(value = "/doctors", method = RequestMethod.GET)
    public String listDoctors(@RequestParam(defaultValue = "") String search,
                              org.springframework.security.core.Authentication auth,
                              Model model) {
        List<Doctor> doctors;
        
        if (search != null && !search.trim().isEmpty()) {
            doctors = doctorService.searchDoctors(search);
        } else {
            doctors = doctorService.getAllActiveVerifiedDoctors();
        }
        
        model.addAttribute("doctors", doctors);
        model.addAttribute("search", search);
        
        // Add user info if logged in
        addUserToModel(auth, model);
        
        return "public/doctors";
    }

    @RequestMapping(value = "/doctor/profile/{id}", method = RequestMethod.GET)
    public String doctorProfile(@PathVariable Long id,
                                org.springframework.security.core.Authentication auth,
                                Model model) {
        Optional<Doctor> doctorOpt = doctorService.getPublicDoctorProfile(id);
        
        if (doctorOpt.isEmpty()) {
            return "error/doctor-not-found";
        }
        
        Doctor doctor = doctorOpt.get();
        model.addAttribute("doctor", doctor);
        
        // Add user info if logged in
        addUserToModel(auth, model);
        
        // Get hospital info if associated
        if (doctor.getHospital() != null) {
            model.addAttribute("hospital", doctor.getHospital());
        }
        
        return "public/doctor-profile";
    }

    // ========== ROOM BOOKING ==========
    @RequestMapping(value = "/room/booking/{roomId}", method = RequestMethod.GET)
    public String roomBookingForm(@PathVariable Long roomId,
                                  @RequestParam(required = false) String checkIn,
                                  @RequestParam(required = false) String checkOut,
                                  org.springframework.security.core.Authentication auth,
                                  Model model,
                                  RedirectAttributes redirectAttributes) {
        // Check if user is logged in
        if (auth == null || !auth.isAuthenticated() || "anonymousUser".equals(auth.getPrincipal())) {
            redirectAttributes.addFlashAttribute("error", "Please login to book a room");
            redirectAttributes.addFlashAttribute("redirectUrl", "/room/booking/" + roomId + 
                (checkIn != null ? "?checkIn=" + checkIn : "") + 
                (checkOut != null ? (checkIn != null ? "&" : "?") + "checkOut=" + checkOut : ""));
            return "redirect:/user/login";
        }

        Room room = roomService.findById(roomId)
                .orElseThrow(() -> new RuntimeException("Room not found"));

        if (!room.getIsActive() || !room.getIsAvailable()) {
            model.addAttribute("error", "This room is not available for booking");
            return "error/room-not-available";
        }

        model.addAttribute("room", room);
        model.addAttribute("hospital", room.getHospital());
        model.addAttribute("booking", new RoomBooking());
        model.addAttribute("checkIn", checkIn);
        model.addAttribute("checkOut", checkOut);

        return "public/room-booking-form";
    }

    @PostMapping("/room/booking/{roomId}")
    public String submitRoomBooking(@PathVariable Long roomId,
                                   @RequestParam(required = false) Long userId,
                                   @ModelAttribute RoomBooking booking,
                                   RedirectAttributes redirectAttributes) {
        try {
            RoomBooking savedBooking = roomService.createRoomBooking(roomId, userId, booking);
            return "redirect:/room/booking/confirmation/" + savedBooking.getBookingNumber();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
            return "redirect:/room/booking/" + roomId;
        }
    }

    @RequestMapping(value = "/room/booking/confirmation/{bookingNumber}", method = RequestMethod.GET)
    public String roomBookingConfirmation(@PathVariable String bookingNumber, Model model) {
        RoomBooking booking = roomService.findRoomBookingByBookingNumber(bookingNumber)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        model.addAttribute("booking", booking);
        return "public/room-booking-confirmation";
    }

    // ========== PUBLIC DETAIL PAGES (VIEW ONLY) ==========
    
    @RequestMapping(value = "/package/details/{id}", method = RequestMethod.GET)
    public String packageDetails(@PathVariable Long id, Model model) {
        Optional<TreatmentPackage> packageOpt = packageService.findById(id);
        
        if (packageOpt.isEmpty() || !packageOpt.get().getIsActive()) {
            return "error/package-not-found";
        }
        
        TreatmentPackage pkg = packageOpt.get();
        if (pkg.getHospital().getStatus() != Hospital.HospitalStatus.APPROVED || !pkg.getHospital().getIsActive()) {
            return "error/package-not-found";
        }
        
        model.addAttribute("package", pkg);
        model.addAttribute("hospital", pkg.getHospital());
        
        return "public/package-details";
    }

    @RequestMapping(value = "/room/details/{id}", method = RequestMethod.GET)
    public String roomDetails(@PathVariable Long id, Model model) {
        Optional<Room> roomOpt = roomService.findById(id);
        
        if (roomOpt.isEmpty() || !roomOpt.get().getIsActive()) {
            return "error/room-not-found";
        }
        
        Room room = roomOpt.get();
        if (room.getHospital().getStatus() != Hospital.HospitalStatus.APPROVED || !room.getHospital().getIsActive()) {
            return "error/room-not-found";
        }
        
        model.addAttribute("room", room);
        model.addAttribute("hospital", room.getHospital());
        
        return "public/room-details";
    }

    @RequestMapping(value = "/product/details/{id}", method = RequestMethod.GET)
    public String productDetails(@PathVariable Long id, Model model) {
        Optional<Product> productOpt = productService.findById(id);
        
        if (productOpt.isEmpty() || !productOpt.get().getIsActive()) {
            return "error/product-not-found";
        }
        
        Product product = productOpt.get();
        
        // Products are now managed by Vendors, not Hospitals
        // Check if vendor is approved
        if (product.getVendor() == null || 
            product.getVendor().getStatus() != Vendor.VendorStatus.APPROVED || 
            !product.getVendor().getIsActive()) {
            return "error/product-not-found";
        }
        
        model.addAttribute("product", product);
        model.addAttribute("vendor", product.getVendor());
        
        // Redirect to the main shop product details page
        return "redirect:/products/" + id;
    }

    // ========== DIRECT CONSULTATION BOOKING ==========
    @RequestMapping(value = "/consultation/book/{doctorId}", method = RequestMethod.GET)
    public String consultationBookingForm(@PathVariable Long doctorId,
                                         org.springframework.security.core.Authentication auth,
                                         Model model,
                                         RedirectAttributes redirectAttributes) {
        // Check if user is logged in
        if (auth == null || !auth.isAuthenticated() || "anonymousUser".equals(auth.getPrincipal())) {
            redirectAttributes.addFlashAttribute("error", "Please login to book a consultation");
            redirectAttributes.addFlashAttribute("redirectUrl", "/consultation/book/" + doctorId);
            return "redirect:/user/login";
        }

        // Get doctor
        Optional<Doctor> doctorOpt = doctorService.getPublicDoctorProfile(doctorId);
        if (doctorOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Doctor not found");
            return "redirect:/doctors";
        }

        Doctor doctor = doctorOpt.get();
        
        // Get current user
        User user = userService.findByEmail(auth.getName())
                .orElseThrow(() -> new RuntimeException("User not found"));

        model.addAttribute("doctor", doctor);
        model.addAttribute("user", user);
        if (doctor.getHospital() != null) {
            model.addAttribute("hospital", doctor.getHospital());
        }

        return "public/consultation-booking-form";
    }

    @PostMapping("/consultation/book/{doctorId}")
    public String submitConsultationBooking(@PathVariable Long doctorId,
                                           @RequestParam String patientName,
                                           @RequestParam String patientEmail,
                                           @RequestParam String patientPhone,
                                           @RequestParam Integer patientAge,
                                           @RequestParam String patientGender,
                                           @RequestParam String consultationType,
                                           @RequestParam String consultationDate,
                                           @RequestParam String consultationTime,
                                           @RequestParam(required = false) Integer durationMinutes,
                                           @RequestParam(required = false) String reasonForVisit,
                                           @RequestParam(required = false) String symptoms,
                                           @RequestParam(required = false) String medicalHistory,
                                           @RequestParam(required = false) String currentMedications,
                                           @RequestParam(required = false) String patientHeight,
                                           @RequestParam(required = false) String patientWeight,
                                           @RequestParam(required = false) String bloodPressure,
                                           @RequestParam(required = false) String allergies,
                                           org.springframework.security.core.Authentication auth,
                                           RedirectAttributes redirectAttributes) {
        // Check if user is logged in
        if (auth == null || !auth.isAuthenticated() || "anonymousUser".equals(auth.getPrincipal())) {
            redirectAttributes.addFlashAttribute("error", "Please login to book a consultation");
            return "redirect:/user/login";
        }

        try {
            // Get current user
            User user = userService.findByEmail(auth.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));

            // Create consultation object and set all fields
            Consultation consultation = new Consultation();
            consultation.setPatientName(patientName);
            consultation.setPatientEmail(patientEmail);
            consultation.setPatientPhone(patientPhone);
            consultation.setPatientAge(patientAge);
            consultation.setPatientGender(patientGender);
            consultation.setConsultationType(Consultation.ConsultationType.valueOf(consultationType));
            consultation.setConsultationDate(java.time.LocalDate.parse(consultationDate));
            consultation.setConsultationTime(java.time.LocalTime.parse(consultationTime));
            if (durationMinutes != null) {
                consultation.setDurationMinutes(durationMinutes);
            } else {
                consultation.setDurationMinutes(60); // Default 60 minutes
            }
            consultation.setReasonForVisit(reasonForVisit);
            consultation.setSymptoms(symptoms);
            consultation.setMedicalHistory(medicalHistory);
            consultation.setCurrentMedications(currentMedications);
            consultation.setPatientHeight(patientHeight);
            consultation.setPatientWeight(patientWeight);
            consultation.setBloodPressure(bloodPressure);
            consultation.setAllergies(allergies);

            // Create consultation
            Consultation savedConsultation = consultationService.createDirectConsultation(
                    doctorId, user.getId(), consultation);

            redirectAttributes.addFlashAttribute("success", 
                    "Consultation booking request submitted successfully! Consultation Number: " + 
                    savedConsultation.getConsultationNumber() + ". The doctor will review your request.");
            
            return "redirect:/user/dashboard/consultations";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error booking consultation: " + e.getMessage());
            return "redirect:/consultation/book/" + doctorId;
        }
    }
}
