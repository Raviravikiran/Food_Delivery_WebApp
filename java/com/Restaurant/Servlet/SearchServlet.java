package com.Restaurant.Servlet;

import java.io.IOException;
import java.util.List;

import com.DAO.daoImp.RestaurantDAOimpl;
import com.DAO.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String location = req.getParameter("location");
        String query = req.getParameter("query");
        
        RestaurantDAOimpl restaurantDAO = new RestaurantDAOimpl();
        List<Restaurant> searchResults = null;
        
        if (query != null && !query.trim().isEmpty()) {
            // Search by restaurant name, cuisine type, or location
            searchResults = restaurantDAO.searchRestaurants(query);
        } else if (location != null && !location.trim().isEmpty()) {
            // Search by location
            searchResults = restaurantDAO.searchByLocation(location);
        } else {
            // If no search criteria, get all restaurants
            searchResults = restaurantDAO.getAllRestaurant();
        }
        
        req.setAttribute("AllRestaurants", searchResults);
        req.setAttribute("searchQuery", query);
        req.setAttribute("searchLocation", location);
        
        req.getRequestDispatcher("Restaurant.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
