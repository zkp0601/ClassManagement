package com.springmvc.service;
import java.util.List;
import java.util.Map;

import com.springmvc.model.User;

public interface IUserService {
	
	/** 用户注册 */
	public void insertUser(User user);
	
	/** 通过 User 对象查询用户 */
	public Map selectUserByUser(User user);
	
	/** 通过 id 删除用户 */
	public void deleteUserById(int user_id);
	
	/** 通过user_id查找用户 */
	public String selectUser_nameById(int user_id);
	
	/** 根据id更新用户 */
	public void updateUserById(int user_id);
	
	public List<User> selectUser_namesByIds(int[] user_ids);
}
