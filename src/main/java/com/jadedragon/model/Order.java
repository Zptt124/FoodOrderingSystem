package com.jadedragon.model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

// Maps to "orders" table
@Entity
@Table(name = "orders")
public class Order implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private int orderId;

    @Column(name = "user_id", nullable = false)
    private int userId;

    @Transient  // Joined from users table, not stored in orders
    private String username;

    @Column(name = "total_price", precision = 10, scale = 2)
    private BigDecimal totalPrice;

    @Column(name = "status", length = 20)
    private String status;  // pending, confirmed, preparing, ready, completed, cancelled

    @Column(name = "order_date", insertable = false, updatable = false)
    private Timestamp orderDate;

    @Column(name = "notes", length = 500)
    private String notes;

    @Transient  // Populated by OrderDAO via separate query, not in orders table
    private List<OrderItem> items;

    public Order() {}

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public BigDecimal getTotalPrice() { return totalPrice; }
    public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getStatusLabel() {
        if (status == null) return "Unknown";
        switch (status) {
            case "pending":    return "Pending";
            case "confirmed":  return "Confirmed";
            case "preparing":  return "Preparing";
            case "ready":      return "Ready";
            case "completed":  return "Completed";
            case "cancelled":  return "Cancelled";
            default:           return status;
        }
    }

    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }
}
