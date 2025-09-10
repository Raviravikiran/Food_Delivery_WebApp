package com.Restaurant.Servlet;

import java.io.IOException;

import com.DAO.daoImp.UserDAOimpl;
import com.DAO.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        
        UserDAOimpl userDAO = new UserDAOimpl();
        User user = userDAO.getUserByEmailAndPassword(email, password);
        
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userName", user.getUsername());
            session.setAttribute("userEmail", user.getEmail());
            
            String redirectTo = req.getParameter("redirectTo");
            if (redirectTo != null && !redirectTo.isEmpty()) {
                resp.sendRedirect(redirectTo);
            } else {
                resp.sendRedirect("GetAllResturantsServlet");
            }
        } else {
            req.setAttribute("error", "Invalid email or password");
            req.getRequestDispatcher("Login.jsp").forward(req, resp);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("Login.jsp");
    }
}
