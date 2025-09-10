package com.Restaurant.Servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Map;

import com.DAO.daoImp.OrderDAOimpl;
import com.DAO.daoImp.OrderItemDAOimpl;
import com.DAO.model.Cart;
import com.DAO.model.CartItem;
import com.DAO.model.Order;
import com.DAO.model.OrderItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("place".equals(action)) {
            place(req, resp);
            return;
        }
        if ("cancel".equals(action)) {
            cancel(req, resp);
            return;
        }
        resp.sendRedirect("Cart.jsp");
    }

    private void place(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            // not logged in → send to login page
            resp.sendRedirect("Login.jsp");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        Integer restaurantId = (Integer) session.getAttribute("restaurantId");
        
        //Checking the cart that have a items init.
        if (cart == null || cart.getItems().isEmpty() || restaurantId == null) {
            resp.sendRedirect("Cart.jsp");
            return;
        }

        int total = 0;
        for (CartItem ci : cart.getItems().values()) {
            total += ci.getQuantity() * ci.getPrice();
        }

        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String landmark = req.getParameter("landmark");
        String payment = req.getParameter("paymentMode");
        if (payment == null || payment.isEmpty()) payment = "COD";
        
        // Combine address with landmark if provided
        String fullAddress = address;
        if (landmark != null && !landmark.trim().isEmpty()) {
            fullAddress += " (Near: " + landmark.trim() + ")";
        }

        OrderDAOimpl orderDAO = new OrderDAOimpl();
        OrderItemDAOimpl itemDAO = new OrderItemDAOimpl();

        //timestamp value created
        Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
        
        Order order = new Order(0, userId, restaurantId, currentTimestamp, total, "CONFIRMED", payment, fullAddress);
        int orderId = orderDAO.createOrder(order);

        for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
            CartItem ci = entry.getValue();
            int lineTotal = ci.getQuantity() * ci.getPrice();
            itemDAO.addItem(new OrderItem(0, orderId, ci.getCartitemID(), ci.getQuantity(), lineTotal));
        }

        // clear cart
        session.removeAttribute("cart");
        // keep restaurantId so returning to menu works if desired

        resp.sendRedirect("OrderConfirmation.jsp?orderId=" + orderId);
    }

    private void cancel(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        int orderId = Integer.parseInt(req.getParameter("orderId"));
        OrderDAOimpl orderDAO = new OrderDAOimpl();
        com.DAO.model.Order order = orderDAO.getOrder(orderId);
        if (order == null || order.getUserId() != userId) {
            resp.sendRedirect("OrderHistory.jsp");
            return;
        }
        String status = order.getStatus();
        // Allow cancel only if CONFIRMED or PREPARING
        if ("CONFIRMED".equalsIgnoreCase(status) || "PREPARING".equalsIgnoreCase(status)) {
            orderDAO.updateStatus(orderId, "CANCELLED");
        }
        resp.sendRedirect("OrderHistory.jsp");
    }
}


