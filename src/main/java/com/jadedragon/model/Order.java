package com.jadedragon.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class Order implements Serializable {
    private static final long serialVersionUID = 1L;

    private int orderId;
    private int userId;
    private String username;        // joined
    private BigDecimal totalPrice;
    private String status;          // pending, confirmed, preparing, ready, completed, cancelled
    private Timestamp orderDate;
    private String notes;
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

    public String getStatusCn() {
        if (status == null) return "未知";
        switch (status) {
            case "pending":    return "待处理";
            case "confirmed":  return "已确认";
            case "preparing":  return "准备中";
            case "ready":      return "待取餐";
            case "completed":  return "已完成";
            case "cancelled":  return "已取消";
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
