package controller;

import CRUD.User_CRUD;
import common.User_Bean;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        User_CRUD userDAO = new User_CRUD();
        User_Bean loggedInUser = userDAO.validateLogin(user, pass);

        if (loggedInUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", loggedInUser);

            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid username or password, please try again!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
