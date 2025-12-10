package com.ayurveda.security;

import com.ayurveda.entity.User;
import com.ayurveda.repository.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class CustomAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

    @Autowired
    private UserRepository userRepository;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        
        // Get the logged in user's email
        String email = authentication.getName();
        
        // Find user and set userId in session
        userRepository.findByEmail(email).ifPresent(user -> {
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getId());
            session.setAttribute("currentUser", user);
        });
        
        // Set default target URL - redirect to home page
        setDefaultTargetUrl("/");
        
        // Call parent to handle redirect
        super.onAuthenticationSuccess(request, response, authentication);
    }
}

