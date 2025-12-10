package com.ayurveda.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.annotation.PostConstruct;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@Service
public class FileStorageService {

    @Value("${file.upload-dir:uploads}")
    private String uploadDir;

    private Path rootLocation;

    @PostConstruct
    public void init() {
        rootLocation = Paths.get(uploadDir);
        try {
            Files.createDirectories(rootLocation);
        } catch (IOException e) {
            throw new RuntimeException("Could not initialize storage location", e);
        }
    }

    public String storeFile(MultipartFile file, String subfolder) throws IOException {
        if (file.isEmpty()) {
            throw new RuntimeException("Failed to store empty file");
        }
        
        // Create subfolder if it doesn't exist
        Path subfolderPath = rootLocation.resolve(subfolder);
        Files.createDirectories(subfolderPath);
        
        // Generate unique filename
        String originalFilename = file.getOriginalFilename();
        String extension = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String newFilename = UUID.randomUUID().toString() + extension;
        
        // Store file
        Path destinationFile = subfolderPath.resolve(newFilename);
        Files.copy(file.getInputStream(), destinationFile, StandardCopyOption.REPLACE_EXISTING);
        
        return newFilename;
    }

    public Path loadFile(String filename, String subfolder) {
        return rootLocation.resolve(subfolder).resolve(filename);
    }

    public void deleteFile(String filePath) throws IOException {
        if (filePath != null && !filePath.isEmpty()) {
            String filename = filePath.substring(filePath.lastIndexOf("/") + 1);
            String subfolder = "";
            
            if (filePath.contains("/gallery/")) {
                subfolder = "gallery";
            } else if (filePath.contains("/documents/")) {
                subfolder = "documents";
            } else if (filePath.contains("/doctors/")) {
                subfolder = "doctors";
            } else if (filePath.contains("/packages/")) {
                subfolder = "packages";
            }
            
            Path file = rootLocation.resolve(subfolder).resolve(filename);
            Files.deleteIfExists(file);
        }
    }

    public boolean fileExists(String filename, String subfolder) {
        Path file = rootLocation.resolve(subfolder).resolve(filename);
        return Files.exists(file);
    }
}
