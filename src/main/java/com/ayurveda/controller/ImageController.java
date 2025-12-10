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
@RequestMapping("/images")
public class ImageController {

    private final ServletContext servletContext;
    
    @Value("${file.upload-dir:uploads}")
    private String uploadDir;

    public ImageController(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    @RequestMapping(value = "/**", method = RequestMethod.GET)
    public ResponseEntity<Resource> getImage(HttpServletRequest request) {
        try {
            // Get the image path from request URI
            String requestURI = request.getRequestURI();
            
            // Handle context path - remove it if present
            String contextPath = request.getContextPath();
            if (contextPath != null && !contextPath.isEmpty() && requestURI.startsWith(contextPath)) {
                requestURI = requestURI.substring(contextPath.length());
            }
            
            // Extract image path
            int imagesIndex = requestURI.indexOf("/images/");
            if (imagesIndex == -1) {
                return ResponseEntity.notFound().build();
            }
            
            String imagePath = requestURI.substring(imagesIndex + "/images/".length());
            if (imagePath == null || imagePath.isEmpty()) {
                return ResponseEntity.notFound().build();
            }
            
            // URL decode the image path to handle special characters
            try {
                imagePath = java.net.URLDecoder.decode(imagePath, "UTF-8");
            } catch (Exception e) {
                // If decoding fails, use original path
            }
            
            // Security: Prevent directory traversal attacks
            if (imagePath.contains("..") || imagePath.contains("\\")) {
                return ResponseEntity.status(403).build();
            }
            
            File imageFile = null;
            
            // 1. Try WEB-INF/views/images/ using ServletContext (works in Tomcat)
            String webInfPath = servletContext.getRealPath("/WEB-INF/views/images/" + imagePath);
            if (webInfPath != null) {
                File webInfFile = new File(webInfPath);
                if (webInfFile.exists() && webInfFile.isFile()) {
                    imageFile = webInfFile;
                }
            }
            
            // 2. Try classpath resource (for packaged WAR)
            if (imageFile == null) {
                try {
                    org.springframework.core.io.ClassPathResource classPathResource = 
                        new org.springframework.core.io.ClassPathResource("/WEB-INF/views/images/" + imagePath);
                    if (classPathResource.exists()) {
                        // For classpath resources in JAR/WAR, we need to read as stream
                        // But for file system access, try to get file
                        try {
                            imageFile = classPathResource.getFile();
                        } catch (Exception e) {
                            // If it's in a JAR, we can't get File directly
                            // Return the resource directly (Spring will handle InputStream)
                            return ResponseEntity.ok()
                                    .contentType(MediaType.parseMediaType(getContentType(imagePath)))
                                    .header(HttpHeaders.CACHE_CONTROL, "public, max-age=3600")
                                    .body(classPathResource);
                        }
                    }
                } catch (Exception e) {
                    // Classpath resource not found, continue
                }
            }
            
            // 3. Try project root src/main/webapp/WEB-INF/views/images/ (development)
            if (imageFile == null) {
                String projectRoot = System.getProperty("user.dir");
                if (projectRoot != null) {
                    Path staticPath = Paths.get(projectRoot, "src", "main", "webapp", "WEB-INF", "views", "images", imagePath);
                    File staticFile = staticPath.toFile();
                    if (staticFile.exists() && staticFile.isFile()) {
                        imageFile = staticFile;
                    }
                }
            }
            
            // 4. Try uploads directory (in case image is in uploads but accessed via /images/)
            if (imageFile == null) {
                try {
                    Path uploadPath = getUploadPath();
                    Path imageFilePath = uploadPath.resolve(imagePath);
                    File uploadFile = imageFilePath.toFile();
                    if (uploadFile.exists() && uploadFile.isFile()) {
                        imageFile = uploadFile;
                    }
                } catch (Exception e) {
                    // Upload path error, continue
                }
            }
            
            if (imageFile == null || !imageFile.exists() || !imageFile.isFile()) {
                return ResponseEntity.notFound().build();
            }
            
            Resource resource = new FileSystemResource(imageFile);
            
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(getContentType(imagePath)))
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + imageFile.getName() + "\"")
                    .header(HttpHeaders.CACHE_CONTROL, "public, max-age=3600")
                    .body(resource);
                    
        } catch (Exception e) {
            e.printStackTrace(); // Log for debugging
            return ResponseEntity.status(500).build();
        }
    }
    
    private String getContentType(String imagePath) {
        String fileName = imagePath.toLowerCase();
        if (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")) {
            return "image/jpeg";
        } else if (fileName.endsWith(".png")) {
            return "image/png";
        } else if (fileName.endsWith(".gif")) {
            return "image/gif";
        } else if (fileName.endsWith(".webp")) {
            return "image/webp";
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
                // Running in Tomcat - use external directory
                return Paths.get(catalinaBase, "uploads");
            } else {
                // Development or embedded server
                String projectRoot = System.getProperty("user.dir");
                return Paths.get(projectRoot, uploadDir);
            }
        }
    }
}

