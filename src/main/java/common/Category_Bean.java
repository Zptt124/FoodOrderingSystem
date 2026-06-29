package common;
import java.io.Serializable;

public class Category_Bean implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int categoryId;
    private String categoryName;

    public Category_Bean() {}

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
}