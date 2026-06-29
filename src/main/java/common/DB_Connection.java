package common;

import java.sql.Connection;
import java.sql.DriverManager;

public class DB_Connection {
    private static final String URL = "jdbc:mysql://localhost:3306/food_ordering_system?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "你的数据库密码";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
