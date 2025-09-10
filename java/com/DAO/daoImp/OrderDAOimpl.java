package com.DAO.daoImp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.DAO.daoInterface.OrderDAO;
import com.DAO.model.Order;
import com.DAO.util.DbConnector;

public class OrderDAOimpl implements OrderDAO {

    private static final String INSERT_SQL ="INSERT INTO `order` (`userId`, `restaurantId`, `orderDate`, `totalAmount`, `status`, `paymentMode`, `Address`) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String LAST_ID_SQL = "SELECT LAST_INSERT_ID()";
    private static final String UPDATE_STATUS_SQL = "UPDATE `order` SET `status`=? WHERE `orderId`=?";
    private static final String GET_SQL = "SELECT * FROM `order` WHERE `orderId`=?";
    private static final String GET_BY_USER_SQL = "SELECT * FROM `order` WHERE `userId`=? ORDER BY `orderDate` DESC";

    
    //User placed a order that data create in DB..
    @Override
    public int createOrder(Order order) {
        Connection con = DbConnector.getConnection();
        int orderId = 0;
        try {
            PreparedStatement ps = con.prepareStatement(INSERT_SQL);
            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getRestaurantId());
            //Timestamp now = order.getOrderDate() != null ? order.getOrderDate() : new Timestamp(System.currentTimeMillis());
       
            ps.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            ps.setInt(4, order.getTotalAmount());
            ps.setString(5, order.getStatus());
            ps.setString(6, order.getPaymentMode());
            ps.setString(7, order.getAddress());
            ps.executeUpdate();

            ResultSet rs = con.createStatement().executeQuery(LAST_ID_SQL);
            if (rs.next()) {
                orderId = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderId;
    }

    //This only for Restaurant login...
    @Override
    public void updateStatus(int orderId, String status) {
        Connection con = DbConnector.getConnection();
        try {
            PreparedStatement ps = con.prepareStatement(UPDATE_STATUS_SQL);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    //Restaurant to find the client details like address etc...(Restaurant login)
    @Override
    public Order getOrder(int orderId) {
        Connection con = DbConnector.getConnection();
        Order o = null;
        try {
            PreparedStatement ps = con.prepareStatement(GET_SQL);
            ps.setInt(1, orderId);
            ResultSet r = ps.executeQuery();
            if (r.next()) {
                o = map(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return o;
    }
    
    
    //User get the order details in order history page...
    @Override
    public List<Order> getOrdersByUser(int userId) {
        Connection con = DbConnector.getConnection();
        List<Order> list = new ArrayList<>();
        try {
            PreparedStatement ps = con.prepareStatement(GET_BY_USER_SQL);
            ps.setInt(1, userId);
            ResultSet r = ps.executeQuery();
            while (r.next()) {
                list.add(map(r));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private Order map(ResultSet r) throws Exception {
        int orderId = r.getInt(1);
        int userId = r.getInt(2);
        int restaurantId = r.getInt(3);
        Timestamp orderDate = r.getTimestamp(4);
        int totalAmount = r.getInt(5);
        String status = r.getString(6);
        String paymentMode = r.getString(7);
        String address = r.getString(8);
        return new Order(orderId, userId, restaurantId, orderDate, totalAmount, status, paymentMode, address);
    }
}


