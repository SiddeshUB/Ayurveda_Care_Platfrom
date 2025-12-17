package com.ayurveda.repository;

import com.ayurveda.entity.ReviewHelpfulVote;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ReviewHelpfulVoteRepository extends JpaRepository<ReviewHelpfulVote, Long> {
    
    Optional<ReviewHelpfulVote> findByReviewIdAndUserId(Long reviewId, Long userId);
    
    boolean existsByReviewIdAndUserId(Long reviewId, Long userId);
    
    @Query("SELECT COUNT(v) FROM ReviewHelpfulVote v WHERE v.review.id = :reviewId AND v.voteType = 'HELPFUL'")
    Long countHelpfulVotesByReviewId(@Param("reviewId") Long reviewId);
    
    @Query("SELECT COUNT(v) FROM ReviewHelpfulVote v WHERE v.review.id = :reviewId AND v.voteType = 'NOT_HELPFUL'")
    Long countNotHelpfulVotesByReviewId(@Param("reviewId") Long reviewId);
}

