<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="CRUD.User_CRUD" %>

<%
    int userId = Integer.parseInt(request.getParameter("userId"));

    User_CRUD userDAO = new User_CRUD();

    if (userDAO.deleteUser(userId)) {
        out.println("<script>alert('User deleted successfully!'); window.location.href='../index.jsp';</script>");
    } else {
        out.println("<script>alert('Delete failed — user not found!'); window.history.back();</script>");
    }
%>
