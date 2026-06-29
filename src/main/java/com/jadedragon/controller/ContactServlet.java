package com.jadedragon.controller;

import com.jadedragon.dao.ContactDAO;
import com.jadedragon.model.ContactMessage;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String name = sanitize(request.getParameter("name"));
        String email = sanitize(request.getParameter("email"));
        String subject = sanitize(request.getParameter("subject"));
        String message = sanitize(request.getParameter("message"));

        StringBuilder errors = new StringBuilder();
        if (name == null || name.length() < 2) errors.append("Please enter your name. ");
        if (email == null || !email.matches("^[^@]+@[^@]+\\.[^@]+$")) errors.append("Invalid email. ");
        if (message == null || message.length() < 5) errors.append("Message must be at least 5 characters. ");

        if (errors.length() > 0) {
            request.setAttribute("error", errors.toString());
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("subject", subject);
            request.setAttribute("message", message);
            RequestDispatcher rd = request.getRequestDispatcher("contact.jsp");
            rd.forward(request, response);
            return;
        }

        ContactMessage msg = new ContactMessage();
        msg.setName(name);
        msg.setEmail(email);
        msg.setSubject(subject);
        msg.setMessage(message);

        ContactDAO dao = new ContactDAO();
        if (dao.save(msg)) {
            request.setAttribute("contactSuccess", "Thank you! Your message has been sent. We will get back to you soon.");
        } else {
            request.setAttribute("contactError", "Failed to send message. Please try again later.");
        }

        RequestDispatcher rd = request.getRequestDispatcher("contact.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("contact.jsp");
    }

    private String sanitize(String input) {
        if (input == null) return "";
        return input.replaceAll("[<>'\\\\&\"]", "").trim();
    }
}
