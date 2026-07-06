package com.jadedragon.model;

import java.io.Serializable;
import java.math.BigDecimal;

// Stored in HttpSession, saved to DB as OrderItem at checkout
public class CartItem implements Serializable {
    private static final long serialVersionUID = 1L;

    private int foodId;
    private String foodName;
    private BigDecimal unitPrice;
    private int quantity;
    private String addOns;

    public CartItem() {}

    public CartItem(int foodId, String foodName,
                    BigDecimal unitPrice, int quantity, String addOns) {
        this.foodId = foodId;
        this.foodName = foodName;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.addOns = addOns;
    }

    public BigDecimal getSubtotal() {
        return unitPrice.multiply(BigDecimal.valueOf(quantity));
    }

    /**
     * Parse the surcharge amount from an add-on string.
     * Supports formats: "Extra Chili (+RM 1)", "Add Rice (+RM3)", "No MSG" (no surcharge).
     * @param addOns the add-on description string
     * @return the surcharge amount in RM, or BigDecimal.ZERO if none found
     */
    public static BigDecimal parseAddOnSurcharge(String addOns) {
        if (addOns == null || addOns.isEmpty()) {
            return BigDecimal.ZERO;
        }
        java.util.regex.Matcher m = java.util.regex.Pattern.compile("\\+RM\\s*(\\d+)")
                .matcher(addOns);
        if (m.find()) {
            return new BigDecimal(m.group(1));
        }
        return BigDecimal.ZERO;
    }

    public int getFoodId() { return foodId; }
    public void setFoodId(int foodId) { this.foodId = foodId; }

    public String getFoodName() { return foodName; }
    public void setFoodName(String foodName) { this.foodName = foodName; }

    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getAddOns() { return addOns; }
    public void setAddOns(String addOns) { this.addOns = addOns; }
}