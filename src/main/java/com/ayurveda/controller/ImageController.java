package com.ayurveda.controller;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
@RequestMapping("/images")
public class ImageController {

    private final ServletContext servletContext;

    public ImageController(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    @GetMapping("/**")
    public ResponseEntity<Resource> getImage(HttpServletRequest request) {
        try {
            // Get the image path from request URI
            String requestURI = request.getRequestURI();
            String imagePath = requestURI.substring(requestURI.indexOf("/images/") + "/images/".length());
            
            // Get real path to WEB-INF/views/images/
            String realPath = servletContext.getRealPath("/WEB-INF/views/images/" + imagePath);
            
            if (realPath == null) {
                return ResponseEntity.notFound().build();
            }
            
            Path path = Paths.get(realPath);
            File file = path.toFile();
            
            if (!file.exists() || !file.isFile()) {
                return ResponseEntity.notFound().build();
            }
            
            Resource resource = new FileSystemResource(file);
            
            // Determine content type
            String contentType = servletContext.getMimeType(realPath);
            if (contentType == null) {
                contentType = "application/octet-stream";
            }
            
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(contentType))
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + file.getName() + "\"")
                    .body(resource);
                    
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }
}

