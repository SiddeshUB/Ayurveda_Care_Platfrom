package com.ayurveda.service;

import com.ayurveda.entity.ProductAnswer;
import com.ayurveda.entity.ProductQuestion;
import com.ayurveda.entity.User;
import com.ayurveda.repository.ProductAnswerRepository;
import com.ayurveda.repository.ProductQuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ProductAnswerService {

    @Autowired
    private ProductAnswerRepository answerRepository;

    @Autowired
    private ProductQuestionRepository questionRepository;

    public List<ProductAnswer> getQuestionAnswers(Long questionId) {
        return answerRepository.findActiveAnswersByQuestionOrderByVendorAndHelpful(questionId);
    }

    public ProductAnswer answerQuestion(User user, Long questionId, String answer, boolean isVendor) {
        ProductQuestion question = questionRepository.findById(questionId)
                .orElseThrow(() -> new RuntimeException("Question not found"));

        ProductAnswer a = new ProductAnswer();
        a.setUser(user);
        a.setQuestion(question);
        a.setAnswer(answer);
        a.setIsVendorAnswer(isVendor);
        a.setStatus(ProductAnswer.AnswerStatus.ACTIVE);

        return answerRepository.save(a);
    }

    public void markHelpful(Long answerId, boolean helpful) {
        ProductAnswer answer = answerRepository.findById(answerId)
                .orElseThrow(() -> new RuntimeException("Answer not found"));

        if (helpful) {
            answer.setHelpfulCount(answer.getHelpfulCount() + 1);
        } else {
            answer.setNotHelpfulCount(answer.getNotHelpfulCount() + 1);
        }

        answerRepository.save(answer);
    }
}

