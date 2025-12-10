package com.ayurveda.controller;

import com.ayurveda.entity.Hospital;
import com.ayurveda.entity.User;
import com.ayurveda.service.HospitalService;
import com.ayurveda.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
@RequestMapping("/")
public class HomeController {

    private final HospitalService hospitalService;
    private final UserService userService;

    @Autowired
    public HomeController(HospitalService hospitalService, UserService userService) {
        this.hospitalService = hospitalService;
        this.userService = userService;
    }

    @RequestMapping(value = {"/", "/home"}, method = RequestMethod.GET)
    public String home(Authentication auth, Model model) {
        List<Hospital> featuredHospitals = hospitalService.getFeaturedHospitals();
        model.addAttribute("featuredHospitals", featuredHospitals);
        
        // Add user info if logged in
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            try {
                User user = userService.findByEmail(auth.getName()).orElse(null);
                if (user != null) {
                    model.addAttribute("currentUser", user);
                }
            } catch (Exception e) {
                // User not found or not a USER role - ignore
            }
        }
        
        return "home";
    }

    @RequestMapping(value = "/about", method = RequestMethod.GET)
    public String about(Authentication auth, Model model) {
        addUserToModel(auth, model);
        return "about";
    }

    @RequestMapping(value = "/services", method = RequestMethod.GET)
    public String services(Authentication auth, Model model) {
        addUserToModel(auth, model);
        return "services";
    }

    @RequestMapping(value = "/contact", method = RequestMethod.GET)
    public String contact(Authentication auth, Model model) {
        addUserToModel(auth, model);
        return "contact";
    }

    @RequestMapping(value = "/terms-and-conditions", method = RequestMethod.GET)
    public String termsAndConditions(Authentication auth, Model model) {
        addUserToModel(auth, model);
        return "terms-and-conditions";
    }

    @RequestMapping(value = "/privacy-policy", method = RequestMethod.GET)
    public String privacyPolicy(Authentication auth, Model model) {
        addUserToModel(auth, model);
        return "privacy-policy";
    }
    
    // Helper method to add user info to model
    private void addUserToModel(Authentication auth, Model model) {
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            try {
                User user = userService.findByEmail(auth.getName()).orElse(null);
                if (user != null) {
                    model.addAttribute("currentUser", user);
                }
            } catch (Exception e) {
                // User not found or not a USER role - ignore
            }
        }
    }

    @RequestMapping(value = "/access-denied", method = RequestMethod.GET)
    public String accessDenied() {
        return "error/access-denied";
    }
}
