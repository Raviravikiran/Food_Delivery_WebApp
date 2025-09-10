package com.Restaurant.Servlet;

import java.io.IOException;
import java.util.List;

import com.DAO.daoImp.MenuDAOimpl;
import com.DAO.model.Cart;
import com.DAO.model.CartItem;
import com.DAO.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callfromMenu")
public class CartServlet extends HttpServlet{
 
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//Creating a session
		HttpSession session = req.getSession();
		
		//creating a cart in session
		Cart cart = (Cart)session.getAttribute("cart");
		
		//Getting a restId from menu
		Integer currentRestaurantID = (Integer)session.getAttribute("restaurantId");
		String restaurantParam = req.getParameter("restaurantId");
		
		Integer newRestaurantID = null;
		
		
		if (restaurantParam != null && !restaurantParam.isEmpty()) {
			try { newRestaurantID = Integer.parseInt(restaurantParam); } catch (NumberFormatException ignored) {}
		}
		
		if (cart == null) {
			cart = new Cart();
			session.setAttribute("cart", cart);
		}
		
		if (currentRestaurantID == null && newRestaurantID != null) {
			session.setAttribute("restaurantId", newRestaurantID);
		} else if (currentRestaurantID != null && newRestaurantID != null && !newRestaurantID.equals(currentRestaurantID)) {
			// switching restaurants resets cart
			cart = new Cart();
			session.setAttribute("cart", cart);
			session.setAttribute("restaurantId", newRestaurantID);
		}

		
		String action = req.getParameter("action");
		String from = req.getParameter("from");
		try {
		
			if("add".equals(action)) {
				addItemToCArt(req,cart);
			}else if("update".equals(action)) {
				updateCartItem(req,cart);
			}else if("remove".equals(action)) {
				removeItemFromCart(req,cart);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		
		}
		
		if ("cart".equals(from)) {
			resp.sendRedirect("Cart.jsp");
		} else {
			Integer rid = newRestaurantID != null ? newRestaurantID : (Integer) session.getAttribute("restaurantId");
			if (rid != null) {
				resp.sendRedirect("menus?restaurantId=" + rid);
			} else {
				resp.sendRedirect("Cart.jsp");
			}
		}
	}

	private void removeItemFromCart(HttpServletRequest req, Cart cart) {

		int itemId = Integer.parseInt(req.getParameter("itemID"));
		cart.removeItem(itemId);
		
	}

	private void updateCartItem(HttpServletRequest req, Cart cart) {

		int itemId = Integer.parseInt(req.getParameter("itemID"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		
		cart.updateItem(itemId, quantity);
		
	}

	private void addItemToCArt(HttpServletRequest req, Cart cart) {

		int itemId=Integer.parseInt(req.getParameter("itemID"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		
		
		MenuDAOimpl menuDAO = new MenuDAOimpl();
		Menu menuItem = menuDAO.getMenu(itemId);
		
		
		if(menuItem != null) {
			CartItem item = new CartItem(menuItem.getMenuID(),menuItem.getRestaurantID(),menuItem.getItemName(),quantity,menuItem.getPrice(), menuItem.getImagepath());
			
			cart.additem(item);
		}
	}
	
	
	
	
	
}
