package com.ayurveda.service;

import com.ayurveda.entity.Product;
import com.ayurveda.entity.ProductQuestion;
import com.ayurveda.entity.User;
import com.ayurveda.repository.ProductQuestionRepository;
import com.ayurveda.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ProductQuestionService {

    @Autowired
    private ProductQuestionRepository questionRepository;

    @Autowired
    private ProductRepository productRepository;

    public List<ProductQuestion> getProductQuestions(Long productId) {
        return questionRepository.findActiveQuestionsByProductOrderByHelpful(productId);
    }

    public ProductQuestion askQuestion(User user, Long productId, String question) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        ProductQuestion q = new ProductQuestion();
        q.setUser(user);
        q.setProduct(product);
        q.setQuestion(question);
        q.setStatus(ProductQuestion.QuestionStatus.ACTIVE);

        return questionRepository.save(q);
    }

    public void markHelpful(Long questionId, boolean helpful) {
        ProductQuestion question = questionRepository.findById(questionId)
                .orElseThrow(() -> new RuntimeException("Question not found"));

        if (helpful) {
            question.setHelpfulCount(question.getHelpfulCount() + 1);
        } else {
            question.setNotHelpfulCount(question.getNotHelpfulCount() + 1);
        }

        questionRepository.save(question);
    }

    public Long getQuestionCount(Long productId) {
        return questionRepository.countByProductIdAndStatus(productId, ProductQuestion.QuestionStatus.ACTIVE);
    }
}

