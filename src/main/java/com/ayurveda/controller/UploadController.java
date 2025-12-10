package com.ayurveda.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
@RequestMapping("/uploads")
public class UploadController {

    private final ServletContext servletContext;
    
    @Value("${file.upload-dir:uploads}")
    private String uploadDir;

    public UploadController(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    @RequestMapping(value = "/**", method = RequestMethod.GET)
    public ResponseEntity<Resource> getUploadedFile(HttpServletRequest request) {
        try {
            // Get the file path from request URI
            String requestURI = request.getRequestURI();
            
            // Handle context path - remove it if present
            String contextPath = request.getContextPath();
            if (contextPath != null && !contextPath.isEmpty() && requestURI.startsWith(contextPath)) {
                requestURI = requestURI.substring(contextPath.length());
            }
            
            // Extract file path
            int uploadsIndex = requestURI.indexOf("/uploads/");
            if (uploadsIndex == -1) {
                return ResponseEntity.notFound().build();
            }
            
            String filePath = requestURI.substring(uploadsIndex + "/uploads/".length());
            if (filePath == null || filePath.isEmpty()) {
                return ResponseEntity.notFound().build();
            }
            
            // URL decode the file path to handle special characters
            try {
                filePath = java.net.URLDecoder.decode(filePath, "UTF-8");
            } catch (Exception e) {
                // If decoding fails, use original path
            }
            
            // Security: Prevent directory traversal attacks
            if (filePath.contains("..") || filePath.contains("\\")) {
                return ResponseEntity.status(403).build();
            }
            
            File file = null;
            
            // Get upload path (handles Tomcat external directory)
            Path uploadPath = getUploadPath();
            Path targetPath = uploadPath.resolve(filePath);
            File uploadFile = targetPath.toFile();
            
            if (uploadFile.exists() && uploadFile.isFile()) {
                file = uploadFile;
            }
            
            // Try relative path from project root (development fallback)
            if (file == null) {
                String projectRoot = System.getProperty("user.dir");
                Path relativePath = Paths.get(projectRoot, "uploads", filePath);
                File relativeFile = relativePath.toFile();
                if (relativeFile.exists() && relativeFile.isFile()) {
                    file = relativeFile;
                }
            }
            
            // Try servlet context path (if uploads are in webapp)
            if (file == null) {
                String realPath = servletContext.getRealPath("/uploads/" + filePath);
                if (realPath != null) {
                    File contextFile = new File(realPath);
                    if (contextFile.exists() && contextFile.isFile()) {
                        file = contextFile;
                    }
                }
            }
            
            // Try absolute path from uploadDir config
            if (file == null && Paths.get(uploadDir).isAbsolute()) {
                Path absolutePath = Paths.get(uploadDir, filePath);
                File absoluteFile = absolutePath.toFile();
                if (absoluteFile.exists() && absoluteFile.isFile()) {
                    file = absoluteFile;
                }
            }
            
            if (file == null || !file.exists() || !file.isFile()) {
                return ResponseEntity.notFound().build();
            }
            
            Resource resource = new FileSystemResource(file);
            
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(getContentType(filePath)))
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + file.getName() + "\"")
                    .header(HttpHeaders.CACHE_CONTROL, "public, max-age=3600")
                    .body(resource);
                    
        } catch (Exception e) {
            e.printStackTrace(); // Log for debugging
            return ResponseEntity.notFound().build();
        }
    }
    
    private String getContentType(String filePath) {
        String fileName = filePath.toLowerCase();
        if (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")) {
            return "image/jpeg";
        } else if (fileName.endsWith(".png")) {
            return "image/png";
        } else if (fileName.endsWith(".gif")) {
            return "image/gif";
        } else if (fileName.endsWith(".webp")) {
            return "image/webp";
        } else if (fileName.endsWith(".pdf")) {
            return "application/pdf";
        } else {
            return "application/octet-stream";
        }
    }
    
    private Path getUploadPath() {
        // Get upload directory - prefer external location for Tomcat
        if (Paths.get(uploadDir).isAbsolute()) {
            return Paths.get(uploadDir);
        } else {
            String catalinaBase = System.getProperty("catalina.base");
            if (catalinaBase != null && !catalinaBase.isEmpty()) {
                // Running in Tomcat - use external directory (outside WAR)
                return Paths.get(catalinaBase, "uploads");
            } else {
                // Development or embedded server
                String projectRoot = System.getProperty("user.dir");
                return Paths.get(projectRoot, uploadDir);
            }
        }
    }
}

