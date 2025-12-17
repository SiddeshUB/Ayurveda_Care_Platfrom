package com.ayurveda.service;

import com.ayurveda.entity.ProductReview;
import com.ayurveda.entity.ReviewHelpfulVote;
import com.ayurveda.entity.User;
import com.ayurveda.repository.ReviewHelpfulVoteRepository;
import com.ayurveda.repository.ProductReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@Transactional
public class ReviewHelpfulVoteService {

    @Autowired
    private ReviewHelpfulVoteRepository voteRepository;

    @Autowired
    private ProductReviewRepository reviewRepository;

    public void voteHelpful(User user, Long reviewId, boolean helpful) {
        ProductReview review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("Review not found"));

        Optional<ReviewHelpfulVote> existingVote = voteRepository.findByReviewIdAndUserId(reviewId, user.getId());

        if (existingVote.isPresent()) {
            ReviewHelpfulVote vote = existingVote.get();
            // Update existing vote
            if (vote.getVoteType() == ReviewHelpfulVote.VoteType.HELPFUL && !helpful) {
                // Change from helpful to not helpful
                review.setHelpfulCount(review.getHelpfulCount() - 1);
                review.setNotHelpfulCount(review.getNotHelpfulCount() + 1);
                vote.setVoteType(ReviewHelpfulVote.VoteType.NOT_HELPFUL);
            } else if (vote.getVoteType() == ReviewHelpfulVote.VoteType.NOT_HELPFUL && helpful) {
                // Change from not helpful to helpful
                review.setHelpfulCount(review.getHelpfulCount() + 1);
                review.setNotHelpfulCount(review.getNotHelpfulCount() - 1);
                vote.setVoteType(ReviewHelpfulVote.VoteType.HELPFUL);
            }
            voteRepository.save(vote);
        } else {
            // Create new vote
            ReviewHelpfulVote vote = new ReviewHelpfulVote();
            vote.setUser(user);
            vote.setReview(review);
            vote.setVoteType(helpful ? ReviewHelpfulVote.VoteType.HELPFUL : ReviewHelpfulVote.VoteType.NOT_HELPFUL);
            voteRepository.save(vote);

            if (helpful) {
                review.setHelpfulCount(review.getHelpfulCount() + 1);
            } else {
                review.setNotHelpfulCount(review.getNotHelpfulCount() + 1);
            }
        }

        reviewRepository.save(review);
    }

    public boolean hasUserVoted(Long userId, Long reviewId) {
        return voteRepository.existsByReviewIdAndUserId(reviewId, userId);
    }
}

