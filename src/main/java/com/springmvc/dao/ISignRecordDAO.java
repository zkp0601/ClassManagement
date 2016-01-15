package com.springmvc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.springmvc.model.SignRecord;

public interface ISignRecordDAO {
	
	public List<SignRecord> getAllSignRecordByCourse_id(int course_id);
	
	public List<SignRecord> getSignRecordByUser_id(int user_id);
	
	public List<SignRecord> getOnesAllSignRecordByUser_idANDCourse_id(@Param("user_id")int user_id, @Param("course_id")int course_id);
	/**
	 * 获取某人某个时间段内的签到记录
	 * */
	public List<SignRecord> getOnesSignRecordBetweenStartDateANDEndDate(@Param("user_id")int user_id, @Param("course_id")int course_id, @Param("start_date")String start_date, @Param("end_date")String end_date);
	
	/**
	 * 通过设置迟到多少时间，
	 * 来获取某人在一门课中的迟到记录
	 * */
	public List<SignRecord> getOnesLateRecordByCourse_id(@Param("user_id") int user_id, @Param("course_id")int course_id, @Param("shouldSignTime")int shouldSignTime, @Param("lateTime") int lateTime);
	
	/**
	 * 通过设置早退多少时间，
	 * 来获取某人在一门课中的早退记录
	 * */
	public List<SignRecord> getOnesEarlyLeaveRecordByCourse_id(@Param(value="user_id")int user_id, @Param(value="course_id")int course_id, @Param(value="shouldSignTime")int shouldSignTime, @Param(value="earlyLeaveTime")int earlyLeaveTime);
	
	public void insertSignRecord(SignRecord signRecord);
	
	public int updateSignInRecord(SignRecord signRecord);
	
	public int updateSignOutRecord(SignRecord signRecord);
	
}
