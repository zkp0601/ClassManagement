package com.springmvc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Service;

import com.springmvc.dao.ISignRecordDAO;
import com.springmvc.model.SignRecord;
import com.springmvc.service.ISignRecordService;

@Service
@Configuration
public class SignRecordServiceImpl implements ISignRecordService{
	
	@Autowired
	private ISignRecordDAO signRecordDAO;
	
	public List<SignRecord> getAllSignRecordByCourse_id(int course_id){
		return signRecordDAO.getAllSignRecordByCourse_id(course_id);
	}
	
	public List<SignRecord> getSignRecordByUser_id(int user_id){
		return signRecordDAO.getSignRecordByUser_id(user_id);
	}
	
	/**
	 * 获取某人某个时间段内的签到记录
	 * */
	public List<SignRecord> getOnesSignRecordBetweenStartDateANDEndDate(int user_id, int course_id, String start_date, String end_date){
		return signRecordDAO.getOnesSignRecordBetweenStartDateANDEndDate(user_id, course_id, start_date, end_date);
	}
	
	/** 
	 * 获取某课程的迟到记录
	 **/
	public List<SignRecord> getOnesLateRecordByCourse_id(int user_id, int course_id, int shouldSignTime, int lateTime){
		return signRecordDAO.getOnesLateRecordByCourse_id(user_id, course_id, shouldSignTime, lateTime);
	}
	
	public List<SignRecord> getOnesEarlyLeaveRecordByCourse_id(int user_id, int course_id, int shouldSignTime, int earlyLeaveTime){
		return signRecordDAO.getOnesEarlyLeaveRecordByCourse_id(user_id, course_id, shouldSignTime, earlyLeaveTime);
	}
	
	public void insertSignRecord(SignRecord signRecord){
		signRecordDAO.insertSignRecord(signRecord);
	}
	
	public int updateSignInRecord(SignRecord signRecord){
		return signRecordDAO.updateSignInRecord(signRecord);
	}
	
	public int updateSignOutRecord(SignRecord signRecord){
		return signRecordDAO.updateSignOutRecord(signRecord);
	}
}
