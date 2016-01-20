package com.springmvc.service;

import java.util.List;

import com.springmvc.model.Notice;

public interface INoticeService {
	public List<Notice> getNoticeByCourse_id(int course_id);
	
	public void insertNotice(Notice notice);
	
	public int updateNotice(Notice notice);
	
	public void deleteNotice(int notice_id);
	
	public int updateContentAndSubjectById(int notice_id, String content, String subject);
}
