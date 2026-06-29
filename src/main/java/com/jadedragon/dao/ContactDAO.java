package com.jadedragon.dao;

import com.jadedragon.model.ContactMessage;
import com.jadedragon.util.DBConnection;

import java.sql.*;

public class ContactDAO {

    public boolean save(ContactMessage msg) {
        String sql = "INSERT INTO contact_messages (name, email, subject, message) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, msg.getName());
            ps.setString(2, msg.getEmail());
            ps.setString(3, msg.getSubject());
            ps.setString(4, msg.getMessage());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
