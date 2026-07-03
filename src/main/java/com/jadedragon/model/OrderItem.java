package com.jadedragon.model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * OrderItem entity — maps to "order_items" table.
 * Each OrderItem represents one line item within an order.
 *
 * Demonstrates JPA @Entity + @Transient for calculated/joined fields
 * (foodName is joined, subtotal is calculated as unitPrice × quantity).
 */
@Entity
@Table(name = "order_items")
public class OrderItem implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_item_id")
    private int orderItemId;

    @Column(name = "order_id")
    private int orderId;

    @Column(name = "food_id")
    private int foodId;

    @Transient  // Joined from food_items table
    private String foodName;

    @Column(name = "quantity", nullable = false)
    private int quantity;

    @Column(name = "add_ons", length = 200)
    private String addOns;

    @Column(name = "unit_price", precision = 10, scale = 2)
    private BigDecimal unitPrice;

    @Transient  // Calculated as unitPrice * quantity, not stored
    private BigDecimal subtotal;

    public OrderItem() {}

    public int getOrderItemId() { return orderItemId; }
    public void setOrderItemId(int orderItemId) { this.orderItemId = orderItemId; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getFoodId() { return foodId; }
    public void setFoodId(int foodId) { this.foodId = foodId; }

    public String getFoodName() { return foodName; }
    public void setFoodName(String foodName) { this.foodName = foodName; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getAddOns() { return addOns; }
    public void setAddOns(String addOns) { this.addOns = addOns; }

    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }

    public BigDecimal getSubtotal() {
        if (subtotal == null && unitPrice != null) {
            return unitPrice.multiply(BigDecimal.valueOf(quantity));
        }
        return subtotal;
    }
    public void setSubtotal(BigDecimal subtotal) { this.subtotal = subtotal; }
}
