package com.DAO.daoInterface;

import java.util.List;

import com.DAO.model.User;

public interface UserDAO {

	void addUser(User user);
	void updateUser(User user);
	void deleteuser(User user);
	User getUser(int id);
	List<User> getAllUser();
	User getUserByEmailAndPassword(String email, String password);
	
}
