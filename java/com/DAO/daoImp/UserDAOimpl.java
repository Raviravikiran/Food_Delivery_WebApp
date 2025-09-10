package com.DAO.daoImp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.DAO.daoInterface.UserDAO;
import com.DAO.model.User;
import com.DAO.util.DbConnector;

public class UserDAOimpl implements UserDAO{
	
	
	private String INSERT_QUERY="INSERT into `user`(`userId`,`Username`,`password`,`email`,`phone`,`Address`,`role`,`CreatedDate`,`lastLoginDate`)values(?,?,?,?,?,?,?,?,?)";
    private String GETALL_QUERY="SELECT * FROM `user` WHERE `userId`=?";
	private String UPDATE_QUERY="UPDATE `user` SET `Username`= ?, `password`= ?, `email`= ?, `phone`= ?, `Address`= ? WHERE `userId`= ? ";
	private String DELETE_USER_QUERY="DELETE FROM `user` WHERE `userId` = ?";
	private String GETALLUSER_QUERY="SELECT * FROM `user`";
    private String GET_BY_EMAIL_PWD_QUERY = "SELECT * FROM `user` WHERE `email`=? AND `password`=?";
;
	
	@Override
	public void addUser(User user) {
		try {
			Connection con = DbConnector.getConnection();
			
			PreparedStatement pstmt = con.prepareStatement(INSERT_QUERY);
			
			pstmt.setInt(1, user.getUserId());
			pstmt.setString(2, user.getUsername());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getEmail());
			pstmt.setString(5, user.getPhone());
			pstmt.setString(6, user.getAddress());
			pstmt.setString(7, user.getRole());
			pstmt.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
			pstmt.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
			
			int res = pstmt.executeUpdate();
			
			System.out.println(res);
			
		}
		
		
		catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void updateUser(User user) {

		Connection con = DbConnector.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(UPDATE_QUERY);
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getEmail());
			pstmt.setString(4, user.getPhone());
			pstmt.setString(5, user.getAddress());
			pstmt.setInt(6, user.getUserId());
			
			int res = pstmt.executeUpdate();
			System.out.println(res);
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteuser(User user) {
		Connection con = DbConnector.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(DELETE_USER_QUERY);
			pstmt.setInt(1, user.getUserId());
			
			System.out.println(pstmt.executeUpdate());
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}

	@Override
	public User getUser(int id) {
		Connection con = DbConnector.getConnection();
		User user= new User();
		try {
			PreparedStatement pstmt = con.prepareStatement(GETALL_QUERY);
			pstmt.setInt(1,id);
			ResultSet res = pstmt.executeQuery();
			
			while(res.next()) {
				int uid=res.getInt(1);
				String uName=res.getString(2);
				String pwd=res.getString(3);
				String email=res.getString(4);
				String phone=res.getString(5);
				String add=res.getString(6);
				String role=res.getString(7);
				Timestamp crTime=res.getTimestamp(8);
				Timestamp lastlogin=res.getTimestamp(9);
				user =new User(uid, uName, pwd, email, phone, add, role,crTime,lastlogin);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return user;
	}

	@Override
	public List<User> getAllUser() {
		Connection con = DbConnector.getConnection();
		List<User> list = new ArrayList<User>();
		User user;
		try {
			PreparedStatement pstmt = con.prepareStatement(GETALLUSER_QUERY);
			ResultSet res = pstmt.executeQuery();
			while (res.next()) {
				int uid=res.getInt(1);
				String uName=res.getString(2);
				String pwd=res.getString(3);
				String email=res.getString(4);
				String phone=res.getString(5);
				String add=res.getString(6);
				String role=res.getString(7);
				Timestamp crTime=res.getTimestamp(8);
				Timestamp lastlogin=res.getTimestamp(9);
				user =new User(uid, uName, pwd, email, phone, add, role,crTime,lastlogin);
				list.add(user);
			}
		} catch (Exception e) {

		}
		return list; 
	
	}

	@Override
	public User getUserByEmailAndPassword(String email, String password) {
		Connection con = DbConnector.getConnection();
		User user = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(GET_BY_EMAIL_PWD_QUERY);
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			ResultSet res = pstmt.executeQuery();
			if (res.next()) {
				int uid=res.getInt(1);
				String uName=res.getString(2);
				String pwd=res.getString(3);
				String em=res.getString(4);
				String phone=res.getString(5);
				String add=res.getString(6);
				String role=res.getString(7);
				Timestamp crTime=res.getTimestamp(8);
				Timestamp lastlogin=res.getTimestamp(9);
				user = new User(uid, uName, pwd, em, phone, add, role, crTime, lastlogin);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}

}
