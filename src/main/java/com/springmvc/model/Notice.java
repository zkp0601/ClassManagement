package com.springmvc.model;

import java.io.Serializable;

public class Notice implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3174309937855841762L;
	private int notice_id;
	private int course_id;
	private String content;
	private String date;
	private String time;
	private String publisher;
	private int view_num;
	private String subject;
	private String end_date;
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public int getNotice_id() {
		return notice_id;
	}
	public void setNotice_id(int notice_id) {
		this.notice_id = notice_id;
	}
	public int getCourse_id() {
		return course_id;
	}
	public void setCourse_id(int course_id) {
		this.course_id = course_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public int getView_num() {
		return view_num;
	}
	public void setView_num(int view_num) {
		this.view_num = view_num;
	}
	
	
}
