<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
</head>
<body>
    <h2>Change User Password</h2>
    <form action="controller/edit_controller.jsp" method="post">
        User ID: <input type="text" name="userId" required><br><br>
        New Password: <input type="password" name="newPassword" required><br><br>
        <input type="submit" value="Confirm Change">
    </form>
    <br>
    <a href="index.jsp">Back to Home</a>
</body>
</html>