package com.DAO.daoInterface;

import java.util.List;

import com.DAO.model.OrderItem;

public interface OrderItemDAO {
    void addItem(OrderItem item);
    List<OrderItem> getItemsByOrder(int orderId);
}


