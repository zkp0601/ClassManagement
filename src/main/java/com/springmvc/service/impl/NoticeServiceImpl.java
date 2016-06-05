package com.springmvc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Service;

import com.springmvc.dao.INoticeDAO;
import com.springmvc.model.Notice;
import com.springmvc.service.INoticeService;

@Service
@Configuration
public class NoticeServiceImpl implements INoticeService{
	
	@Autowired
	private INoticeDAO noticeDAO;
	
	public List<Notice> getNoticeByCourse_id(int course_id){
		return noticeDAO.getNoticeByCourse_id(course_id);
	}
	
	public void insertNotice(Notice notice){
		noticeDAO.insertNotice(notice);
	}
	
	public int updateNotice(Notice notice){
		return noticeDAO.updateNotice(notice);
	}
	
	public void deleteNotice(int notice_id){
		noticeDAO.deleteNotice(notice_id);
	}
	
	public int updateContentAndSubjectById(int notice_id, String content, String subject){
		return noticeDAO.updateContentAndSubjectById(notice_id, content, subject);
	}
	
	public List<Notice> getNoticesByCourse_ids(int[] course_ids){
		return noticeDAO.getNoticesByCourse_ids(course_ids);
	}
}
