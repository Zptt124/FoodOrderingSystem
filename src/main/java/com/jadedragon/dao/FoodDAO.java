package com.jadedragon.dao;

import com.jadedragon.model.FoodItem;
import com.jadedragon.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FoodDAO {

    public List<FoodItem> findAll() {
        return findByCategory(0);
    }

    public List<FoodItem> findByCategory(int categoryId) {
        List<FoodItem> list = new ArrayList<>();
        String sql = "SELECT f.*, c.name AS category_name " +
                     "FROM food_items f LEFT JOIN categories c ON f.category_id = c.category_id " +
                     "WHERE f.is_available = TRUE";
        if (categoryId > 0) {
            sql += " AND f.category_id = " + categoryId;
        }
        sql += " ORDER BY f.is_popular DESC, f.category_id, f.name";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(extractFoodItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<FoodItem> findFeatured() {
        List<FoodItem> list = new ArrayList<>();
        String sql = "SELECT f.*, c.name AS category_name " +
                     "FROM food_items f LEFT JOIN categories c ON f.category_id = c.category_id " +
                     "WHERE f.is_featured = TRUE AND f.is_available = TRUE ORDER BY f.food_id LIMIT 6";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(extractFoodItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<FoodItem> findPopular() {
        List<FoodItem> list = new ArrayList<>();
        String sql = "SELECT f.*, c.name AS category_name " +
                     "FROM food_items f LEFT JOIN categories c ON f.category_id = c.category_id " +
                     "WHERE f.is_popular = TRUE AND f.is_available = TRUE ORDER BY f.rating DESC LIMIT 8";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(extractFoodItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public FoodItem findById(int foodId) {
        String sql = "SELECT f.*, c.name AS category_name " +
                     "FROM food_items f LEFT JOIN categories c ON f.category_id = c.category_id " +
                     "WHERE f.food_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, foodId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return extractFoodItem(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<FoodItem> search(String keyword) {
        List<FoodItem> list = new ArrayList<>();
        String sql = "SELECT f.*, c.name AS category_name " +
                     "FROM food_items f LEFT JOIN categories c ON f.category_id = c.category_id " +
                     "WHERE f.is_available = TRUE AND (f.name LIKE ? OR f.description LIKE ?) " +
                     "ORDER BY f.is_popular DESC, f.name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String kw = "%" + keyword + "%";
            ps.setString(1, kw);
            ps.setString(2, kw);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractFoodItem(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Admin: get all items including unavailable
    public List<FoodItem> findAllAdmin() {
        List<FoodItem> list = new ArrayList<>();
        String sql = "SELECT f.*, c.name AS category_name " +
                     "FROM food_items f LEFT JOIN categories c ON f.category_id = c.category_id " +
                     "ORDER BY f.food_id";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(extractFoodItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean add(FoodItem item) {
        String sql = "INSERT INTO food_items (name, description, ingredients, nutritional_info, " +
                     "price, image_url, category_id, is_featured, is_popular, is_available) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            setParams(ps, item);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(FoodItem item) {
        String sql = "UPDATE food_items SET name=?, description=?, ingredients=?, nutritional_info=?, " +
                     "price=?, image_url=?, category_id=?, is_featured=?, is_popular=?, is_available=? WHERE food_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            setParams(ps, item);
            ps.setInt(11, item.getFoodId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int foodId) {
        String sql = "DELETE FROM food_items WHERE food_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, foodId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getFoodCount() {
        String sql = "SELECT COUNT(*) FROM food_items WHERE is_available = TRUE";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private void setParams(PreparedStatement ps, FoodItem item) throws SQLException {
        ps.setString(1, item.getName());
        ps.setString(2, item.getDescription());
        ps.setString(3, item.getIngredients());
        ps.setString(4, item.getNutritionalInfo());
        ps.setBigDecimal(5, item.getPrice());
        ps.setString(6, item.getImageUrl());
        if (item.getCategoryId() > 0) {
            ps.setInt(7, item.getCategoryId());
        } else {
            ps.setNull(7, Types.INTEGER);
        }
        ps.setBoolean(8, item.isFeatured());
        ps.setBoolean(9, item.isPopular());
        ps.setBoolean(10, item.isAvailable());
    }

    private FoodItem extractFoodItem(ResultSet rs) throws SQLException {
        FoodItem f = new FoodItem();
        f.setFoodId(rs.getInt("food_id"));
        f.setName(rs.getString("name"));
        f.setDescription(rs.getString("description"));
        f.setIngredients(rs.getString("ingredients"));
        f.setNutritionalInfo(rs.getString("nutritional_info"));
        f.setPrice(rs.getBigDecimal("price"));
        f.setImageUrl(rs.getString("image_url"));
        f.setCategoryId(rs.getInt("category_id"));
        f.setRating(rs.getDouble("rating"));
        f.setReviewCount(rs.getInt("review_count"));
        f.setFeatured(rs.getBoolean("is_featured"));
        f.setPopular(rs.getBoolean("is_popular"));
        f.setAvailable(rs.getBoolean("is_available"));
        try { f.setCategoryName(rs.getString("category_name")); } catch (SQLException ignored) {}
        return f;
    }
}