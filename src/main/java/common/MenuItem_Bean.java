package common;
import java.io.Serializable;

public class MenuItem_Bean implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int itemId;
    private String name;
    private double price;
    private String description;
    private int categoryId;
    
    private String categoryName; 

    public MenuItem_Bean() {}

    // Getters and Setters
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
}