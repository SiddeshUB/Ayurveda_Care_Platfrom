package com.ayurveda.repository;

import com.ayurveda.entity.ProductAnswer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductAnswerRepository extends JpaRepository<ProductAnswer, Long> {
    
    List<ProductAnswer> findByQuestionIdOrderByHelpfulCountDescCreatedAtDesc(Long questionId);
    
    List<ProductAnswer> findByQuestionIdAndStatusOrderByHelpfulCountDescCreatedAtDesc(Long questionId, ProductAnswer.AnswerStatus status);
    
    @Query("SELECT a FROM ProductAnswer a WHERE a.question.id = :questionId AND a.status = 'ACTIVE' ORDER BY a.isVendorAnswer DESC, a.helpfulCount DESC, a.createdAt DESC")
    List<ProductAnswer> findActiveAnswersByQuestionOrderByVendorAndHelpful(@Param("questionId") Long questionId);
    
    Long countByQuestionId(Long questionId);
}

