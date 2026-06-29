package com.jadedragon.controller.admin;

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
import java.math.BigDecimal;

@WebServlet("/AdminMenuServlet")
public class AdminMenuServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        FoodDAO foodDAO = new FoodDAO();

        if ("edit".equals(action)) {
            int foodId = Integer.parseInt(request.getParameter("id"));
            FoodItem item = foodDAO.findById(foodId);
            request.setAttribute("editItem", item);
        }

        request.setAttribute("foodItems", foodDAO.findAllAdmin());
        request.setAttribute("categories", new CategoryDAO().findAll());
        RequestDispatcher rd = request.getRequestDispatcher("admin/menu-items.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        FoodDAO foodDAO = new FoodDAO();

        if ("add".equals(action) || "update".equals(action)) {
            FoodItem item = new FoodItem();
            item.setName(request.getParameter("name"));
            item.setNameCn(request.getParameter("nameCn"));
            item.setDescription(request.getParameter("description"));
            item.setIngredients(request.getParameter("ingredients"));
            item.setNutritionalInfo(request.getParameter("nutritionalInfo"));
            item.setPrice(new BigDecimal(request.getParameter("price")));
            item.setImageUrl(request.getParameter("imageUrl"));
            item.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            item.setFeatured("on".equals(request.getParameter("isFeatured")));
            item.setPopular("on".equals(request.getParameter("isPopular")));
            item.setAvailable("on".equals(request.getParameter("isAvailable")));

            if ("add".equals(action)) {
                foodDAO.add(item);
            } else {
                item.setFoodId(Integer.parseInt(request.getParameter("foodId")));
                foodDAO.update(item);
            }
        } else if ("delete".equals(action)) {
            int foodId = Integer.parseInt(request.getParameter("foodId"));
            foodDAO.delete(foodId);
        } else if ("toggle".equals(action)) {
            int foodId = Integer.parseInt(request.getParameter("foodId"));
            FoodItem item = foodDAO.findById(foodId);
            if (item != null) {
                item.setAvailable(!item.isAvailable());
                foodDAO.update(item);
            }
        }

        response.sendRedirect("AdminMenuServlet");
    }
}
