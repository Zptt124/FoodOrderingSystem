package com.jadedragon.controller.admin;

import com.jadedragon.dao.FoodDAO;
import com.jadedragon.dao.OrderDAO;
import com.jadedragon.dao.UserDAO;
import com.jadedragon.model.Order;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            OrderDAO orderDAO = new OrderDAO();
            FoodDAO foodDAO = new FoodDAO();
            UserDAO userDAO = new UserDAO();

            request.setAttribute("orderCount", orderDAO.getOrderCount());
            request.setAttribute("revenue", orderDAO.getTotalRevenue());
            request.setAttribute("foodCount", foodDAO.getFoodCount());
            request.setAttribute("customerCount", userDAO.getUserCount());

            List<Order> pendingOrders = orderDAO.findByStatus("pending");
            if (pendingOrders.size() > 10) {
                pendingOrders = pendingOrders.subList(0, 10);
            }
            request.setAttribute("pendingOrders", pendingOrders);

            RequestDispatcher rd = request.getRequestDispatcher("admin/dashboard.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("../error/500.jsp");
        }
    }
}
