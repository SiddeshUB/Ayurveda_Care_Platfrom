package com.ayurveda.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ayurveda.entity.Booking;
import com.ayurveda.entity.Booking.BookingStatus;
import com.ayurveda.entity.Doctor;
import com.ayurveda.entity.DoctorHospitalAssociation;
import com.ayurveda.entity.Hospital;
import com.ayurveda.entity.HospitalDocument;
import com.ayurveda.entity.HospitalPhoto;
import com.ayurveda.entity.HospitalPhoto.PhotoCategory;
// Product management moved to VendorController
import com.ayurveda.entity.Review;
import com.ayurveda.entity.Room;
import com.ayurveda.entity.TreatmentPackage;
import com.ayurveda.entity.TreatmentPackage.PackageType;
import com.ayurveda.entity.UserEnquiry;
import com.ayurveda.repository.UserEnquiryRepository;
import com.ayurveda.service.BookingService;
import com.ayurveda.service.DoctorHospitalAssociationService;
import com.ayurveda.service.DoctorService;
import com.ayurveda.service.DocumentService;
import com.ayurveda.service.HospitalService;
import com.ayurveda.service.PackageService;
import com.ayurveda.service.PhotoService;
import com.ayurveda.service.ReviewService;
import com.ayurveda.service.RoomService;
import com.ayurveda.service.ProductService;
import com.ayurveda.entity.Product;
import com.ayurveda.repository.ProductRepository;
import com.ayurveda.service.ProductCategoryService;
import com.ayurveda.entity.ProductCategory;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {

    private final HospitalService hospitalService;
    private final DoctorService doctorService;
    private final PackageService packageService;
    private final BookingService bookingService;
    private final ReviewService reviewService;
    private final PhotoService photoService;
    private final DocumentService documentService;
    private final DoctorHospitalAssociationService associationService;
    private final RoomService roomService;
    private final UserEnquiryRepository enquiryRepository;
    private final ProductRepository productRepository;
    private final ProductCategoryService categoryService;

    @Autowired
    public DashboardController(HospitalService hospitalService,
                              DoctorService doctorService,
                              PackageService packageService,
                              BookingService bookingService,
                              ReviewService reviewService,
                              PhotoService photoService,
                              DocumentService documentService,
                              DoctorHospitalAssociationService associationService,
                              RoomService roomService,
                              UserEnquiryRepository enquiryRepository,
                              ProductRepository productRepository,
                              ProductCategoryService categoryService) {
        this.hospitalService = hospitalService;
        this.doctorService = doctorService;
        this.packageService = packageService;
        this.bookingService = bookingService;
        this.reviewService = reviewService;
        this.photoService = photoService;
        this.documentService = documentService;
        this.associationService = associationService;
        this.roomService = roomService;
        this.enquiryRepository = enquiryRepository;
        this.productRepository = productRepository;
        this.categoryService = categoryService;
    }

    // Helper method to get current hospital
    private Hospital getCurrentHospital(Authentication auth) {
        return hospitalService.findByEmail(auth.getName())
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
    }

    // ========== DASHBOARD OVERVIEW ==========
    @RequestMapping(method = RequestMethod.GET)
    public String dashboard(Authentication auth, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        hospitalService.updateLastLogin(hospital.getId());
        
        Map<String, Object> stats = hospitalService.getDashboardStats(hospital.getId());
        List<Booking> recentBookings = hospitalService.getRecentBookings(hospital.getId(), 5);
        List<Review> recentReviews = hospitalService.getRecentReviews(hospital.getId(), 5);
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("stats", stats);
        model.addAttribute("recentBookings", recentBookings);
        model.addAttribute("recentReviews", recentReviews);
        
        return "dashboard/index";
    }

    // ========== PROFILE MANAGEMENT ==========
    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String profile(Authentication auth, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        model.addAttribute("hospital", hospital);
        model.addAttribute("centerTypes", Hospital.CenterType.values());
        return "dashboard/profile";
    }

    @PostMapping("/profile/basic")
    public String updateBasicInfo(Authentication auth,
                                  @RequestParam String centerName,
                                  @RequestParam String centerType,
                                  @RequestParam(required = false) Integer yearEstablished,
                                  @RequestParam(required = false) String description,
                                  RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        Hospital updateData = new Hospital();
        updateData.setCenterName(centerName);
        updateData.setCenterType(Hospital.CenterType.valueOf(centerType));
        updateData.setYearEstablished(yearEstablished);
        updateData.setDescription(description);
        
        hospitalService.updateBasicInfo(hospital.getId(), updateData);
        redirectAttributes.addFlashAttribute("success", "Basic information updated successfully");
        return "redirect:/dashboard/profile";
    }

    @PostMapping("/profile/location")
    public String updateLocation(Authentication auth,
                                 @RequestParam String streetAddress,
                                 @RequestParam String city,
                                 @RequestParam String state,
                                 @RequestParam String pinCode,
                                 @RequestParam(required = false) String googleMapsUrl,
                                 RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        Hospital updateData = new Hospital();
        updateData.setStreetAddress(streetAddress);
        updateData.setCity(city);
        updateData.setState(state);
        updateData.setPinCode(pinCode);
        updateData.setGoogleMapsUrl(googleMapsUrl);
        
        hospitalService.updateLocationDetails(hospital.getId(), updateData);
        redirectAttributes.addFlashAttribute("success", "Location details updated successfully");
        return "redirect:/dashboard/profile";
    }

    @PostMapping("/profile/contact")
    public String updateContact(Authentication auth,
                                @RequestParam(required = false) String receptionPhone,
                                @RequestParam(required = false) String emergencyPhone,
                                @RequestParam(required = false) String bookingPhone,
                                @RequestParam(required = false) String publicEmail,
                                @RequestParam(required = false) String website,
                                @RequestParam(required = false) String instagramUrl,
                                @RequestParam(required = false) String facebookUrl,
                                @RequestParam(required = false) String youtubeUrl,
                                RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        Hospital updateData = new Hospital();
        updateData.setReceptionPhone(receptionPhone);
        updateData.setEmergencyPhone(emergencyPhone);
        updateData.setBookingPhone(bookingPhone);
        updateData.setPublicEmail(publicEmail);
        updateData.setWebsite(website);
        updateData.setInstagramUrl(instagramUrl);
        updateData.setFacebookUrl(facebookUrl);
        updateData.setYoutubeUrl(youtubeUrl);
        
        hospitalService.updateContactDetails(hospital.getId(), updateData);
        redirectAttributes.addFlashAttribute("success", "Contact details updated successfully");
        return "redirect:/dashboard/profile";
    }

    @PostMapping("/profile/specializations")
    public String updateSpecializations(Authentication auth,
                                        @RequestParam(required = false) String therapiesOffered,
                                        @RequestParam(required = false) String specialTreatments,
                                        @RequestParam(required = false) String facilitiesAvailable,
                                        @RequestParam(required = false) String languagesSpoken,
                                        RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        Hospital updateData = new Hospital();
        updateData.setTherapiesOffered(therapiesOffered);
        updateData.setSpecialTreatments(specialTreatments);
        updateData.setFacilitiesAvailable(facilitiesAvailable);
        updateData.setLanguagesSpoken(languagesSpoken);
        
        hospitalService.updateSpecializations(hospital.getId(), updateData);
        redirectAttributes.addFlashAttribute("success", "Specializations updated successfully");
        return "redirect:/dashboard/profile";
    }

    // ========== TREATMENT PACKAGES ==========
    @RequestMapping(value = "/packages", method = RequestMethod.GET)
    public String packages(Authentication auth, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        List<TreatmentPackage> packages = packageService.getPackagesByHospital(hospital.getId());
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("packages", packages);
        model.addAttribute("packageTypes", PackageType.values());
        return "dashboard/packages";
    }

    @RequestMapping(value = "/packages/add", method = RequestMethod.GET)
    public String addPackageForm(Authentication auth, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        // Get all doctors registered with this hospital
        List<Doctor> doctors = doctorService.getDoctorsByHospital(hospital.getId());
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("packageTypes", TreatmentPackage.PackageType.values());
        model.addAttribute("doctors", doctors);
        model.addAttribute("pkg", new TreatmentPackage());
        return "dashboard/package-form";
    }

    @PostMapping("/packages/add")
    public String addPackage(Authentication auth, 
                             @ModelAttribute TreatmentPackage pkg,
                             @RequestParam(required = false) String customType,
                             @RequestParam(required = false) List<Long> doctorIds,
                             @RequestParam(required = false) MultipartFile imageFile,
                             RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        try {
            // Handle custom type if OTHERS is selected
            if (pkg.getPackageType() == TreatmentPackage.PackageType.OTHERS && customType != null && !customType.trim().isEmpty()) {
                pkg.setCustomType(customType.trim());
            }
            
            TreatmentPackage savedPkg = packageService.createPackage(hospital.getId(), pkg);
            
            // Associate doctors with package
            if (doctorIds != null && !doctorIds.isEmpty()) {
                packageService.associateDoctors(savedPkg.getId(), doctorIds);
            }
            
            if (imageFile != null && !imageFile.isEmpty()) {
                packageService.uploadPackageImage(savedPkg.getId(), imageFile);
            }
            
            redirectAttributes.addFlashAttribute("success", "Package added successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error adding package: " + e.getMessage());
        }
        
        return "redirect:/dashboard/packages";
    }

    @RequestMapping(value = "/packages/edit/{id}", method = RequestMethod.GET)
    public String editPackageForm(Authentication auth, @PathVariable Long id, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        TreatmentPackage pkg = packageService.findById(id)
                .orElseThrow(() -> new RuntimeException("Package not found"));
        
        // Security check
        if (!pkg.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        // Get all doctors registered with this hospital
        List<Doctor> doctors = doctorService.getDoctorsByHospital(hospital.getId());
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("pkg", pkg);
        model.addAttribute("packageTypes", TreatmentPackage.PackageType.values());
        model.addAttribute("doctors", doctors);
        // Get currently associated doctor IDs
        List<Long> associatedDoctorIds = new ArrayList<>();
        if (pkg.getDoctors() != null && !pkg.getDoctors().isEmpty()) {
            associatedDoctorIds = pkg.getDoctors().stream()
                    .map(Doctor::getId)
                    .collect(java.util.stream.Collectors.toList());
        }
        model.addAttribute("associatedDoctorIds", associatedDoctorIds);
        return "dashboard/package-form";
    }

    @PostMapping("/packages/edit/{id}")
    public String updatePackage(Authentication auth, @PathVariable Long id,
                                @ModelAttribute TreatmentPackage pkg,
                                @RequestParam(required = false) String customType,
                                @RequestParam(required = false) List<Long> doctorIds,
                                @RequestParam(required = false) MultipartFile imageFile,
                                RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        TreatmentPackage existingPkg = packageService.findById(id)
                .orElseThrow(() -> new RuntimeException("Package not found"));
        
        // Security check
        if (!existingPkg.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        try {
            // Handle custom type if OTHERS is selected
            if (pkg.getPackageType() == TreatmentPackage.PackageType.OTHERS && customType != null && !customType.trim().isEmpty()) {
                pkg.setCustomType(customType.trim());
            } else if (pkg.getPackageType() != TreatmentPackage.PackageType.OTHERS) {
                pkg.setCustomType(null); // Clear custom type if not OTHERS
            }
            
            packageService.updatePackage(id, pkg);
            
            // Update doctor associations
            if (doctorIds != null) {
                packageService.updateDoctorAssociations(id, doctorIds);
            }
            
            if (imageFile != null && !imageFile.isEmpty()) {
                packageService.uploadPackageImage(id, imageFile);
            }
            
            redirectAttributes.addFlashAttribute("success", "Package updated successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating package: " + e.getMessage());
        }
        
        return "redirect:/dashboard/packages";
    }

    @PostMapping("/packages/delete/{id}")
    public String deletePackage(Authentication auth, @PathVariable Long id,
                                RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        TreatmentPackage pkg = packageService.findById(id)
                .orElseThrow(() -> new RuntimeException("Package not found"));
        
        if (!pkg.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        packageService.deletePackage(id);
        redirectAttributes.addFlashAttribute("success", "Package deleted successfully");
        return "redirect:/dashboard/packages";
    }

    @PostMapping("/packages/toggle/{id}")
    public String togglePackageStatus(Authentication auth, @PathVariable Long id,
                                      RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        TreatmentPackage pkg = packageService.findById(id)
                .orElseThrow(() -> new RuntimeException("Package not found"));
        
        if (!pkg.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        packageService.togglePackageStatus(id);
        redirectAttributes.addFlashAttribute("success", "Package status updated");
        return "redirect:/dashboard/packages";
    }

    // ========== ACCOMMODATION ROOMS ==========
    @RequestMapping(value = "/rooms", method = RequestMethod.GET)
    public String rooms(Authentication auth, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        List<Room> rooms = roomService.getRoomsByHospital(hospital.getId());
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("rooms", rooms);
        return "dashboard/rooms";
    }

    @RequestMapping(value = "/rooms/add", method = RequestMethod.GET)
    public String addRoomForm(Authentication auth, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        model.addAttribute("hospital", hospital);
        model.addAttribute("room", new Room());
        return "dashboard/room-form";
    }

    @PostMapping("/rooms/add")
    public String addRoom(Authentication auth, @ModelAttribute Room room,
                         @RequestParam(required = false) String hasAC,
                         @RequestParam(required = false) String hasAttachedBathroom,
                         @RequestParam(required = false) String hasBalcony,
                         @RequestParam(required = false) String hasView,
                         @RequestParam(required = false) String isActive,
                         @RequestParam(required = false) String isAvailable,
                         @RequestParam(required = false) MultipartFile[] imageFiles,
                         RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        try {
            // Handle checkbox values (unchecked checkboxes don't send values)
            room.setHasAC("true".equals(hasAC));
            room.setHasAttachedBathroom("true".equals(hasAttachedBathroom));
            room.setHasBalcony("true".equals(hasBalcony));
            room.setHasView("true".equals(hasView));
            room.setIsActive("true".equals(isActive));
            room.setIsAvailable("true".equals(isAvailable));
            
            Room savedRoom = roomService.createRoom(hospital.getId(), room);
            
            if (imageFiles != null && imageFiles.length > 0) {
                // Handle multiple image uploads (similar to gallery upload)
                // For now, just save the first image URL if available
            }
            
            redirectAttributes.addFlashAttribute("success", "Room added successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error adding room: " + e.getMessage());
        }
        
        return "redirect:/dashboard/rooms";
    }

    @RequestMapping(value = "/rooms/edit/{id}", method = RequestMethod.GET)
    public String editRoomForm(Authentication auth, @PathVariable Long id, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        Room room = roomService.findById(id)
                .orElseThrow(() -> new RuntimeException("Room not found"));
        
        if (!room.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("room", room);
        return "dashboard/room-form";
    }

    @PostMapping("/rooms/edit/{id}")
    public String updateRoom(Authentication auth, @PathVariable Long id,
                            @ModelAttribute Room room,
                            @RequestParam(required = false) String hasAC,
                            @RequestParam(required = false) String hasAttachedBathroom,
                            @RequestParam(required = false) String hasBalcony,
                            @RequestParam(required = false) String hasView,
                            @RequestParam(required = false) String isActive,
                            @RequestParam(required = false) String isAvailable,
                            RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        Room existingRoom = roomService.findById(id)
                .orElseThrow(() -> new RuntimeException("Room not found"));
        
        if (!existingRoom.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        try {
            // Handle checkbox values (unchecked checkboxes don't send values)
            room.setHasAC("true".equals(hasAC));
            room.setHasAttachedBathroom("true".equals(hasAttachedBathroom));
            room.setHasBalcony("true".equals(hasBalcony));
            room.setHasView("true".equals(hasView));
            room.setIsActive("true".equals(isActive));
            room.setIsAvailable("true".equals(isAvailable));
            
            roomService.updateRoom(id, room);
            redirectAttributes.addFlashAttribute("success", "Room updated successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating room: " + e.getMessage());
        }
        
        return "redirect:/dashboard/rooms";
    }

    @PostMapping("/rooms/delete/{id}")
    public String deleteRoom(Authentication auth, @PathVariable Long id,
                            RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        Room room = roomService.findById(id)
                .orElseThrow(() -> new RuntimeException("Room not found"));
        
        if (!room.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        try {
            roomService.deleteRoom(id);
            redirectAttributes.addFlashAttribute("success", "Room deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting room: " + e.getMessage());
        }
        
        return "redirect:/dashboard/rooms";
    }

    @PostMapping("/rooms/toggle/{id}")
    public String toggleRoomStatus(Authentication auth, @PathVariable Long id,
                                  RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        Room room = roomService.findById(id)
                .orElseThrow(() -> new RuntimeException("Room not found"));
        
        if (!room.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        try {
            Room updateData = new Room();
            updateData.setIsActive(!Boolean.TRUE.equals(room.getIsActive()));
            roomService.updateRoom(id, updateData);
            redirectAttributes.addFlashAttribute("success", "Room status updated");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating room status: " + e.getMessage());
        }
        
        return "redirect:/dashboard/rooms";
    }

    // ========== PRODUCT MANAGEMENT ==========
    // NOTE: Product management has been moved to VendorController (/vendor/products)
    // Products are now managed by Vendors, not Hospitals
    // This route shows legacy products associated with the hospital (via hospitalId)
    @RequestMapping(value = "/products", method = RequestMethod.GET)
    public String products(Authentication auth, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        
        // Find products by legacy hospitalId field
        // Since there's no direct repository method, we'll query all and filter
        // In production, consider adding a custom query method
        List<Product> products = new ArrayList<>();
        try {
            products = productRepository.findAll().stream()
                    .filter(p -> p != null && p.getHospitalId() != null && p.getHospitalId().equals(hospital.getId()))
                    .collect(Collectors.toList());
        } catch (Exception e) {
            // Log error but continue with empty list
            System.err.println("Error fetching products for hospital " + hospital.getId() + ": " + e.getMessage());
            e.printStackTrace();
        }
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("products", products != null ? products : new ArrayList<>());
        
        return "dashboard/products";
    }

    // Show add product form
    @RequestMapping(value = "/products/add", method = RequestMethod.GET)
    public String showAddProductForm(Authentication auth, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        List<ProductCategory> categories = categoryService.findActiveCategories();
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("categories", categories);
        model.addAttribute("product", new Product()); // Empty product for new form
        
        return "dashboard/product-form";
    }

    // Handle add product form submission
    @PostMapping("/products/add")
    public String addProduct(@ModelAttribute Product product,
                           @RequestParam(required = false) Long categoryId,
                           @RequestParam(required = false) MultipartFile image,
                           Authentication auth,
                           RedirectAttributes redirectAttributes) {
        try {
            Hospital hospital = getCurrentHospital(auth);
            
            // Set category if provided
            if (categoryId != null && categoryId > 0) {
                ProductCategory category = categoryService.findById(categoryId)
                        .orElseThrow(() -> new RuntimeException("Category not found"));
                product.setCategory(category);
            }
            
            // Set hospitalId (legacy field)
            product.setHospitalId(hospital.getId());
            
            // Set default values
            if (product.getIsActive() == null) {
                product.setIsActive(true);
            }
            if (product.getIsAvailable() == null) {
                product.setIsAvailable(true);
            }
            if (product.getCreatedAt() == null) {
                product.setCreatedAt(LocalDateTime.now());
            }
            product.setUpdatedAt(LocalDateTime.now());
            
            // Generate SKU if not provided
            if (product.getSku() == null || product.getSku().isEmpty()) {
                String sku = "HOSP-" + hospital.getId() + "-" + System.currentTimeMillis();
                product.setSku(sku);
            }
            
            // Generate slug if not provided
            if (product.getSlug() == null || product.getSlug().isEmpty()) {
                String slug = product.getProductName().toLowerCase()
                        .replaceAll("[^a-z0-9]+", "-")
                        .replaceAll("^-|-$", "");
                product.setSlug(slug);
            }
            
            // Save product
            Product savedProduct = productRepository.save(product);
            
            // TODO: Handle image upload if needed
            // For now, image upload would need to be handled separately
            
            redirectAttributes.addFlashAttribute("success", "Product added successfully!");
            return "redirect:/dashboard/products";
            
        } catch (Exception e) {
            System.err.println("Error adding product: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Failed to add product: " + e.getMessage());
            return "redirect:/dashboard/products/add";
        }
    }

    // ========== DOCTOR MANAGEMENT ==========
    @RequestMapping(value = "/doctors", method = RequestMethod.GET)
    @Transactional(readOnly = true)
    public String doctors(Authentication auth, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        
        // Get directly registered doctors (where doctor.hospital.id == hospital.id)
        List<Doctor> directlyRegisteredDoctors = doctorService.getDoctorsByHospital(hospital.getId());
        
        // Get approved doctor associations
        List<DoctorHospitalAssociation> approvedAssociations = 
                associationService.getApprovedAssociationsByHospital(hospital.getId());
        
        // Get pending requests
        List<DoctorHospitalAssociation> pendingRequests = 
                associationService.getPendingRequestsByHospital(hospital.getId());
        
        // Create a set to track which doctors are already in associations (to avoid duplicates)
        Set<Long> associatedDoctorIds = new HashSet<>();
        for (DoctorHospitalAssociation assoc : approvedAssociations) {
            if (assoc.getDoctor() != null) {
                associatedDoctorIds.add(assoc.getDoctor().getId());
            }
        }
        
        // Combine all doctors: directly registered + associated (avoiding duplicates)
        List<Doctor> allDoctorsList = new ArrayList<>();
        
        // Add directly registered doctors that don't have associations
        for (Doctor doctor : directlyRegisteredDoctors) {
            if (!associatedDoctorIds.contains(doctor.getId())) {
                allDoctorsList.add(doctor);
            }
        }
        
        // Add doctors from associations
        for (DoctorHospitalAssociation association : approvedAssociations) {
            if (association.getDoctor() != null) {
                allDoctorsList.add(association.getDoctor());
            }
        }
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("allDoctors", allDoctorsList);
        model.addAttribute("approvedAssociations", approvedAssociations);
        model.addAttribute("directlyRegisteredDoctors", directlyRegisteredDoctors);
        model.addAttribute("pendingRequests", pendingRequests);
        return "dashboard/doctors";
    }

    // View pending doctor requests
    @RequestMapping(value = "/doctors/requests", method = RequestMethod.GET)
    public String doctorRequests(Authentication auth, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        List<DoctorHospitalAssociation> pendingRequests = 
                associationService.getPendingRequestsByHospital(hospital.getId());
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("pendingRequests", pendingRequests);
        return "dashboard/doctor-requests";
    }

    // View doctor request details
    @RequestMapping(value = "/doctors/requests/{id}", method = RequestMethod.GET)
    public String doctorRequestDetails(Authentication auth, @PathVariable Long id, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        DoctorHospitalAssociation association = associationService.getAssociationsByHospital(hospital.getId())
                .stream()
                .filter(a -> a.getId().equals(id))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Association not found"));
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("association", association);
        model.addAttribute("doctor", association.getDoctor());
        return "dashboard/doctor-request-details";
    }

    // Approve doctor request
    @PostMapping("/doctors/requests/{id}/approve")
    public String approveDoctorRequest(Authentication auth, @PathVariable Long id,
                                     @RequestParam(required = false) String designation,
                                     @RequestParam(required = false) String consultationDays,
                                     @RequestParam(required = false) String consultationTimings,
                                     @RequestParam(required = false) String availableLocations,
                                     @RequestParam(required = false) String hospitalNotes,
                                     RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        try {
            associationService.approveAssociation(id, designation, consultationDays, 
                                                 consultationTimings, availableLocations, hospitalNotes);
            redirectAttributes.addFlashAttribute("success", "Doctor association approved successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        
        return "redirect:/dashboard/doctors/requests";
    }

    // Reject doctor request
    @PostMapping("/doctors/requests/{id}/reject")
    public String rejectDoctorRequest(Authentication auth, @PathVariable Long id,
                                    @RequestParam String reason,
                                    RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        try {
            associationService.rejectAssociation(id, reason);
            redirectAttributes.addFlashAttribute("success", "Doctor request rejected");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        
        return "redirect:/dashboard/doctors/requests";
    }

    // Suspend doctor association
    @PostMapping("/doctors/{associationId}/suspend")
    public String suspendDoctorAssociation(Authentication auth, @PathVariable Long associationId,
                                          @RequestParam String reason,
                                          RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        try {
            associationService.suspendAssociation(associationId, reason);
            redirectAttributes.addFlashAttribute("success", "Doctor association suspended");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        
        return "redirect:/dashboard/doctors";
    }

    @RequestMapping(value = "/doctors/add", method = RequestMethod.GET)
    public String addDoctorForm(Authentication auth, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        model.addAttribute("hospital", hospital);
        model.addAttribute("doctor", new Doctor());
        return "dashboard/doctor-form";
    }

    @PostMapping("/doctors/add")
    public String addDoctor(Authentication auth, @ModelAttribute Doctor doctor,
                            @RequestParam(required = false) MultipartFile photoFile,
                            RedirectAttributes redirectAttributes,
                            HttpServletRequest request) {
        Hospital hospital = getCurrentHospital(auth);
        
        try {
            // Validate password length
            if (doctor.getPassword() != null && doctor.getPassword().length() < 6) {
                redirectAttributes.addFlashAttribute("error", "Password must be at least 6 characters");
                return "redirect:/dashboard/doctors/add";
            }
            
            Doctor savedDoctor = doctorService.createDoctor(hospital.getId(), doctor);
            
            if (photoFile != null && !photoFile.isEmpty()) {
                doctorService.uploadDoctorPhoto(savedDoctor.getId(), photoFile);
            }
            
            // Success message with login credentials
            String contextPath = request.getContextPath();
            String successMsg = "Doctor registered successfully! " +
                    "The doctor can now login using Email: <strong>" + savedDoctor.getEmail() + 
                    "</strong> and the password you set. " +
                    "Login URL: " + contextPath + "/doctor/login";
            redirectAttributes.addFlashAttribute("success", successMsg);
            redirectAttributes.addFlashAttribute("doctorEmail", savedDoctor.getEmail());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error adding doctor: " + e.getMessage());
            return "redirect:/dashboard/doctors/add";
        }
        
        return "redirect:/dashboard/doctors";
    }

    @RequestMapping(value = "/doctors/edit/{id}", method = RequestMethod.GET)
    public String editDoctorForm(Authentication auth, @PathVariable Long id, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        Doctor doctor = doctorService.findById(id)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        if (!doctor.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("doctor", doctor);
        return "dashboard/doctor-form";
    }

    @PostMapping("/doctors/edit/{id}")
    public String updateDoctor(Authentication auth, @PathVariable Long id,
                               @ModelAttribute Doctor doctor,
                               @RequestParam(required = false) MultipartFile photoFile,
                               RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        Doctor existingDoctor = doctorService.findById(id)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        if (!existingDoctor.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        try {
            doctorService.updateDoctor(id, doctor);
            
            if (photoFile != null && !photoFile.isEmpty()) {
                doctorService.uploadDoctorPhoto(id, photoFile);
            }
            
            redirectAttributes.addFlashAttribute("success", "Doctor updated successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating doctor: " + e.getMessage());
        }
        
        return "redirect:/dashboard/doctors";
    }

    @PostMapping("/doctors/delete/{id}")
    public String deleteDoctor(Authentication auth, @PathVariable Long id,
                               RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        Doctor doctor = doctorService.findById(id)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        if (!doctor.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        doctorService.deleteDoctor(id);
        redirectAttributes.addFlashAttribute("success", "Doctor removed successfully");
        return "redirect:/dashboard/doctors";
    }

    // ========== BOOKING MANAGEMENT ==========
    @RequestMapping(value = "/bookings", method = RequestMethod.GET)
    public String bookings(Authentication auth,
                           @RequestParam(defaultValue = "0") int page,
                           @RequestParam(required = false) String status,
                           Model model) {
        Hospital hospital = getCurrentHospital(auth);
        
        Page<Booking> bookingPage = bookingService.getBookingsByHospital(
                hospital.getId(),
                PageRequest.of(page, 10, Sort.by(Sort.Direction.DESC, "createdAt"))
        );
        
        Long pendingCount = bookingService.countPendingBookings(hospital.getId());
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("bookings", bookingPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", bookingPage.getTotalPages());
        model.addAttribute("pendingCount", pendingCount);
        model.addAttribute("bookingStatuses", BookingStatus.values());
        return "dashboard/bookings";
    }

    @RequestMapping(value = "/bookings/{id}", method = RequestMethod.GET)
    @Transactional(readOnly = true)
    public String bookingDetails(Authentication auth, @PathVariable Long id, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        
        Booking booking = bookingService.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        
        // Force loading of lazy relationships by accessing them
        if (booking.getHospital() != null) {
            booking.getHospital().getId(); // Force load hospital
        }
        if (booking.getTreatmentPackage() != null) {
            booking.getTreatmentPackage().getPackageName(); // Force load treatment package
        }
        if (booking.getUser() != null) {
            booking.getUser().getId(); // Force load user
        }
        
        if (!booking.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("booking", booking);
        return "dashboard/booking-details";
    }

    @PostMapping("/bookings/{id}/confirm")
    public String confirmBooking(Authentication auth, @PathVariable Long id,
                                 @RequestParam(required = false) String hospitalNotes,
                                 RedirectAttributes redirectAttributes) {
        try {
            Hospital hospital = getCurrentHospital(auth);
            
            Booking booking = bookingService.findById(id)
                    .orElseThrow(() -> new RuntimeException("Booking not found"));
            
            if (!booking.getHospital().getId().equals(hospital.getId())) {
                throw new RuntimeException("Unauthorized");
            }
            
            bookingService.confirmBooking(id, hospitalNotes);
            redirectAttributes.addFlashAttribute("success", "Booking confirmed successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error confirming booking: " + e.getMessage());
        }
        return "redirect:/dashboard/bookings";
    }

    @PostMapping("/bookings/{id}/reject")
    public String rejectBooking(Authentication auth, @PathVariable Long id,
                                @RequestParam String reason,
                                RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        Booking booking = bookingService.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        
        if (!booking.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        bookingService.rejectBooking(id, reason);
        redirectAttributes.addFlashAttribute("success", "Booking rejected");
        return "redirect:/dashboard/bookings";
    }

    // ========== PHOTO GALLERY ==========
    @RequestMapping(value = "/gallery", method = RequestMethod.GET)
    public String gallery(Authentication auth, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        List<HospitalPhoto> photos = photoService.getPhotosByHospital(hospital.getId());
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("photos", photos);
        model.addAttribute("categories", PhotoCategory.values());
        return "dashboard/gallery";
    }

    @PostMapping("/gallery/upload")
    public String uploadPhoto(Authentication auth,
                              @RequestParam MultipartFile photo,
                              @RequestParam(required = false) String title,
                              @RequestParam(required = false) String description,
                              @RequestParam(defaultValue = "OTHER") String category,
                              RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        try {
            photoService.uploadPhoto(hospital.getId(), photo, title, description, 
                    PhotoCategory.valueOf(category));
            redirectAttributes.addFlashAttribute("success", "Photo uploaded successfully");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Error uploading photo: " + e.getMessage());
        }
        
        return "redirect:/dashboard/gallery";
    }

    @PostMapping("/gallery/delete/{id}")
    public String deletePhoto(Authentication auth, @PathVariable Long id,
                              RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        HospitalPhoto photo = photoService.findById(id)
                .orElseThrow(() -> new RuntimeException("Photo not found"));
        
        if (!photo.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        try {
            photoService.deletePhoto(id);
            redirectAttributes.addFlashAttribute("success", "Photo deleted successfully");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting photo");
        }
        
        return "redirect:/dashboard/gallery";
    }

    @PostMapping("/gallery/cover/{id}")
    public String setCoverPhoto(Authentication auth, @PathVariable Long id,
                                RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        HospitalPhoto photo = photoService.findById(id)
                .orElseThrow(() -> new RuntimeException("Photo not found"));
        
        if (!photo.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        photoService.setCoverPhoto(id);
        redirectAttributes.addFlashAttribute("success", "Cover photo updated");
        return "redirect:/dashboard/gallery";
    }

    // ========== DOCUMENTS ==========
    @RequestMapping(value = "/documents", method = RequestMethod.GET)
    public String documents(Authentication auth, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        List<HospitalDocument> documents = documentService.getDocumentsByHospital(hospital.getId());
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("documents", documents);
        model.addAttribute("documentTypes", HospitalDocument.DocumentType.values());
        return "dashboard/documents";
    }

    @PostMapping("/documents/upload")
    public String uploadDocument(Authentication auth,
                                 @RequestParam MultipartFile document,
                                 @RequestParam String documentType,
                                 @RequestParam(required = false) String description,
                                 RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        try {
            documentService.uploadDocument(hospital.getId(), document,
                    HospitalDocument.DocumentType.valueOf(documentType), description);
            redirectAttributes.addFlashAttribute("success", "Document uploaded successfully");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Error uploading document: " + e.getMessage());
        }
        
        return "redirect:/dashboard/documents";
    }

    // ========== REVIEWS ==========
    @RequestMapping(value = "/reviews", method = RequestMethod.GET)
    public String reviews(Authentication auth, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        List<Review> reviews = reviewService.getReviewsByHospital(hospital.getId());
        Map<String, Object> ratingBreakdown = reviewService.getRatingBreakdown(hospital.getId());
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("reviews", reviews);
        model.addAttribute("ratingBreakdown", ratingBreakdown);
        return "dashboard/reviews";
    }

    @PostMapping("/reviews/{id}/respond")
    public String respondToReview(Authentication auth, @PathVariable Long id,
                                  @RequestParam String response,
                                  RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        Review review = reviewService.findById(id)
                .orElseThrow(() -> new RuntimeException("Review not found"));
        
        if (!review.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        reviewService.addHospitalResponse(id, response);
        redirectAttributes.addFlashAttribute("success", "Response added successfully");
        return "redirect:/dashboard/reviews";
    }

    // ========== ENQUIRIES ==========
    @RequestMapping(value = "/enquiries", method = RequestMethod.GET)
    @Transactional(readOnly = true)
    public String enquiries(Authentication auth, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        
        List<UserEnquiry> enquiries = enquiryRepository.findByHospitalId(hospital.getId());
        long pendingCount = enquiryRepository.countByHospitalIdAndStatus(hospital.getId(), 
                UserEnquiry.EnquiryStatus.PENDING);
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("enquiries", enquiries);
        model.addAttribute("pendingCount", pendingCount);
        return "dashboard/enquiries";
    }

    @RequestMapping(value = "/enquiries/{id}", method = RequestMethod.GET)
    @Transactional(readOnly = true)
    public String enquiryDetails(Authentication auth, @PathVariable Long id, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        
        UserEnquiry enquiry = enquiryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Enquiry not found"));
        
        if (!enquiry.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        model.addAttribute("hospital", hospital);
        model.addAttribute("enquiry", enquiry);
        return "dashboard/enquiry-details";
    }

    @PostMapping("/enquiries/{id}/reply")
    @Transactional
    public String replyToEnquiry(Authentication auth, @PathVariable Long id,
                                @RequestParam String hospitalReply,
                                @RequestParam(required = false) String quotation,
                                RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        UserEnquiry enquiry = enquiryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Enquiry not found"));
        
        if (!enquiry.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        enquiry.setHospitalReply(hospitalReply);
        if (quotation != null && !quotation.trim().isEmpty()) {
            enquiry.setQuotation(quotation);
            enquiry.setStatus(UserEnquiry.EnquiryStatus.QUOTATION_SENT);
        } else {
            enquiry.setStatus(UserEnquiry.EnquiryStatus.REPLIED);
        }
        enquiry.setRepliedAt(LocalDateTime.now());
        
        enquiryRepository.save(enquiry);
        redirectAttributes.addFlashAttribute("success", "Reply sent successfully");
        return "redirect:/dashboard/enquiries/" + id;
    }

    @PostMapping("/enquiries/{id}/close")
    @Transactional
    public String closeEnquiry(Authentication auth, @PathVariable Long id,
                              RedirectAttributes redirectAttributes) {
        Hospital hospital = getCurrentHospital(auth);
        
        UserEnquiry enquiry = enquiryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Enquiry not found"));
        
        if (!enquiry.getHospital().getId().equals(hospital.getId())) {
            throw new RuntimeException("Unauthorized");
        }
        
        enquiry.setStatus(UserEnquiry.EnquiryStatus.CLOSED);
        enquiry.setClosedAt(LocalDateTime.now());
        enquiryRepository.save(enquiry);
        
        redirectAttributes.addFlashAttribute("success", "Enquiry closed successfully");
        return "redirect:/dashboard/enquiries";
    }

    // ========== SETTINGS ==========
    @RequestMapping(value = "/settings", method = RequestMethod.GET)
    public String settings(Authentication auth, Model model) {
        Hospital hospital = getCurrentHospital(auth);
        model.addAttribute("hospital", hospital);
        return "dashboard/settings";
    }
}
