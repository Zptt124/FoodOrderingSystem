package CRUD;

import common.DB_Connection;
import common.Order;
import common.OrderDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Order_CRUD {

    // 1. Get all orders (including buyer username)
    // Requirement: "View customer orders (user info, total price, time)"
    public List<Order> getAllOrders() {
        List<Order> orderList = new ArrayList<>();
        // Join query: get all orders info plus username from users table
        String sql = "SELECT o.order_id, o.user_id, o.total_price, o.order_time, u.username " +
                     "FROM orders o " +
                     "LEFT JOIN users u ON o.user_id = u.user_id " +
                     "ORDER BY o.order_time DESC";

        try (Connection conn = DB_Connection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setOrderTime(rs.getTimestamp("order_time"));
                order.setUsername(rs.getString("username")); // Populate buyer username
                orderList.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderList;
    }

    // 2. Get specific order details (including item name and unit price)
    // Requirement: "View customer orders (items)"
    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetail> detailList = new ArrayList<>();
        // Join query: get order_details linked with menu_items for dish names
        String sql = "SELECT od.detail_id, od.order_id, od.item_id, od.quantity, od.price, m.name as item_name " +
                     "FROM order_details od " +
                     "LEFT JOIN menu_items m ON od.item_id = m.item_id " +
                     "WHERE od.order_id = ?";

        try (Connection conn = DB_Connection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail detail = new OrderDetail();
                    detail.setDetailId(rs.getInt("detail_id"));
                    detail.setOrderId(rs.getInt("order_id"));
                    detail.setItemId(rs.getInt("item_id"));
                    detail.setQuantity(rs.getInt("quantity"));
                    detail.setPrice(rs.getDouble("price"));
                    detail.setItemName(rs.getString("item_name")); // Populate item name
                    detailList.add(detail);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return detailList;
    }
}
