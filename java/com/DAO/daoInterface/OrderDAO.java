package com.DAO.daoInterface;

import java.util.List;

import com.DAO.model.Order;

public interface OrderDAO {

	int createOrder(Order order);
	void updateStatus(int orderId, String status);
	Order getOrder(int orderId);
	List<Order> getOrdersByUser(int userId);
}


