package com.jadedragon.dao;

import com.jadedragon.model.Review;
import com.jadedragon.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    public List<Review> findByFoodId(int foodId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.*, u.username FROM reviews r JOIN users u ON r.user_id = u.user_id " +
                     "WHERE r.food_id = ? ORDER BY r.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, foodId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractReview(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean add(Review review) {
        String sql = "INSERT INTO reviews (user_id, food_id, rating, comment) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, review.getUserId());
            ps.setInt(2, review.getFoodId());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getComment());
            boolean result = ps.executeUpdate() > 0;
            if (result) {
                new FoodDAO().updateRating(review.getFoodId());
            }
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Review extractReview(ResultSet rs) throws SQLException {
        Review r = new Review();
        r.setReviewId(rs.getInt("review_id"));
        r.setUserId(rs.getInt("user_id"));
        r.setFoodId(rs.getInt("food_id"));
        r.setRating(rs.getInt("rating"));
        r.setComment(rs.getString("comment"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        try { r.setUsername(rs.getString("username")); } catch (SQLException ignored) {}
        return r;
    }
}
