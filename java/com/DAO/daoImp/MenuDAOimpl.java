package com.DAO.daoImp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.DAO.daoInterface.MenuDAO;
import com.DAO.model.Menu;
import com.DAO.util.DbConnector;

public class MenuDAOimpl implements MenuDAO {

	private String MENUADD_QUERY = "INSERT into `menu`(`menuID`,`restaurantID`,`itemName`,`description`,`price`,`ratings`,`isAvaliable`,`imagePath`)VALUES(?,?,?,?,?,?,?,?)";
	private String MENUBYID_QUERY = "SELECT * FROM `menu` WHERE `menuID`=?";
	private String UPDATE_QUERY = "UPDATE `menu` SET `itemName`= ?, `description`= ?, `price`= ?, `isAvaliable`= ?, `imagePath`= ? WHERE `menuID`= ? ";
	private String DELETE_QUERY = "DELETE FROM `menu`WHERE `menuID`=?";
	private String GETALLMENU_QUERY = "SELECT * FROM `menu`";
	private String MENUBYREST_QUERY = "SELECT * FROM `menu` WHERE `restaurantID`=?";

	@Override
	public void addMenu(Menu m) {

		Connection con = DbConnector.getConnection();
		try {

			PreparedStatement pstmt = con.prepareStatement(MENUADD_QUERY);
			pstmt.setInt(1, m.getMenuID());
			pstmt.setInt(2, m.getRestaurantID());
			pstmt.setString(3, m.getItemName());
			pstmt.setString(4, m.getDescription());
			pstmt.setInt(5, m.getPrice());
			pstmt.setFloat(6, m.getRatings());
			pstmt.setBoolean(7, m.isAvaliable());
			pstmt.setString(8, m.getImagepath());

			int res = pstmt.executeUpdate();
			System.out.println(res);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Menu getMenu(int id) {

		Connection con = DbConnector.getConnection();
		Menu m = new Menu();
		try {

			PreparedStatement pstmt = con.prepareStatement(MENUBYID_QUERY);
			pstmt.setInt(1, id);

			ResultSet res = pstmt.executeQuery();

			while (res.next()) {
				int mId = res.getInt(1);
				int resId = res.getInt(2);
				String itemname = res.getString(3);
				String desc = res.getString(4);
				int price = res.getInt(5);
				float rating = res.getFloat(6);
				boolean isavail = res.getBoolean(7);
				String img = res.getString(8);
				m = new Menu(mId, resId, itemname, desc, price, rating, isavail, img);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return m;
	}

	@Override
	public void updateMenu(Menu m) {
		Connection con = DbConnector.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(UPDATE_QUERY);

			pstmt.setString(1, m.getItemName());
			pstmt.setString(2, m.getDescription());
			pstmt.setInt(3, m.getPrice());
			pstmt.setBoolean(4, m.isAvaliable());
			pstmt.setString(5, m.getImagepath());

			pstmt.setInt(6, m.getMenuID());

			int res = pstmt.executeUpdate();
			System.out.println(res);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void deleteMenu(Menu m) {

		Connection con = DbConnector.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY);
			pstmt.setInt(1, m.getMenuID());

			System.out.println(pstmt.executeUpdate());

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	@Override
	public List<Menu> getAllMenu() {

		Connection con = DbConnector.getConnection();
		List<Menu> list = new ArrayList<Menu>();
		Menu me;
		try {
			PreparedStatement pstmt = con.prepareStatement(GETALLMENU_QUERY);
			ResultSet menures = pstmt.executeQuery();
			while (menures.next()) {
				int mId = menures.getInt(1);
				int resId = menures.getInt(2);
				String itemname = menures.getString(3);
				String desc = menures.getString(4);
				int price = menures.getInt(5);
				float rating = menures.getFloat(6);
				boolean isavail = menures.getBoolean(7);
				String img = menures.getString(8);

				me = new Menu(mId, resId, itemname, desc, price, rating, isavail, img);
				list.add(me);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<Menu> getAllMenubyRestaurant(int restaurantID) {
		Connection con = DbConnector.getConnection();
		List<Menu> list = new ArrayList<Menu>();
		Menu me;

		try {
			PreparedStatement pstmt = con.prepareStatement(MENUBYREST_QUERY);
			pstmt.setInt(1, restaurantID);

			ResultSet res = pstmt.executeQuery();

			while (res.next()) {
				int mId = res.getInt(1);
				int resId = res.getInt(2);
				String itemname = res.getString(3);
				String desc = res.getString(4);
				int price = res.getInt(5);
				float rating = res.getFloat(6);
				boolean isavail = res.getBoolean(7);
				String img = res.getString(8);
				me = new Menu(mId, resId, itemname, desc, price, rating, isavail, img);
				list.add(me);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

}
