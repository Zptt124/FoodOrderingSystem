package CRUD;

import common.DB_Connection;
import common.Category_Bean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Category_CRUD {
    
    public List<Category_Bean> getAllCategories() {
        List<Category_Bean> list = new ArrayList<>();
        String sql = "SELECT * FROM categories";
        
        try (Connection conn = DB_Connection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Category_Bean cat = new Category_Bean();
                cat.setCategoryId(rs.getInt("category_id"));
                cat.setCategoryName(rs.getString("category_name"));
                list.add(cat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}