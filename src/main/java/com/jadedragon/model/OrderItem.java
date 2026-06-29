package com.jadedragon.model;

import java.io.Serializable;
import java.math.BigDecimal;

public class OrderItem implements Serializable {
    private static final long serialVersionUID = 1L;

    private int orderItemId;
    private int orderId;
    private int foodId;
    private String foodName;        // joined
    private String foodNameCn;      // joined
    private int quantity;
    private String addOns;
    private BigDecimal unitPrice;
    private BigDecimal subtotal;    // calculated: unitPrice * quantity

    public OrderItem() {}

    public int getOrderItemId() { return orderItemId; }
    public void setOrderItemId(int orderItemId) { this.orderItemId = orderItemId; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getFoodId() { return foodId; }
    public void setFoodId(int foodId) { this.foodId = foodId; }

    public String getFoodName() { return foodName; }
    public void setFoodName(String foodName) { this.foodName = foodName; }

    public String getFoodNameCn() { return foodNameCn; }
    public void setFoodNameCn(String foodNameCn) { this.foodNameCn = foodNameCn; }

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
