package com.jadedragon.controller;

import com.jadedragon.dao.FoodDAO;
import com.jadedragon.dao.ReviewDAO;
import com.jadedragon.model.FoodItem;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/FoodDetailServlet")
public class FoodDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                response.sendRedirect("menu.jsp");
                return;
            }

            int foodId = Integer.parseInt(idParam);
            FoodDAO foodDAO = new FoodDAO();
            ReviewDAO reviewDAO = new ReviewDAO();

            FoodItem item = foodDAO.findById(foodId);
            if (item == null) {
                response.sendRedirect("menu.jsp");
                return;
            }

            request.setAttribute("food", item);
            request.setAttribute("reviews", reviewDAO.findByFoodId(foodId));

            RequestDispatcher rd = request.getRequestDispatcher("food-detail.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error/500.jsp");
        }
    }
}
