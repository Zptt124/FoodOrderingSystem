package com.jadedragon.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Review implements Serializable {
    private static final long serialVersionUID = 1L;

    private int reviewId;
    private int userId;
    private String username;        // joined
    private int foodId;
    private int rating;             // 1-5
    private String comment;
    private Timestamp createdAt;

    public Review() {}

    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public int getFoodId() { return foodId; }
    public void setFoodId(int foodId) { this.foodId = foodId; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
