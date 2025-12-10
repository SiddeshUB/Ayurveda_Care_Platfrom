package com.ayurveda.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.nio.file.Path;
import java.nio.file.Paths;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Value("${file.upload-dir:uploads}")
    private String uploadDir;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Serve static CSS, JS, images from webapp folder
        registry.addResourceHandler("/css/**")
                .addResourceLocations("/css/");
        
        
        
        registry.addResourceHandler("/js/**")
                .addResourceLocations("/js/");
        
        // Serve images from public /images/ folder (works in both embedded and external Tomcat)
        // Images are copied to /images/ during build for WAR deployment compatibility
        registry.addResourceHandler("/images/**")
                .addResourceLocations("/images/", "classpath:/META-INF/resources/images/")
                .resourceChain(true); // Enable resource chain for better performance
        
        // Serve uploaded files - use absolute path
        Path uploadPath = Paths.get(uploadDir).toAbsolutePath();
        String uploadAbsolutePath = uploadPath.toUri().toString();
        
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations(uploadAbsolutePath);
        
        
    }
}
