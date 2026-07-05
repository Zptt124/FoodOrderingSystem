package com.jadedragon.controller;

import com.jadedragon.dao.FoodDAO;
import com.jadedragon.model.CartItem;
import com.jadedragon.model.FoodItem;
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

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?redirect=cart.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("remove".equals(action)) {
            removeItem(request, response);
            return;
        }
        if ("update".equals(action)) {
            updateItem(request, response);
            return;
        }
        if ("clear".equals(action)) {
            session.setAttribute("cart", null);
            session.setAttribute("cartCount", 0);
            session.setAttribute("cartTotal", java.math.BigDecimal.ZERO);
            response.sendRedirect("cart.jsp");
            return;
        }

        // Pre-compute cart summary data in the servlet (not in JSP scriptlets).
        // This follows Chapter 6 best practice: keep Java logic out of JSP.
        computeCartSummary(session, request);

        RequestDispatcher rd = request.getRequestDispatcher("cart.jsp");
        rd.forward(request, response);
    }

    /**
     * Pre-computes cart summary values and stores them as request attributes
     * so cart.jsp can use EL/JSTL instead of Java scriptlets.
     * Chapter 6 best practice: JSP is for display, Java logic goes in servlets.
     */
    private void computeCartSummary(HttpSession session, HttpServletRequest request) {
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("cartSubtotal", java.math.BigDecimal.ZERO);
            request.setAttribute("deliveryFee", new java.math.BigDecimal("3.00"));
            request.setAttribute("cartTotal", java.math.BigDecimal.ZERO);
            request.setAttribute("isFreeDelivery", false);
            request.setAttribute("amountToFree", new java.math.BigDecimal("50.00"));
            return;
        }

        java.math.BigDecimal subtotal = cart.stream()
                .map(CartItem::getSubtotal)
                .reduce(java.math.BigDecimal.ZERO, java.math.BigDecimal::add);

        java.math.BigDecimal freeThreshold = new java.math.BigDecimal("50.00");
        java.math.BigDecimal deliveryFee = subtotal.compareTo(freeThreshold) > 0
                ? java.math.BigDecimal.ZERO
                : new java.math.BigDecimal("3.00");
        java.math.BigDecimal total = subtotal.add(deliveryFee);
        boolean isFreeDelivery = subtotal.compareTo(freeThreshold) > 0;
        java.math.BigDecimal amountToFree = isFreeDelivery
                ? java.math.BigDecimal.ZERO
                : freeThreshold.subtract(subtotal);

        request.setAttribute("cartSubtotal", subtotal);
        request.setAttribute("deliveryFee", deliveryFee);
        request.setAttribute("cartTotal", total);
        request.setAttribute("isFreeDelivery", isFreeDelivery);
        request.setAttribute("amountToFree", amountToFree);
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
        if ("add".equals(action)) {
            addToCart(request, response, session);
        } else {
            response.sendRedirect("cart.jsp");
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        try {
            int foodId = Integer.parseInt(request.getParameter("foodId"));
            int quantity = 1;
            try { quantity = Integer.parseInt(request.getParameter("quantity")); } catch (Exception ignored) {}
            if (quantity < 1) quantity = 1;

            String addOns = request.getParameter("addOns");
            if (addOns == null) addOns = "";

            FoodDAO foodDAO = new FoodDAO();
            FoodItem food = foodDAO.findById(foodId);
            if (food == null || !food.isAvailable()) {
                response.sendRedirect("menu.jsp?error=unavailable");
                return;
            }

            // Calculate unit price including add-on surcharge
            // e.g. "Extra Chili (+RM 1)" → base price + RM 1
            BigDecimal surcharge = CartItem.parseAddOnSurcharge(addOns);
            BigDecimal effectivePrice = food.getPrice().add(surcharge);

            @SuppressWarnings("unchecked")
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            // Check if same item with same add-ons already in cart
            boolean found = false;
            for (CartItem item : cart) {
                if (item.getFoodId() == foodId &&
                    ((addOns.isEmpty() && (item.getAddOns() == null || item.getAddOns().isEmpty())) ||
                     addOns.equals(item.getAddOns()))) {
                    item.setQuantity(item.getQuantity() + quantity);
                    found = true;
                    break;
                }
            }

            if (!found) {
                cart.add(new CartItem(foodId, food.getName(),
                        effectivePrice, quantity, addOns));
            }

            session.setAttribute("cart", cart);
            session.setAttribute("cartCount", getCartCount(cart));
            session.setAttribute("cartTotal", getCartTotal(cart));

            response.sendRedirect("menu.jsp?added=" + foodId);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("menu.jsp?error=add");
        }
    }

    private void removeItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null) {
            int foodId = Integer.parseInt(request.getParameter("foodId"));
            cart.removeIf(item -> item.getFoodId() == foodId);
            session.setAttribute("cart", cart.isEmpty() ? null : cart);
            session.setAttribute("cartCount", getCartCount(cart));
            session.setAttribute("cartTotal", getCartTotal(cart));
        }
        response.sendRedirect("cart.jsp");
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null) {
            int foodId = Integer.parseInt(request.getParameter("foodId"));
            int qty = Integer.parseInt(request.getParameter("quantity"));
            if (qty <= 0) {
                cart.removeIf(item -> item.getFoodId() == foodId);
            } else {
                for (CartItem item : cart) {
                    if (item.getFoodId() == foodId) {
                        item.setQuantity(qty);
                        break;
                    }
                }
            }
            session.setAttribute("cart", cart.isEmpty() ? null : cart);
            session.setAttribute("cartCount", getCartCount(cart));
            session.setAttribute("cartTotal", getCartTotal(cart));
        }
        response.sendRedirect("cart.jsp");
    }

    private int getCartCount(List<CartItem> cart) {
        return cart.stream().mapToInt(CartItem::getQuantity).sum();
    }

    private BigDecimal getCartTotal(List<CartItem> cart) {
        return cart.stream()
                .map(CartItem::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
}
