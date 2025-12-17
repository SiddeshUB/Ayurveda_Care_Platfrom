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
            
            // Priority 1: Try project root first (for development/embedded Tomcat)
            // Files are typically saved here in embedded mode
            String projectRoot = System.getProperty("user.dir");
            if (projectRoot != null) {
                Path projectUploadPath = Paths.get(projectRoot, "uploads", filePath);
                File projectFile = projectUploadPath.toFile();
                System.err.println("UploadController: Checking project root - " + projectUploadPath);
                if (projectFile.exists() && projectFile.isFile()) {
                    System.err.println("UploadController: Found file in project root!");
                    file = projectFile;
                } else {
                    System.err.println("UploadController: File not found in project root");
                }
            }
            
            // Priority 2: Try the configured upload path (handles Tomcat external directory)
            if (file == null) {
                Path uploadPath = getUploadPath();
                Path targetPath = uploadPath.resolve(filePath);
                File uploadFile = targetPath.toFile();
                if (uploadFile.exists() && uploadFile.isFile()) {
                    file = uploadFile;
                }
            }
            
            // Priority 3: Try relative path from project root (additional fallback)
            if (file == null && projectRoot != null) {
                Path relativePath = Paths.get(projectRoot, uploadDir, filePath);
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
            
            // Additional fallback: Try with normalized path separators
            if (file == null) {
                // Normalize path separators (handle both / and \)
                String normalizedPath = filePath.replace("\\", "/");
                Path uploadPathForNormalized = getUploadPath();
                Path normalizedTargetPath = uploadPathForNormalized.resolve(normalizedPath);
                File normalizedFile = normalizedTargetPath.toFile();
                if (normalizedFile.exists() && normalizedFile.isFile()) {
                    file = normalizedFile;
                }
            }
            
            // Final fallback: Check temp directory (for existing files uploaded before fix)
            // Also search all tomcat temp directories since files might be in old ones
            if (file == null) {
                String catalinaBase = System.getProperty("catalina.base");
                if (catalinaBase != null && !catalinaBase.isEmpty()) {
                    // First check current temp directory
                    Path tempUploadPath = Paths.get(catalinaBase, "uploads", filePath);
                    File tempFile = tempUploadPath.toFile();
                    System.err.println("UploadController: Checking current temp directory - " + tempUploadPath);
                    if (tempFile.exists() && tempFile.isFile()) {
                        System.err.println("UploadController: Found file in current temp directory");
                        file = tempFile;
                    } else {
                        // Search all tomcat temp directories for legacy files
                        try {
                            Path tempBase = Paths.get(System.getProperty("java.io.tmpdir"));
                            if (tempBase != null && java.nio.file.Files.exists(tempBase)) {
                                System.err.println("UploadController: Searching all tomcat temp directories in: " + tempBase);
                                java.nio.file.DirectoryStream<Path> dirs = java.nio.file.Files.newDirectoryStream(tempBase, "tomcat*");
                                for (Path tomcatDir : dirs) {
                                    Path legacyUploadPath = tomcatDir.resolve("uploads").resolve(filePath);
                                    File legacyFile = legacyUploadPath.toFile();
                                    if (legacyFile.exists() && legacyFile.isFile()) {
                                        System.err.println("UploadController: Found file in legacy temp directory: " + legacyUploadPath);
                                        file = legacyFile;
                                        break;
                                    }
                                }
                                dirs.close();
                            }
                        } catch (Exception e) {
                            // Ignore errors when searching temp directories
                            System.err.println("UploadController: Error searching temp directories: " + e.getMessage());
                        }
                    }
                }
            }
            
            if (file == null || !file.exists() || !file.isFile()) {
                // Log for debugging (can be removed in production)
                Path uploadPathForLogging = getUploadPath();
                System.err.println("UploadController: File not found - " + filePath);
                System.err.println("UploadController: Searched in - " + uploadPathForLogging.resolve(filePath));
                System.err.println("UploadController: Upload root path - " + uploadPathForLogging);
                System.err.println("UploadController: Project root - " + System.getProperty("user.dir"));
                System.err.println("UploadController: Catalina base - " + System.getProperty("catalina.base"));
                System.err.println("UploadController: Upload dir config - " + uploadDir);
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
            return ResponseEntity.status(500).build();
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
            // Check if we're in embedded Tomcat (temp directory) vs external Tomcat
            // Embedded Tomcat uses temp dirs, external Tomcat uses actual catalina.base
            boolean isEmbeddedTomcat = catalinaBase != null && 
                                       (catalinaBase.contains("Temp") || catalinaBase.contains("tomcat"));
            
            if (catalinaBase != null && !catalinaBase.isEmpty() && !isEmbeddedTomcat) {
                // Running in external Tomcat - use external directory (outside WAR)
                return Paths.get(catalinaBase, "uploads");
            } else {
                // Development or embedded server - use project root
                String projectRoot = System.getProperty("user.dir");
                return Paths.get(projectRoot, uploadDir);
            }
        }
    }
}

