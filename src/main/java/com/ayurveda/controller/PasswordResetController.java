package com.ayurveda.controller;

import com.ayurveda.service.*;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;

import java.io.UnsupportedEncodingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/")
public class PasswordResetController {

    @Autowired
    private UserService userService;

    @Autowired
    private DoctorService doctorService;

    @Autowired
    private VendorService vendorService;

    @Autowired
    private EmailService emailService;

    // ==================== User Password Reset ====================

    @GetMapping("/user/forgot-password")
    public String userForgotPasswordPage() {
        return "user/forgot-password";
    }

    @PostMapping("/user/forgot-password")
    public String userForgotPassword(@RequestParam String email,
                                    @RequestParam String phone,
                                    HttpServletRequest request,
                                    RedirectAttributes redirectAttributes) throws UnsupportedEncodingException {
        try {
            userService.generatePasswordResetToken(email, phone);
            // Get the user to send email
            var userOpt = userService.findByEmail(email);
            if (userOpt.isPresent()) {
                var user = userOpt.get();
                String baseUrl = getBaseUrl(request);
                emailService.sendPasswordResetEmail(user.getEmail(), user.getPasswordResetToken(), "user", baseUrl);
                redirectAttributes.addFlashAttribute("success", "Password reset link has been sent to your email. Please check your inbox.");
            }
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/user/forgot-password";
        } catch (MessagingException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to send email. Please try again later.");
            return "redirect:/user/forgot-password";
        }
        return "redirect:/user/login";
    }

    @GetMapping("/user/reset-password")
    public String userResetPasswordPage(@RequestParam(required = false) String token, Model model) {
        if (token == null || token.isEmpty()) {
            model.addAttribute("error", "Invalid reset link");
            return "user/reset-password";
        }
        var userOpt = userService.findByPasswordResetToken(token);
        if (userOpt.isEmpty()) {
            model.addAttribute("error", "Invalid or expired reset token");
        } else {
            model.addAttribute("token", token);
        }
        return "user/reset-password";
    }

