package com.springmvc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.springmvc.model.Notice;

public interface INoticeDAO {
	
	public List<Notice> getNoticeByCourse_id(int course_id);
	
	public void insertNotice(Notice notice);
	
	public int updateNotice(Notice notice);
	
	public void deleteNotice(int notice_id);
	
	public int updateContentAndSubjectById(@Param("notice_id")int notice_id, @Param("content")String content, @Param("subject") String subject);
	
	public List<Notice> getNoticesByCourse_ids(int[] course_ids);
}
