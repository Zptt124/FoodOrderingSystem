package com.jadedragon.controller;

import com.jadedragon.dao.UserDAO;
import com.jadedragon.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = sanitize(request.getParameter("username"));
        String password = request.getParameter("password");
        String redirect = request.getParameter("redirect");

        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "Please enter username and password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.login(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("isAdmin", user.isAdmin());

            if (user.isAdmin()) {
                response.sendRedirect("admin/dashboard.jsp");
            } else if (redirect != null && !redirect.isEmpty()) {
                response.sendRedirect(redirect);
            } else {
                response.sendRedirect("home.jsp");
            }
        } else {
            request.setAttribute("error", "Invalid username or password.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    private String sanitize(String input) {
        if (input == null) return "";
        return input.replaceAll("[<>'\\\\&\"]", "").trim();
    }
}
