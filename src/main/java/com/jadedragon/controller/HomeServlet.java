package com.jadedragon.controller;

import com.jadedragon.dao.CategoryDAO;
import com.jadedragon.dao.FoodDAO;
import com.jadedragon.model.FoodItem;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            FoodDAO foodDAO = new FoodDAO();
            CategoryDAO categoryDAO = new CategoryDAO();

            List<FoodItem> featured = foodDAO.findFeatured();
            List<FoodItem> popular = foodDAO.findPopular();

            request.setAttribute("featuredItems", featured);
            request.setAttribute("popularItems", popular);
            request.setAttribute("categories", categoryDAO.findAll());

            RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error/500.jsp");
        }
    }
}
