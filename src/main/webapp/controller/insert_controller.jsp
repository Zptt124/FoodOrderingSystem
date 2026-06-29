<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="CRUD.User_CRUD, common.User_Bean" %>

<jsp:useBean id="user" class="common.User_Bean" scope="request" />
<jsp:setProperty name="user" property="*" />

<%
    User_CRUD userDAO = new User_CRUD();

    if (userDAO.isUsernameTaken(user.getUsername())) {
        out.println("<script>alert('Username is already taken, please choose another!'); window.history.back();</script>");
        return;
    }

    if (userDAO.insertUser(user)) {
        out.println("<script>alert('Registration successful!'); window.location.href='../index.jsp';</script>");
    } else {
        out.println("<script>alert('Registration failed, please try again!'); window.history.back();</script>");
    }
%>
