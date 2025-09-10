package com.DAO.daoInterface;

import java.util.List;

import com.DAO.model.Menu;

public interface MenuDAO {

	void addMenu(Menu m);
	Menu getMenu(int id);
	void updateMenu(Menu m);
	void deleteMenu(Menu m);
	List<Menu> getAllMenu();
	List<Menu> getAllMenubyRestaurant(int restaurantID);
	
}
