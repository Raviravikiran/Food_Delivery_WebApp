package com.DAO.daoInterface;

import java.util.List;

import com.DAO.model.Restaurant;
public interface RestaurantDAO {
	
	void addRestaurant(Restaurant r);
	Restaurant getRestaurant(int id);
	void updateRestaurant(Restaurant r);
	void deleteRestaurant(Restaurant r);
	List<Restaurant> getAllRestaurant();
	
	
}
