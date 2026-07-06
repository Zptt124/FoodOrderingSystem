package com.jadedragon.filter;

import com.jadedragon.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    private static final String[] PUBLIC_PATHS = {
        "/", "/index.jsp", "/home.jsp", "/menu.jsp", "/food-detail.jsp",
        "/register.jsp", "/login.jsp", "/about.jsp", "/contact.jsp", "/faq.jsp",
        "/HomeServlet", "/MenuServlet", "/FoodDetailServlet",
        "/RegisterServlet", "/LoginServlet", "/LogoutServlet", "/ContactServlet",
        "/css/", "/js/", "/images/", "/error/"
    };

    private static final String[] ADMIN_PATHS = {
        "/admin/", "/AdminServlet", "/AdminMenuServlet",
        "/AdminCategoryServlet", "/AdminOrderServlet"
    };

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        String path = request.getRequestURI().substring(request.getContextPath().length());

        // admin area check
        for (String adminPath : ADMIN_PATHS) {
            if (path.startsWith(adminPath)) {
                HttpSession session = request.getSession(false);
                if (session == null || session.getAttribute("user") == null) {
                    response.sendRedirect(request.getContextPath() + "/login.jsp?redirect=admin");
                    return;
                }
                User user = (User) session.getAttribute("user");
                if (!user.isAdmin()) {
                    response.sendRedirect(request.getContextPath() + "/home.jsp");
                    return;
                }
                break;
            }
        }

        // check if path is public
        boolean needsAuth = true;
        for (String publicPath : PUBLIC_PATHS) {
            if (path.startsWith(publicPath) || path.equals(publicPath)) {
                needsAuth = false;
                break;
            }
        }

        // static files
        if (path.contains(".") &&
            (path.endsWith(".css") || path.endsWith(".js") ||
             path.endsWith(".png") || path.endsWith(".jpg") ||
             path.endsWith(".gif") || path.endsWith(".svg") ||
             path.endsWith(".ico") || path.endsWith(".woff2"))) {
            needsAuth = false;
        }

        if (needsAuth) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}
