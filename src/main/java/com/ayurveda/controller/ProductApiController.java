package com.ayurveda.controller;

import com.ayurveda.entity.User;
import com.ayurveda.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class ProductApiController {

    @Autowired
    private ProductQuestionService questionService;

    @Autowired
    private ProductAnswerService answerService;

    @Autowired
    private ReviewHelpfulVoteService helpfulVoteService;

    @Autowired
    private UserService userService;

    // Ask Question
    @PostMapping("/products/{productId}/questions")
    public ResponseEntity<Map<String, Object>> askQuestion(
            @PathVariable Long productId,
            @RequestBody Map<String, String> request,
            Authentication authentication) {
        
        User user = getCurrentUser(authentication);
        if (user == null) {
            return ResponseEntity.badRequest().body(createErrorResponse("Please login to ask a question"));
        }

        String question = request.get("question");
        if (question == null || question.trim().isEmpty()) {
            return ResponseEntity.badRequest().body(createErrorResponse("Question cannot be empty"));
        }

        try {
            questionService.askQuestion(user, productId, question.trim());
            return ResponseEntity.ok(createSuccessResponse("Question submitted successfully"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(createErrorResponse(e.getMessage()));
        }
    }

    // Answer Question
    @PostMapping("/questions/{questionId}/answers")
    public ResponseEntity<Map<String, Object>> answerQuestion(
            @PathVariable Long questionId,
            @RequestBody Map<String, String> request,
            Authentication authentication) {
        
        User user = getCurrentUser(authentication);
        if (user == null) {
            return ResponseEntity.badRequest().body(createErrorResponse("Please login to answer"));
        }

        String answer = request.get("answer");
        if (answer == null || answer.trim().isEmpty()) {
            return ResponseEntity.badRequest().body(createErrorResponse("Answer cannot be empty"));
        }

        try {
            answerService.answerQuestion(user, questionId, answer.trim(), false);
            return ResponseEntity.ok(createSuccessResponse("Answer submitted successfully"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(createErrorResponse(e.getMessage()));
        }
    }

    // Vote Review Helpful
    @PostMapping("/reviews/{reviewId}/vote")
    public ResponseEntity<Map<String, Object>> voteReview(
            @PathVariable Long reviewId,
            @RequestBody Map<String, Boolean> request,
            Authentication authentication) {
        
        User user = getCurrentUser(authentication);
        if (user == null) {
            return ResponseEntity.badRequest().body(createErrorResponse("Please login to vote"));
        }

        Boolean helpful = request.get("helpful");
        if (helpful == null) {
            return ResponseEntity.badRequest().body(createErrorResponse("Invalid vote"));
        }

        try {
            helpfulVoteService.voteHelpful(user, reviewId, helpful);
            return ResponseEntity.ok(createSuccessResponse("Vote recorded"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(createErrorResponse(e.getMessage()));
        }
    }

    // Vote Answer Helpful
    @PostMapping("/answers/{answerId}/vote")
    public ResponseEntity<Map<String, Object>> voteAnswer(
            @PathVariable Long answerId,
            @RequestBody Map<String, Boolean> request,
            Authentication authentication) {
        
        User user = getCurrentUser(authentication);
        if (user == null) {
            return ResponseEntity.badRequest().body(createErrorResponse("Please login to vote"));
        }

        Boolean helpful = request.get("helpful");
        if (helpful == null) {
            return ResponseEntity.badRequest().body(createErrorResponse("Invalid vote"));
        }

        try {
            answerService.markHelpful(answerId, helpful);
            return ResponseEntity.ok(createSuccessResponse("Vote recorded"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(createErrorResponse(e.getMessage()));
        }
    }

    private User getCurrentUser(Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated() 
                && !"anonymousUser".equals(authentication.getPrincipal())) {
            String email = authentication.getName();
            return userService.findByEmail(email).orElse(null);
        }
        return null;
    }

    private Map<String, Object> createSuccessResponse(String message) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", message);
        return response;
    }

    private Map<String, Object> createErrorResponse(String message) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", false);
        response.put("message", message);
        return response;
    }
}

