<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="CRUD.User_CRUD" %>

<%
    int userId = Integer.parseInt(request.getParameter("userId"));
    String newPassword = request.getParameter("newPassword");

    User_CRUD userDAO = new User_CRUD();

    if (userDAO.updatePassword(userId, newPassword)) {
        out.println("<script>alert('Password changed successfully!'); window.location.href='../index.jsp';</script>");
    } else {
        out.println("<script>alert('Update failed — user ID may not exist!'); window.history.back();</script>");
    }
%>
