package com.DAO.daoImp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.DAO.daoInterface.OrderItemDAO;
import com.DAO.model.OrderItem;
import com.DAO.util.DbConnector;

public class OrderItemDAOimpl implements OrderItemDAO {

    private static final String INSERT_SQL = "INSERT INTO `orderitem`(`orderId`,`menuID`,`quantity`,`totalPrice`) VALUES (?,?,?,?)";
    private static final String GET_BY_ORDER_SQL = "SELECT * FROM `orderitem` WHERE `orderId`=?";

    @Override
    public void addItem(OrderItem item) {
        Connection con = DbConnector.getConnection();
        try {
            PreparedStatement ps = con.prepareStatement(INSERT_SQL);
            ps.setInt(1, item.getOrderId());
            ps.setInt(2, item.getMenuID());
            ps.setInt(3, item.getQuantity());
            ps.setInt(4, item.getTotalPrice());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<OrderItem> getItemsByOrder(int orderId) {
        Connection con = DbConnector.getConnection();
        List<OrderItem> list = new ArrayList<>();
        try {
            PreparedStatement ps = con.prepareStatement(GET_BY_ORDER_SQL);
            ps.setInt(1, orderId);
            ResultSet r = ps.executeQuery();
            while (r.next()) {
                int orderItemId = r.getInt(1);
                int oId = r.getInt(2);
                int menuId = r.getInt(3);
                int qty = r.getInt(4);
                int total = r.getInt(5);
                list.add(new OrderItem(orderItemId, oId, menuId, qty, total));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}


