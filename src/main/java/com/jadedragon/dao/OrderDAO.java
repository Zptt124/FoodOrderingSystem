package com.jadedragon.dao;

import com.jadedragon.model.Order;
import com.jadedragon.model.OrderItem;
import com.jadedragon.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    /**
     * Create a new order and its items in a transaction.
     * Returns the generated order ID or -1 on failure.
     */
    public int createOrder(int userId, BigDecimal totalPrice, List<OrderItem> items, String notes) {
        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psItem = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Insert order
            String sqlOrder = "INSERT INTO orders (user_id, total_price, status, notes) VALUES (?, ?, 'pending', ?)";
            psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, userId);
            psOrder.setBigDecimal(2, totalPrice);
            psOrder.setString(3, notes);
            psOrder.executeUpdate();

            rs = psOrder.getGeneratedKeys();
            if (!rs.next()) {
                conn.rollback();
                return -1;
            }
            int orderId = rs.getInt(1);

            // Insert order items
            String sqlItem = "INSERT INTO order_items (order_id, food_id, quantity, add_ons, unit_price) VALUES (?, ?, ?, ?, ?)";
            psItem = conn.prepareStatement(sqlItem);
            for (OrderItem item : items) {
                psItem.setInt(1, orderId);
                psItem.setInt(2, item.getFoodId());
                psItem.setInt(3, item.getQuantity());
                psItem.setString(4, item.getAddOns());
                psItem.setBigDecimal(5, item.getUnitPrice());
                psItem.addBatch();
            }
            psItem.executeBatch();

            conn.commit();
            return orderId;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ignored) {}
            }
            e.printStackTrace();
            return -1;
        } finally {
            DBConnection.closeQuietly(rs, psItem, psOrder);
            if (conn != null) {
                try { conn.setAutoCommit(true); } catch (SQLException ignored) {}
                DBConnection.closeQuietly(conn);
            }
        }
    }

    public List<Order> findByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, u.username FROM orders o " +
                     "JOIN users u ON o.user_id = u.user_id " +
                     "WHERE o.user_id = ? ORDER BY o.order_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = extractOrder(rs);
                    order.setItems(findOrderItems(order.getOrderId()));
                    list.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Order findById(int orderId) {
        String sql = "SELECT o.*, u.username FROM orders o " +
                     "JOIN users u ON o.user_id = u.user_id WHERE o.order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order order = extractOrder(rs);
                    order.setItems(findOrderItems(orderId));
                    return order;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Order> findAll() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, u.username FROM orders o " +
                     "JOIN users u ON o.user_id = u.user_id ORDER BY o.order_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(extractOrder(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> findByStatus(String status) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, u.username FROM orders o " +
                     "JOIN users u ON o.user_id = u.user_id WHERE o.status = ? ORDER BY o.order_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractOrder(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStatus(int orderId, String newStatus) {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getOrderCount() {
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public BigDecimal getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_price), 0) FROM orders WHERE status != 'cancelled'";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    private List<OrderItem> findOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.*, f.name AS food_name, f.name_cn AS food_name_cn " +
                     "FROM order_items oi JOIN food_items f ON oi.food_id = f.food_id WHERE oi.order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(extractOrderItem(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    private Order extractOrder(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setOrderId(rs.getInt("order_id"));
        o.setUserId(rs.getInt("user_id"));
        o.setTotalPrice(rs.getBigDecimal("total_price"));
        o.setStatus(rs.getString("status"));
        o.setOrderDate(rs.getTimestamp("order_date"));
        o.setNotes(rs.getString("notes"));
        try { o.setUsername(rs.getString("username")); } catch (SQLException ignored) {}
        return o;
    }

    private OrderItem extractOrderItem(ResultSet rs) throws SQLException {
        OrderItem oi = new OrderItem();
        oi.setOrderItemId(rs.getInt("order_item_id"));
        oi.setOrderId(rs.getInt("order_id"));
        oi.setFoodId(rs.getInt("food_id"));
        oi.setQuantity(rs.getInt("quantity"));
        oi.setAddOns(rs.getString("add_ons"));
        oi.setUnitPrice(rs.getBigDecimal("unit_price"));
        try { oi.setFoodName(rs.getString("food_name")); } catch (SQLException ignored) {}
        try { oi.setFoodNameCn(rs.getString("food_name_cn")); } catch (SQLException ignored) {}
        oi.setSubtotal(oi.getUnitPrice().multiply(BigDecimal.valueOf(oi.getQuantity())));
        return oi;
    }
}
