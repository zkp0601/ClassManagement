package com.springmvc.dao;

import java.util.List;

import com.springmvc.model.User_infos;

public interface IUser_infosDAO {
	
	/** 添加用户信息 */
	public int insertUser_infos(User_infos info);
	
	/** 通过id更新用户信息 */
	public int updateUser_infosByID(User_infos info);
	
	/** 通过id获取单个用户信息 */
	public User_infos selectUser_infosByID(int user_id);
	
	/** 通过ids获取多个用户信息 */
	public User_infos[] selectUser_infosByIDs(int user_ids[]);
	
	/** 通过course_id获取用户信息 */
	public List<User_infos> selectUser_infosByCourse_id(int course_id);
	
	/** 通过多个course_id获取学生信息 */
	public List<User_infos> selectUser_infosByCourse_ids(int[] course_ids);
	
}
