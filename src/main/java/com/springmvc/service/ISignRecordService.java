package com.springmvc.service;

import java.util.List;

import com.springmvc.model.SignRecord;

public interface ISignRecordService {
	
	public List<SignRecord> getAllSignRecordByCourse_id(int course_id);
	
	public List<SignRecord> getSignRecordByUser_id(int user_id);
	
	/**
	 * 获取某人某个时间段内的签到记录
	 * */
	public List<SignRecord> getOnesSignRecordBetweenStartDateANDEndDate(int user_id, int course_id, String start_date, String end_date);
	
	public List<SignRecord> getOnesLateRecordByCourse_id(int user_id, int course_id, int shouldSignTime, int lateTime);
	
	public List<SignRecord> getOnesEarlyLeaveRecordByCourse_id(int user_id, int course_id, int shouldSignTime, int earlyLeaveTime);
	
	public List<SignRecord> getOnesAllSignRecordByUser_idANDCourse_id(int user_id, int course_id);
	
	public void insertSignRecord(SignRecord signRecord);
	
	public int updateSignInRecord(SignRecord signRecord);
	
	public int updateSignOutRecord(SignRecord signRecord);
}
