package com.springmvc.dao;

import java.util.Map;

import com.springmvc.model.User;

public interface IUserDAO {
	/**
	 * 添加新用户
	 * @param user
	 * @return
	 */
	public void insertUser(User user);
	
	/** 通过账号密码查询用户 */
	public Map selectUserByUser(User user);
	
	/** 通过id查找用户 */
	public String selectUser_nameById(int user_id);
	
	/** 通过id删除用户 */
	public void deleteUserById(int id);
	
	/** 根据id更新用户 */
	public void updateUserById(int id);
}
