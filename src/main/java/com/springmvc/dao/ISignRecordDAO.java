package com.springmvc.dao;

import java.util.List;

import com.springmvc.model.SignRecord;

public interface ISignRecordDAO {
	
	public List<SignRecord> getAllSignRecordByCourse_id(int course_id);
	
	public List<SignRecord> getSignRecordByUser_id(int user_id);
	
	/**
	 * 获取某人某个时间段内的签到记录
	 * */
	public List<SignRecord> getOnesSignRecordBetweenStartDateANDEndDate(int user_id, int course_id, String start_date, String end_date);
	
	/**
	 * 通过设置迟到多少时间，
	 * 来获取某人在一门课中的迟到记录
	 * */
	public List<SignRecord> getOnesLateRecordByCourse_id(int user_id, int course_id, int shouldSignTime, int lateTime);
	
	/**
	 * 通过设置早退多少时间，
	 * 来获取某人在一门课中的早退记录
	 * */
	public List<SignRecord> getOnesEarlyLeaveRecordByCourse_id(int user_id, int course_id, int shouldSignTime, int earlyLeaveTime);
	
	public void insertSignRecord(SignRecord signRecord);
	
	public int updateSignInRecord(SignRecord signRecord);
	
	public int updateSignOutRecord(SignRecord signRecord);
	
}
