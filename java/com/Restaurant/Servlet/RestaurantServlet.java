package com.Restaurant.Servlet;

import java.io.IOException;
import java.util.List;

import com.DAO.daoImp.RestaurantDAOimpl;
import com.DAO.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/GetAllResturantsServlet")
public class RestaurantServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			RestaurantDAOimpl r =new RestaurantDAOimpl();
			List<Restaurant>allRestaurants = r.getAllRestaurant();
			
			
			req.setAttribute("AllRestaurants",allRestaurants);
			
			RequestDispatcher rd=req.getRequestDispatcher("/Restaurant.jsp");
			rd.forward(req, resp);
			
		} catch (Exception e) {

		e.printStackTrace();
		}
		
		
	}

}
