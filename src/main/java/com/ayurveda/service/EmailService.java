package com.ayurveda.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

import java.io.UnsupportedEncodingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String fromEmail;

    @Value("${app.base-url:}")
    private String defaultBaseUrl;

    public void sendPasswordResetEmail(String toEmail, String resetToken, String role, String baseUrl) throws MessagingException, UnsupportedEncodingException {
        // Use provided baseUrl, or fall back to default from properties
        String actualBaseUrl = (baseUrl != null && !baseUrl.isEmpty()) ? baseUrl : defaultBaseUrl;
        String resetLink = actualBaseUrl + "/" + role + "/reset-password?token=" + resetToken;
        
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        helper.setFrom(fromEmail, "AyurVedaCare");
        helper.setTo(toEmail);
        helper.setSubject("Password Reset Request - AyurVedaCare");

        String htmlContent = "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<style>" +
                "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }" +
                ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
                ".header { background-color: #2d5a27; color: white; padding: 20px; text-align: center; border-radius: 5px 5px 0 0; }" +
                ".content { background-color: #f9f9f9; padding: 30px; border-radius: 0 0 5px 5px; }" +
                ".button { display: inline-block; padding: 12px 30px; background-color: #2d5a27; color: white; text-decoration: none; border-radius: 5px; margin: 20px 0; }" +
                ".button:hover { background-color: #1e3d1a; }" +
                ".footer { text-align: center; margin-top: 20px; color: #666; font-size: 12px; }" +
                "</style>" +
                "</head>" +
                "<body>" +
                "<div class='container'>" +
                "<div class='header'>" +
                "<h2>Password Reset Request</h2>" +
                "</div>" +
                "<div class='content'>" +
                "<p>Hello,</p>" +
                "<p>You have requested to reset your password for your AyurVedaCare account.</p>" +
                "<p>Click the button below to reset your password:</p>" +
                "<p style='text-align: center;'>" +
                "<a href='" + resetLink + "' class='button'>Reset Password</a>" +
                "</p>" +
                "<p>Or copy and paste this link into your browser:</p>" +
                "<p style='word-break: break-all; color: #2d5a27;'>" + resetLink + "</p>" +
                "<p><strong>This link will expire in 1 hour.</strong></p>" +
                "<p>If you did not request this password reset, please ignore this email.</p>" +
                "<p>Best regards,<br>AyurVedaCare Team</p>" +
                "</div>" +
                "<div class='footer'>" +
                "<p>This is an automated email. Please do not reply to this message.</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";

        helper.setText(htmlContent, true);
        mailSender.send(message);
    }
}

