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

@WebServlet("/MenuServlet")
public class MenuServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            FoodDAO foodDAO = new FoodDAO();
            CategoryDAO categoryDAO = new CategoryDAO();

            String catParam = request.getParameter("category");
            String search = request.getParameter("search");

            List<FoodItem> items;
            if (search != null && !search.trim().isEmpty()) {
                items = foodDAO.search(search.trim());
            } else if (catParam != null && !catParam.isEmpty()) {
                items = foodDAO.findByCategory(Integer.parseInt(catParam));
            } else {
                items = foodDAO.findAll();
            }

            request.setAttribute("foodItems", items);
            request.setAttribute("categories", categoryDAO.findAll());
            request.setAttribute("selectedCategory", catParam);
            request.setAttribute("searchKeyword", search);

            RequestDispatcher rd = request.getRequestDispatcher("menu.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error/500.jsp");
        }
    }
}
