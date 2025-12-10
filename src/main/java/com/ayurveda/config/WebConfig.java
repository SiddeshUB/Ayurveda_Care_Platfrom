package com.ayurveda.config;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private ServletContext servletContext;

    @Value("${file.upload-dir:uploads}")
    private String uploadDir;

    private String staticImagesPath;
    private String uploadAbsolutePath;

    @PostConstruct
    public void init() {
        // Get static images path from ServletContext (works in both dev and Tomcat)
        String webInfPath = servletContext.getRealPath("/WEB-INF/views/images");
        if (webInfPath != null) {
            staticImagesPath = "file:" + webInfPath.replace("\\", "/") + "/";
        } else {
            // Fallback for development or when getRealPath returns null
            String projectRoot = System.getProperty("user.dir");
            Path staticPath = Paths.get(projectRoot, "src", "main", "webapp", "WEB-INF", "views", "images");
            staticImagesPath = "file:" + staticPath.toAbsolutePath().toString().replace("\\", "/") + "/";
        }

        // Get upload directory - prefer external location for Tomcat
        // Check if uploadDir is absolute or relative
        Path uploadPath;
        if (Paths.get(uploadDir).isAbsolute()) {
            uploadPath = Paths.get(uploadDir);
        } else {
            // Try to use external directory (outside WAR) for Tomcat
            String catalinaBase = System.getProperty("catalina.base");
            if (catalinaBase != null && !catalinaBase.isEmpty()) {
                // Running in Tomcat - use external directory
                uploadPath = Paths.get(catalinaBase, "uploads");
            } else {
                // Development or embedded server
                String projectRoot = System.getProperty("user.dir");
                uploadPath = Paths.get(projectRoot, uploadDir);
            }
        }
        
        // Ensure upload directory exists
        try {
            java.nio.file.Files.createDirectories(uploadPath);
        } catch (Exception e) {
            // If external fails, use relative path
            uploadPath = Paths.get(uploadDir).toAbsolutePath();
        }
        
        uploadAbsolutePath = "file:" + uploadPath.toAbsolutePath().toString().replace("\\", "/") + "/";
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Serve static CSS, JS from webapp folder
        String cssPath = servletContext.getRealPath("/css");
        String jsPath = servletContext.getRealPath("/js");
        
        if (cssPath != null) {
            registry.addResourceHandler("/css/**")
                    .addResourceLocations("file:" + cssPath.replace("\\", "/") + "/", "classpath:/static/css/", "/css/");
        } else {
            registry.addResourceHandler("/css/**")
                    .addResourceLocations("classpath:/static/css/", "/css/");
        }
        
        if (jsPath != null) {
            registry.addResourceHandler("/js/**")
                    .addResourceLocations("file:" + jsPath.replace("\\", "/") + "/", "classpath:/static/js/", "/js/");
        } else {
            registry.addResourceHandler("/js/**")
                    .addResourceLocations("classpath:/static/js/", "/js/");
        }
        
        // Serve static images - use ServletContext path (works in Tomcat)
        registry.addResourceHandler("/images/**")
                .addResourceLocations(
                    staticImagesPath != null ? staticImagesPath : "",
                    "classpath:/WEB-INF/views/images/",
                    "classpath:/static/images/",
                    "/WEB-INF/views/images/",
                    "/images/"
                )
                .setCachePeriod(3600);
        
        // Serve uploaded files - use external directory for Tomcat
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations(uploadAbsolutePath)
                .setCachePeriod(3600);
        
        // Also serve from classpath if needed
        registry.addResourceHandler("/webjars/**")
                .addResourceLocations("classpath:/META-INF/resources/webjars/");
    }
}
