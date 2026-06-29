<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management System</title>
</head>
<body>
    <h1>User Management System (Beta)</h1>
    <hr>

    <h3>1. Register New User</h3>
    <form action="controller/insert_controller.jsp" method="post">
        Username: <input type="text" name="username" required><br><br>
        Password: <input type="password" name="password" required><br><br>
        Role:
        <select name="role">
            <option value="customer">Customer</option>
            <option value="admin">Admin</option>
        </select><br><br>
        <input type="submit" value="Register">
    </form>
    <hr>

    <h3>2. Delete User</h3>
    <form action="controller/delete_controller.jsp" method="post">
        Enter User ID to delete: <input type="text" name="userId" required>
        <input type="submit" value="Confirm Delete">
    </form>
    <hr>

    <h3>3. Change Password</h3>
    <a href="edit.jsp"><button>Go to Edit Page</button></a>

</body>
</html>