package com.ayurveda.service;

import com.ayurveda.entity.Doctor;
import com.ayurveda.entity.Hospital;
import com.ayurveda.entity.TreatmentPackage;
import com.ayurveda.repository.DoctorRepository;
import com.ayurveda.repository.HospitalRepository;
import com.ayurveda.repository.TreatmentPackageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class PackageService {

    private final TreatmentPackageRepository packageRepository;
    private final HospitalRepository hospitalRepository;
    private final DoctorRepository doctorRepository;
    private final FileStorageService fileStorageService;

    @Autowired
    public PackageService(TreatmentPackageRepository packageRepository,
                         HospitalRepository hospitalRepository,
                         DoctorRepository doctorRepository,
                         FileStorageService fileStorageService) {
        this.packageRepository = packageRepository;
        this.hospitalRepository = hospitalRepository;
        this.doctorRepository = doctorRepository;
        this.fileStorageService = fileStorageService;
    }

    public List<TreatmentPackage> getPackagesByHospital(Long hospitalId) {
        return packageRepository.findByHospitalId(hospitalId);
    }

    public List<TreatmentPackage> getActivePackagesByHospital(Long hospitalId) {
        return packageRepository.findByHospitalIdAndIsActiveTrue(hospitalId);
    }

    public List<TreatmentPackage> getTop3Packages(Long hospitalId) {
        return packageRepository.findTop3ByHospitalIdAndIsActiveTrueOrderBySortOrderAsc(hospitalId);
    }

    public Optional<TreatmentPackage> findById(Long id) {
        return packageRepository.findById(id);
    }

    @Transactional
    public TreatmentPackage createPackage(Long hospitalId, TreatmentPackage pkg) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        pkg.setHospital(hospital);
        pkg.setIsActive(true);
        pkg.setIsFeatured(false);
        
        return packageRepository.save(pkg);
    }

    @Transactional
    public TreatmentPackage updatePackage(Long packageId, TreatmentPackage updateData) {
        TreatmentPackage pkg = packageRepository.findById(packageId)
                .orElseThrow(() -> new RuntimeException("Package not found"));
        
        if (updateData.getPackageName() != null) pkg.setPackageName(updateData.getPackageName());
        if (updateData.getPackageType() != null) pkg.setPackageType(updateData.getPackageType());
        if (updateData.getCustomType() != null) pkg.setCustomType(updateData.getCustomType());
        if (updateData.getDurationDays() != null) pkg.setDurationDays(updateData.getDurationDays());
        if (updateData.getDescription() != null) pkg.setDescription(updateData.getDescription());
        if (updateData.getShortDescription() != null) pkg.setShortDescription(updateData.getShortDescription());
        
        // Update room counts
        if (updateData.getBudgetRoomCount() != null) pkg.setBudgetRoomCount(updateData.getBudgetRoomCount());
        if (updateData.getStandardRoomCount() != null) pkg.setStandardRoomCount(updateData.getStandardRoomCount());
        if (updateData.getDeluxeRoomCount() != null) pkg.setDeluxeRoomCount(updateData.getDeluxeRoomCount());
        if (updateData.getSuiteRoomCount() != null) pkg.setSuiteRoomCount(updateData.getSuiteRoomCount());
        if (updateData.getVillaCount() != null) pkg.setVillaCount(updateData.getVillaCount());
        if (updateData.getVipRoomCount() != null) pkg.setVipRoomCount(updateData.getVipRoomCount());
        
        // Update prices
        if (updateData.getBudgetRoomPrice() != null) pkg.setBudgetRoomPrice(updateData.getBudgetRoomPrice());
        if (updateData.getStandardRoomPrice() != null) pkg.setStandardRoomPrice(updateData.getStandardRoomPrice());
        if (updateData.getDeluxeRoomPrice() != null) pkg.setDeluxeRoomPrice(updateData.getDeluxeRoomPrice());
        if (updateData.getSuiteRoomPrice() != null) pkg.setSuiteRoomPrice(updateData.getSuiteRoomPrice());
        if (updateData.getVillaPrice() != null) pkg.setVillaPrice(updateData.getVillaPrice());
        if (updateData.getVipRoomPrice() != null) pkg.setVipRoomPrice(updateData.getVipRoomPrice());
        
        // Update GST percents
        if (updateData.getBudgetRoomGstPercent() != null) pkg.setBudgetRoomGstPercent(updateData.getBudgetRoomGstPercent());
        if (updateData.getStandardRoomGstPercent() != null) pkg.setStandardRoomGstPercent(updateData.getStandardRoomGstPercent());
        if (updateData.getDeluxeRoomGstPercent() != null) pkg.setDeluxeRoomGstPercent(updateData.getDeluxeRoomGstPercent());
        if (updateData.getSuiteRoomGstPercent() != null) pkg.setSuiteRoomGstPercent(updateData.getSuiteRoomGstPercent());
        if (updateData.getVillaGstPercent() != null) pkg.setVillaGstPercent(updateData.getVillaGstPercent());
        if (updateData.getVipRoomGstPercent() != null) pkg.setVipRoomGstPercent(updateData.getVipRoomGstPercent());
        
        // Update CGST percents
        if (updateData.getBudgetRoomCgstPercent() != null) pkg.setBudgetRoomCgstPercent(updateData.getBudgetRoomCgstPercent());
        if (updateData.getStandardRoomCgstPercent() != null) pkg.setStandardRoomCgstPercent(updateData.getStandardRoomCgstPercent());
        if (updateData.getDeluxeRoomCgstPercent() != null) pkg.setDeluxeRoomCgstPercent(updateData.getDeluxeRoomCgstPercent());
        if (updateData.getSuiteRoomCgstPercent() != null) pkg.setSuiteRoomCgstPercent(updateData.getSuiteRoomCgstPercent());
        if (updateData.getVillaCgstPercent() != null) pkg.setVillaCgstPercent(updateData.getVillaCgstPercent());
        if (updateData.getVipRoomCgstPercent() != null) pkg.setVipRoomCgstPercent(updateData.getVipRoomCgstPercent());
        
        if (updateData.getInclusions() != null) pkg.setInclusions(updateData.getInclusions());
        if (updateData.getExclusions() != null) pkg.setExclusions(updateData.getExclusions());
        if (updateData.getExpectedResults() != null) pkg.setExpectedResults(updateData.getExpectedResults());
        if (updateData.getSuitableFor() != null) pkg.setSuitableFor(updateData.getSuitableFor());
        if (updateData.getDayWiseSchedule() != null) pkg.setDayWiseSchedule(updateData.getDayWiseSchedule());
        
        if (updateData.getIsActive() != null) pkg.setIsActive(updateData.getIsActive());
        if (updateData.getIsFeatured() != null) pkg.setIsFeatured(updateData.getIsFeatured());
        if (updateData.getSortOrder() != null) pkg.setSortOrder(updateData.getSortOrder());
        
        return packageRepository.save(pkg);
    }
    
    @Transactional
    public void associateDoctors(Long packageId, List<Long> doctorIds) {
        TreatmentPackage pkg = packageRepository.findById(packageId)
                .orElseThrow(() -> new RuntimeException("Package not found"));
        
        List<Doctor> doctors = doctorRepository.findAllById(doctorIds);
        pkg.setDoctors(doctors);
        packageRepository.save(pkg);
    }
    
    @Transactional
    public void updateDoctorAssociations(Long packageId, List<Long> doctorIds) {
        TreatmentPackage pkg = packageRepository.findById(packageId)
                .orElseThrow(() -> new RuntimeException("Package not found"));
        
        if (doctorIds == null || doctorIds.isEmpty()) {
            pkg.setDoctors(new ArrayList<>());
        } else {
            List<Doctor> doctors = doctorRepository.findAllById(doctorIds);
            pkg.setDoctors(doctors);
        }
        packageRepository.save(pkg);
    }

    @Transactional
    public void deletePackage(Long packageId) {
        packageRepository.deleteById(packageId);
    }

    @Transactional
    public void togglePackageStatus(Long packageId) {
        TreatmentPackage pkg = packageRepository.findById(packageId)
                .orElseThrow(() -> new RuntimeException("Package not found"));
        pkg.setIsActive(!pkg.getIsActive());
        packageRepository.save(pkg);
    }

    @Transactional
    public TreatmentPackage uploadPackageImage(Long packageId, MultipartFile file) throws IOException {
        TreatmentPackage pkg = packageRepository.findById(packageId)
                .orElseThrow(() -> new RuntimeException("Package not found"));
        
        String fileName = fileStorageService.storeFile(file, "packages");
        pkg.setImageUrl("/uploads/packages/" + fileName);
        
        return packageRepository.save(pkg);
    }
}
