<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
    <h2>User Login</h2>

    <%-- Display error message from Servlet in red --%>
    <%
        String error = (String) request.getAttribute("errorMessage");
        if(error != null) {
    %>
        <p style="color:red;"><%= error %></p>
    <% } %>

    <%-- Form submits to LoginServlet (mapped to /login) --%>
    <form action="login" method="post">
        Username: <input type="text" name="username" required><br><br>
        Password: <input type="password" name="password" required><br><br>
        <input type="submit" value="Login">
    </form>
</body>
</html>