    @PostMapping("/user/reset-password")
    public String userResetPassword(@RequestParam String token,
                                   @RequestParam String newPassword,
                                   @RequestParam String confirmPassword,
                                   RedirectAttributes redirectAttributes) {
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Passwords do not match");
            return "redirect:/user/reset-password?token=" + token;
        }
        if (newPassword.length() < 6) {
            redirectAttributes.addFlashAttribute("error", "Password must be at least 6 characters long");
            return "redirect:/user/reset-password?token=" + token;
        }
        try {
            userService.resetPassword(token, newPassword);
            redirectAttributes.addFlashAttribute("success", "Password has been reset successfully. Please login with your new password.");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/user/reset-password?token=" + token;
        }
        return "redirect:/user/login";
    }

    // ==================== Doctor Password Reset ====================

    @GetMapping("/doctor/forgot-password")
    public String doctorForgotPasswordPage() {
        return "doctor/forgot-password";
    }

    @PostMapping("/doctor/forgot-password")
    public String doctorForgotPassword(@RequestParam String email,
                                      @RequestParam String phone,
                                      HttpServletRequest request,
                                      RedirectAttributes redirectAttributes) throws UnsupportedEncodingException {
        try {
            doctorService.generatePasswordResetToken(email, phone);
            var doctorOpt = doctorService.findByEmail(email);
            if (doctorOpt.isPresent()) {
                var doctor = doctorOpt.get();
                String baseUrl = getBaseUrl(request);
                emailService.sendPasswordResetEmail(doctor.getEmail(), doctor.getPasswordResetToken(), "doctor", baseUrl);
                redirectAttributes.addFlashAttribute("success", "Password reset link has been sent to your email. Please check your inbox.");
            }
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/doctor/forgot-password";
        } catch (MessagingException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to send email. Please try again later.");
            return "redirect:/doctor/forgot-password";
        }
        return "redirect:/doctor/login";
    }

    @GetMapping("/doctor/reset-password")
    public String doctorResetPasswordPage(@RequestParam(required = false) String token, Model model) {
        if (token == null || token.isEmpty()) {
            model.addAttribute("error", "Invalid reset link");
            return "doctor/reset-password";
        }
        var doctorOpt = doctorService.findByPasswordResetToken(token);
        if (doctorOpt.isEmpty()) {
            model.addAttribute("error", "Invalid or expired reset token");
        } else {
            model.addAttribute("token", token);
        }
        return "doctor/reset-password";
    }

    @PostMapping("/doctor/reset-password")
    public String doctorResetPassword(@RequestParam String token,
                                     @RequestParam String newPassword,
                                     @RequestParam String confirmPassword,
                                     RedirectAttributes redirectAttributes) {
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Passwords do not match");
            return "redirect:/doctor/reset-password?token=" + token;
        }
        if (newPassword.length() < 6) {
            redirectAttributes.addFlashAttribute("error", "Password must be at least 6 characters long");
            return "redirect:/doctor/reset-password?token=" + token;
        }
        try {
            doctorService.resetPassword(token, newPassword);
            redirectAttributes.addFlashAttribute("success", "Password has been reset successfully. Please login with your new password.");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/doctor/reset-password?token=" + token;
        }
        return "redirect:/doctor/login";
    }

    // ==================== Vendor Password Reset ====================

    @GetMapping("/vendor/forgot-password")
    public String vendorForgotPasswordPage() {
        return "vendor/forgot-password";
    }

    @PostMapping("/vendor/forgot-password")
    public String vendorForgotPassword(@RequestParam String email,
                                      @RequestParam String phone,
                                      HttpServletRequest request,
                                      RedirectAttributes redirectAttributes) throws UnsupportedEncodingException {
        try {
            vendorService.generatePasswordResetToken(email, phone);
            var vendorOpt = vendorService.findByEmail(email);
            if (vendorOpt.isPresent()) {
                var vendor = vendorOpt.get();
                String baseUrl = getBaseUrl(request);
                emailService.sendPasswordResetEmail(vendor.getEmail(), vendor.getPasswordResetToken(), "vendor", baseUrl);
                redirectAttributes.addFlashAttribute("success", "Password reset link has been sent to your email. Please check your inbox.");
            }
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/vendor/forgot-password";
        } catch (MessagingException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to send email. Please try again later.");
            return "redirect:/vendor/forgot-password";
        }
        return "redirect:/vendor/login";
    }

    @GetMapping("/vendor/reset-password")
    public String vendorResetPasswordPage(@RequestParam(required = false) String token, Model model) {
        if (token == null || token.isEmpty()) {
            model.addAttribute("error", "Invalid reset link");
            return "vendor/reset-password";
        }
        var vendorOpt = vendorService.findByPasswordResetToken(token);
        if (vendorOpt.isEmpty()) {
            model.addAttribute("error", "Invalid or expired reset token");
        } else {
            model.addAttribute("token", token);
        }
        return "vendor/reset-password";
    }

    @PostMapping("/vendor/reset-password")
    public String vendorResetPassword(@RequestParam String token,
                                     @RequestParam String newPassword,
                                     @RequestParam String confirmPassword,
                                     RedirectAttributes redirectAttributes) {
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Passwords do not match");
            return "redirect:/vendor/reset-password?token=" + token;
        }
        if (newPassword.length() < 6) {
            redirectAttributes.addFlashAttribute("error", "Password must be at least 6 characters long");
            return "redirect:/vendor/reset-password?token=" + token;
        }
        try {
            vendorService.resetPasswordByToken(token, newPassword);
            redirectAttributes.addFlashAttribute("success", "Password has been reset successfully. Please login with your new password.");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/vendor/reset-password?token=" + token;
        }
        return "redirect:/vendor/login";
    }

    // Helper method to get base URL from request
    private String getBaseUrl(HttpServletRequest request) {
        String scheme = request.getScheme(); // http or https
        String serverName = request.getServerName(); // localhost or IP or domain
        int serverPort = request.getServerPort(); // 8081, 80, 443, etc.
        String contextPath = request.getContextPath(); // / or /app-name
        
        // Build base URL
        StringBuilder baseUrl = new StringBuilder();
        baseUrl.append(scheme).append("://").append(serverName);
        
        // Only append port if it's not the default port (80 for http, 443 for https)
        if ((scheme.equals("http") && serverPort != 80) || 
            (scheme.equals("https") && serverPort != 443)) {
            baseUrl.append(":").append(serverPort);
        }
        
        baseUrl.append(contextPath);
        
        return baseUrl.toString();
    }
}

