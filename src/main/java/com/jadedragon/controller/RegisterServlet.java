package com.jadedragon.controller;

import com.jadedragon.dao.UserDAO;
import com.jadedragon.model.User;
import com.jadedragon.util.PasswordUtil;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = sanitize(request.getParameter("username"));
        String email = sanitize(request.getParameter("email"));
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = sanitize(request.getParameter("phone"));

        StringBuilder errors = new StringBuilder();

        // Server-side validation
        if (username == null || username.length() < 3) {
            errors.append("Username must be at least 3 characters. ");
        }
        if (email == null || !email.matches("^(?!.*\\.\\.)[a-zA-Z0-9._%+\\-]+@[a-zA-Z0-9.\\-]+\\.[a-zA-Z]{2,}$")) {
            errors.append("Invalid email format. ");
        }
        if (password == null || password.length() < 6) {
            errors.append("Password must be at least 6 characters. ");
        }
        if (!password.equals(confirmPassword)) {
            errors.append("Passwords do not match. ");
        }
        if (phone != null && !phone.isEmpty() && !phone.matches("^\\+?[0-9]{7,15}$")) {
            errors.append("Invalid phone number format. ");
        }

        UserDAO userDAO = new UserDAO();
        if (userDAO.isUsernameTaken(username)) {
            errors.append("Username already taken. ");
        }
        if (userDAO.isEmailTaken(email)) {
            errors.append("Email already registered. ");
        }

        if (errors.length() > 0) {
            request.setAttribute("error", errors.toString());
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
            return;
        }

        // Register user
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(PasswordUtil.simpleHash(password));
        user.setPhone(phone);
        user.setRole("customer");

        if (userDAO.register(user)) {
            request.setAttribute("success", "Registration successful! Please log in.");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    private String sanitize(String input) {
        if (input == null) return "";
        return input.replaceAll("[<>'\\\\&\"]", "").trim();
    }
}
