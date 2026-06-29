package com.jadedragon.controller.admin;

import com.jadedragon.dao.CategoryDAO;
import com.jadedragon.model.Category;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/AdminCategoryServlet")
public class AdminCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDAO dao = new CategoryDAO();
        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("editCategory", dao.findById(id));
        }

        request.setAttribute("categories", dao.findAll());
        RequestDispatcher rd = request.getRequestDispatcher("admin/categories.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        CategoryDAO dao = new CategoryDAO();
        Category cat = new Category();
        cat.setName(request.getParameter("name"));
        cat.setDescription(request.getParameter("description"));
        cat.setImageUrl(request.getParameter("imageUrl"));

        if ("add".equals(action)) {
            dao.add(cat);
        } else if ("update".equals(action)) {
            cat.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            dao.update(cat);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("categoryId"));
            dao.delete(id);
        }

        response.sendRedirect("AdminCategoryServlet");
    }
}
