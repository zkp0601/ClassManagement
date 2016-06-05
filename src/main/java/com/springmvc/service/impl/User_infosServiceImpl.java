package com.springmvc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Service;

import com.springmvc.dao.IUser_infosDAO;
import com.springmvc.model.User_infos;
import com.springmvc.service.IUser_infosService;

@Service
@Configuration
public class User_infosServiceImpl implements IUser_infosService{
	
	@Autowired
	private IUser_infosDAO user_infosDAO;
	
	public int insertUser_infos(User_infos info){
		return this.user_infosDAO.insertUser_infos(info);
	}
	
	public int updateUser_infosByID(User_infos info){
		return this.user_infosDAO.updateUser_infosByID(info);
	}
	
	public User_infos selectUser_infosByID(int user_id){
		return this.user_infosDAO.selectUser_infosByID(user_id);
	}

	public User_infos[] selectUser_infosByIDs(int user_ids[]){
		return this.user_infosDAO.selectUser_infosByIDs(user_ids);
	}
	
	public List<User_infos> selectUser_infosByCourse_id(int course_id){
		return this.user_infosDAO.selectUser_infosByCourse_id(course_id);
	}
	
	/** 通过多个course_id获取学生信息 */
	public List<User_infos> selectUser_infosByCourse_ids(int[] course_ids){
		return this.user_infosDAO.selectUser_infosByCourse_ids(course_ids);
	}
}
