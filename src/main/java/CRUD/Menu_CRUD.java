package CRUD;

import common.DB_Connection;
import common.MenuItem_Bean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Menu_CRUD {

    public boolean addMenuItem(MenuItem_Bean item) {
        String sql = "INSERT INTO menu_items (name, price, description, category_id) VALUES (?, ?, ?, ?)";
        try (Connection conn = DB_Connection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, item.getName());
            ps.setDouble(2, item.getPrice());
            ps.setString(3, item.getDescription());
            ps.setInt(4, item.getCategoryId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<MenuItem_Bean> getAllMenuItems() {
        List<MenuItem_Bean> list = new ArrayList<>();
        String sql = "SELECT m.*, c.category_name FROM menu_items m LEFT JOIN categories c ON m.category_id = c.category_id";

        try (Connection conn = DB_Connection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                MenuItem_Bean item = new MenuItem_Bean();
                item.setItemId(rs.getInt("item_id"));
                item.setName(rs.getString("name"));
                item.setPrice(rs.getDouble("price"));
                item.setDescription(rs.getString("description"));
                item.setCategoryId(rs.getInt("category_id"));
                item.setCategoryName(rs.getString("category_name")); // Populate category name
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateMenuItem(MenuItem_Bean item) {
        String sql = "UPDATE menu_items SET name=?, price=?, description=?, category_id=? WHERE item_id=?";
        try (Connection conn = DB_Connection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, item.getName());
            ps.setDouble(2, item.getPrice());
            ps.setString(3, item.getDescription());
            ps.setInt(4, item.getCategoryId());
            ps.setInt(5, item.getItemId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteMenuItem(int itemId) {
        String sql = "DELETE FROM menu_items WHERE item_id=?";
        try (Connection conn = DB_Connection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, itemId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
