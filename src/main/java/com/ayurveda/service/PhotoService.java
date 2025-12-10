package com.ayurveda.service;

import com.ayurveda.entity.Hospital;
import com.ayurveda.entity.HospitalPhoto;
import com.ayurveda.entity.HospitalPhoto.PhotoCategory;
import com.ayurveda.repository.HospitalPhotoRepository;
import com.ayurveda.repository.HospitalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Service
public class PhotoService {

    private final HospitalPhotoRepository photoRepository;
    private final HospitalRepository hospitalRepository;
    private final FileStorageService fileStorageService;

    @Autowired
    public PhotoService(HospitalPhotoRepository photoRepository,
                       HospitalRepository hospitalRepository,
                       FileStorageService fileStorageService) {
        this.photoRepository = photoRepository;
        this.hospitalRepository = hospitalRepository;
        this.fileStorageService = fileStorageService;
    }

    public List<HospitalPhoto> getPhotosByHospital(Long hospitalId) {
        return photoRepository.findByHospitalIdOrderBySortOrderAsc(hospitalId);
    }

    public List<HospitalPhoto> getActivePhotos(Long hospitalId) {
        return photoRepository.findByHospitalIdAndIsActiveTrueOrderBySortOrderAsc(hospitalId);
    }

    public List<HospitalPhoto> getPhotosByCategory(Long hospitalId, PhotoCategory category) {
        return photoRepository.findByHospitalIdAndCategory(hospitalId, category);
    }

    public Optional<HospitalPhoto> findById(Long id) {
        return photoRepository.findById(id);
    }

    @Transactional
    public HospitalPhoto uploadPhoto(Long hospitalId, MultipartFile file, String title, 
                                      String description, PhotoCategory category) throws IOException {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        String fileName = fileStorageService.storeFile(file, "gallery");
        
        HospitalPhoto photo = new HospitalPhoto();
        photo.setHospital(hospital);
        photo.setPhotoUrl("/uploads/gallery/" + fileName);
        photo.setTitle(title);
        photo.setDescription(description);
        photo.setCategory(category);
        photo.setIsActive(true);
        photo.setIsCoverPhoto(false);
        
        return photoRepository.save(photo);
    }

    @Transactional
    public void deletePhoto(Long photoId) throws IOException {
        HospitalPhoto photo = photoRepository.findById(photoId)
                .orElseThrow(() -> new RuntimeException("Photo not found"));
        
        // Delete file from storage
        fileStorageService.deleteFile(photo.getPhotoUrl());
        
        photoRepository.delete(photo);
    }

    @Transactional
    public void setCoverPhoto(Long photoId) {
        HospitalPhoto photo = photoRepository.findById(photoId)
                .orElseThrow(() -> new RuntimeException("Photo not found"));
        
        Long hospitalId = photo.getHospital().getId();
        
        // Reset existing cover photo
        photoRepository.resetCoverPhoto(hospitalId);
        
        // Set new cover photo
        photo.setIsCoverPhoto(true);
        photoRepository.save(photo);
        
        // Update hospital cover photo URL
        Hospital hospital = hospitalRepository.findById(hospitalId).orElseThrow();
        hospital.setCoverPhotoUrl(photo.getPhotoUrl());
        hospitalRepository.save(hospital);
    }

    @Transactional
    public void updatePhotoOrder(Long photoId, Integer sortOrder) {
        HospitalPhoto photo = photoRepository.findById(photoId)
                .orElseThrow(() -> new RuntimeException("Photo not found"));
        photo.setSortOrder(sortOrder);
        photoRepository.save(photo);
    }
}
