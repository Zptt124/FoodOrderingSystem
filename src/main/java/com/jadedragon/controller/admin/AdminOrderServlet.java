package com.jadedragon.controller.admin;

import com.jadedragon.dao.OrderDAO;
import com.jadedragon.model.Order;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/AdminOrderServlet")
public class AdminOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();
        String action = request.getParameter("action");
        String statusFilter = request.getParameter("status");

        if ("detail".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("id"));
            Order order = orderDAO.findById(orderId);
            request.setAttribute("order", order);
            request.setAttribute("orders", (statusFilter != null && !statusFilter.isEmpty())
                    ? orderDAO.findByStatus(statusFilter) : orderDAO.findAll());
            request.setAttribute("currentFilter", statusFilter);
            RequestDispatcher rd = request.getRequestDispatcher("admin/orders.jsp");
            rd.forward(request, response);
            return;
        }

        List<Order> orders;
        if (statusFilter != null && !statusFilter.isEmpty()) {
            orders = orderDAO.findByStatus(statusFilter);
        } else {
            orders = orderDAO.findAll();
        }

        request.setAttribute("orders", orders);
        request.setAttribute("currentFilter", statusFilter);
        RequestDispatcher rd = request.getRequestDispatcher("admin/orders.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String newStatus = request.getParameter("newStatus");
            new OrderDAO().updateStatus(orderId, newStatus);
        }

        response.sendRedirect("AdminOrderServlet");
    }
}
