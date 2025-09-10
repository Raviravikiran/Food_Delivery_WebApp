package com.DAO.daoImp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.DAO.daoInterface.RestaurantDAO;
import com.DAO.model.Restaurant;
import com.DAO.util.DbConnector;

public class RestaurantDAOimpl implements RestaurantDAO{
	private String ADDRES_QUREY="INSERT into `restaurant`(`restaurantId`, `name`, `address`,`phone`,`rating`,`CusineType`,`isActive`,`eta`,`imagePath`)"
			+"VALUES (?,?,?,?,?,?,?,?,?)";
	private String GET_QUREY="SELECT * FROM `restaurant` WHERE `restaurantId`=?";
	private String UPDATE_QUERY="UPDATE `restaurant` SET `name`=?,`address`=?,`phone`=?,`rating`=?,`CusineType`=?,`isActive`=?,`eta`=?,`imagePath`=?WHERE `restaurantId`= ?";
	private String DELETE_QUERY="DELETE FROM `restaurant` WHERE `restaurantId` = ?";
	private String GETALLRESTAURANT_QUERY="SELECT * FROM `restaurant`;";
	private String SEARCH_RESTAURANTS_QUERY="SELECT * FROM `restaurant` WHERE `name` LIKE ? OR `CusineType` LIKE ? OR `address` LIKE ?";
	private String SEARCH_BY_LOCATION_QUERY="SELECT * FROM `restaurant` WHERE `address` LIKE ?";
	
	
	
	@Override
	public void addRestaurant(Restaurant r) {

		Connection con = DbConnector.getConnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(ADDRES_QUREY);
			pstmt.setInt(1, r.getRestaurantId());
			pstmt.setString(2, r.getName());
			pstmt.setString(3, r.getAddress());
			pstmt.setString(4, r.getPhone());
			pstmt.setFloat(5, r.getRating());
			pstmt.setString(6, r.getCusineType());
			pstmt.setBoolean(7, r.isActive());
			pstmt.setInt(8, r.getEta());
			pstmt.setString(9, r.getImagePath());
			
			int res = pstmt.executeUpdate();
			System.out.println(res);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Restaurant getRestaurant(int id) {
		Connection con = DbConnector.getConnection();
		Restaurant restaurant = new Restaurant();
		try {
			PreparedStatement pstmt = con.prepareStatement(GET_QUREY);
			pstmt.setInt(1, id);
			ResultSet res = pstmt.executeQuery();
			while(res.next()) {
				int rID = res.getInt(1);
				String rName = res.getString(2);
				String rAddress = res.getString(3);
				String rPhone = res.getString(4);
				float rRating = res.getFloat(5);
				String rCusinetype = res.getString(6);
				boolean risActive = res.getBoolean(7);
				int rETA = res.getInt(8);
				int rAdminId = res.getInt(9);
				String rimageURL = res.getString(10);
				
				restaurant = new Restaurant(rID, rName, rAddress, rPhone, rRating, rCusinetype, risActive, rETA, rAdminId, rimageURL) ;
			}
		} catch (Exception e) {
			e.printStackTrace();
	
		}
		
		return restaurant;
	}

	@Override
	public void updateRestaurant(Restaurant r) {

		Connection con = DbConnector.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(UPDATE_QUERY);
			pstmt.setString(1, r.getName());
			pstmt.setString(2, r.getAddress());
			pstmt.setString(3, r.getPhone());
			pstmt.setFloat(4, r.getRating());
			pstmt.setString(5,r.getCusineType());
			pstmt.setBoolean(6, r.isActive());
			pstmt.setInt(7,r.getEta());
			pstmt.setString(8, r.getImagePath());
			
			pstmt.setInt(9, r.getRestaurantId());
			
			int res = pstmt.executeUpdate();
			System.out.println(res);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteRestaurant(Restaurant r) {

		Connection con = DbConnector.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY);
			pstmt.setInt(1,r.getRestaurantId() );
			
			System.out.println(pstmt.executeUpdate());
		} catch (Exception e) {
			e.printStackTrace();
		
		}
		
	}

	@Override
	public List<Restaurant> getAllRestaurant() {
		Connection con = DbConnector.getConnection();
		List<Restaurant> list = new ArrayList<Restaurant>();
		Restaurant r;
		try {
			PreparedStatement pstmt = con.prepareStatement(GETALLRESTAURANT_QUERY);
			ResultSet res1 = pstmt.executeQuery();
			while(res1.next()) {
				int rID = res1.getInt(1);
				String rName = res1.getString(2);
				String rAddress = res1.getString(3);
				String rPhone = res1.getString(4);
				float rRating = res1.getFloat(5);
				String rCusinetype = res1.getString(6);
				boolean risActive = res1.getBoolean(7);
				int rETA = res1.getInt(8);
				int rAdminId = res1.getInt(9);
				String rimageURL = res1.getString(10);
				
				r = new Restaurant(rID, rName, rAddress, rPhone, rRating, rCusinetype, risActive, rETA, rAdminId, rimageURL) ;
				list.add(r);
			}
		} catch (Exception e) {
			e.printStackTrace();
		
		}
		
		
		return list;
	}
	
	// Search restaurants by name, cuisine type, or address
	public List<Restaurant> searchRestaurants(String query) {
		Connection con = DbConnector.getConnection();
		List<Restaurant> list = new ArrayList<Restaurant>();
		Restaurant r;
		try {
			PreparedStatement pstmt = con.prepareStatement(SEARCH_RESTAURANTS_QUERY);
			String searchPattern = "%" + query + "%";
			pstmt.setString(1, searchPattern);
			pstmt.setString(2, searchPattern);
			pstmt.setString(3, searchPattern);
			
			ResultSet res = pstmt.executeQuery();
			while(res.next()) {
				int rID = res.getInt(1);
				String rName = res.getString(2);
				String rAddress = res.getString(3);
				String rPhone = res.getString(4);
				float rRating = res.getFloat(5);
				String rCusinetype = res.getString(6);
				boolean risActive = res.getBoolean(7);
				int rETA = res.getInt(8);
				int rAdminId = res.getInt(9);
				String rimageURL = res.getString(10);
				
				r = new Restaurant(rID, rName, rAddress, rPhone, rRating, rCusinetype, risActive, rETA, rAdminId, rimageURL);
				list.add(r);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// Search restaurants by location
	public List<Restaurant> searchByLocation(String location) {
		Connection con = DbConnector.getConnection();
		List<Restaurant> list = new ArrayList<Restaurant>();
		Restaurant r;
		try {
			PreparedStatement pstmt = con.prepareStatement(SEARCH_BY_LOCATION_QUERY);
			String searchPattern = "%" + location + "%";
			pstmt.setString(1, searchPattern);
			
			ResultSet res = pstmt.executeQuery();
			while(res.next()) {
				int rID = res.getInt(1);
				String rName = res.getString(2);
				String rAddress = res.getString(3);
				String rPhone = res.getString(4);
				float rRating = res.getFloat(5);
				String rCusinetype = res.getString(6);
				boolean risActive = res.getBoolean(7);
				int rETA = res.getInt(8);
				int rAdminId = res.getInt(9);
				String rimageURL = res.getString(10);
				
				r = new Restaurant(rID, rName, rAddress, rPhone, rRating, rCusinetype, risActive, rETA, rAdminId, rimageURL);
				list.add(r);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	

}
