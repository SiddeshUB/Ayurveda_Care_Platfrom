package com.ayurveda.repository;

import com.ayurveda.entity.ProductQuestion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductQuestionRepository extends JpaRepository<ProductQuestion, Long> {
    
    List<ProductQuestion> findByProductIdOrderByCreatedAtDesc(Long productId);
    
    List<ProductQuestion> findByProductIdAndStatusOrderByCreatedAtDesc(Long productId, ProductQuestion.QuestionStatus status);
    
    @Query("SELECT q FROM ProductQuestion q WHERE q.product.id = :productId AND q.status = 'ACTIVE' ORDER BY q.helpfulCount DESC, q.createdAt DESC")
    List<ProductQuestion> findActiveQuestionsByProductOrderByHelpful(@Param("productId") Long productId);
    
    Long countByProductId(Long productId);
    
    Long countByProductIdAndStatus(Long productId, ProductQuestion.QuestionStatus status);
}

