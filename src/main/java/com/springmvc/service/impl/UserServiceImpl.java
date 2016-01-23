package com.springmvc.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.springmvc.dao.IUserDAO;
import com.springmvc.model.User;
import com.springmvc.service.IUserService;

@Service
@Configuration
public class UserServiceImpl implements IUserService{
	
	@Autowired
	private IUserDAO userDAO;
	
	public void insertUser(User user){
		this.userDAO.insertUser(user);
	}
	
	//通过User对象获取账号密码，可用于登录验证
	public Map selectUserByUser(User user){
		return (Map) this.userDAO.selectUserByUser(user);
	}
	
	public void deleteUserById(int user_id){
		this.userDAO.deleteUserById(user_id);
	}
	
	public String selectUser_nameById(int user_id){
		return this.userDAO.selectUser_nameById(user_id);
	}
	
	public void updateUserById(int user_id){
		this.userDAO.updateUserById(user_id);
	}
	
	public List<User> selectUser_namesByIds(int[] user_ids){
		return userDAO.selectUser_namesByIds(user_ids);
	}
}
