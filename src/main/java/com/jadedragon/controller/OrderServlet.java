package com.jadedragon.controller;

import com.jadedragon.dao.OrderDAO;
import com.jadedragon.model.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        OrderDAO orderDAO = new OrderDAO();
        List<Order> orders = orderDAO.findByUserId(user.getUserId());
        request.setAttribute("orders", orders);
        RequestDispatcher rd = request.getRequestDispatcher("my-orders.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("checkout".equals(action)) {
            handleCheckout(request, response, session);
        }
    }

    private void handleCheckout(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp?error=empty");
            return;
        }

        User user = (User) session.getAttribute("user");
        String notes = request.getParameter("notes");
        if (notes == null) notes = "";

        BigDecimal total = BigDecimal.ZERO;
        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem ci : cart) {
            OrderItem oi = new OrderItem();
            oi.setFoodId(ci.getFoodId());
            oi.setQuantity(ci.getQuantity());
            oi.setAddOns(ci.getAddOns());
            oi.setUnitPrice(ci.getUnitPrice());
            oi.setFoodName(ci.getFoodName());
            oi.setSubtotal(ci.getSubtotal());
            orderItems.add(oi);
            total = total.add(ci.getSubtotal());
        }

        OrderDAO orderDAO = new OrderDAO();
        int orderId = orderDAO.createOrder(user.getUserId(), total, orderItems, notes);

        if (orderId > 0) {
            session.setAttribute("cart", null);
            session.setAttribute("cartCount", 0);
            session.setAttribute("cartTotal", BigDecimal.ZERO);

            Order order = orderDAO.findById(orderId);
            request.setAttribute("order", order);
            RequestDispatcher rd = request.getRequestDispatcher("order-confirm.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("error", "Order failed. Please try again.");
            RequestDispatcher rd = request.getRequestDispatcher("cart.jsp");
            rd.forward(request, response);
        }
    }
}