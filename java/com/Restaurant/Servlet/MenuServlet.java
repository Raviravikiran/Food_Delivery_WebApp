package com.Restaurant.Servlet;

import java.io.IOException;
import java.util.List;

import com.DAO.daoImp.MenuDAOimpl;
import com.DAO.daoImp.RestaurantDAOimpl;
import com.DAO.model.Menu;
import com.DAO.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/menus") // redirect from restaurant.jsp to view a menu for the restaurant.
public class MenuServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//Store the restaurantId come form Restaurant.jsp
			int restId = Integer.parseInt(req.getParameter("restaurantId"));

			//Creating a obj of MenuDAOimpl to get all menu from the Database,using RestaurantId for Restaurant.jsp
			MenuDAOimpl impl = new MenuDAOimpl();
			List<Menu> menubyrest = impl.getAllMenubyRestaurant(restId);
			
			//To get a Restaurant data for header so Creating a RestaurantDAOimp object,and get data using same RestaurantId
			RestaurantDAOimpl rest = new RestaurantDAOimpl();
			Restaurant restaurant = rest.getRestaurant(restId);
		
			//now store the data in request object to sent.
			req.setAttribute("menus", menubyrest);
			req.setAttribute("restDetalis", restaurant);
			
			//Now, sent all the data to the menu.jsp to view by user!.. 
			RequestDispatcher rd = req.getRequestDispatcher("/Menu.jsp");
			rd.forward(req, resp);

		} catch (Exception e) {

			e.printStackTrace();
		}

	}
}
