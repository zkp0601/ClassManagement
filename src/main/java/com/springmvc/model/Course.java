package com.springmvc.model;

public class Course {
	private int course_id;
	private String course_name;
	private String teacher_name;
	private String position;
	private String start_time;
	private String end_time;
	private String signInIP;
	
	public Course(){ }
	
	public Course(int course_id, String course_name, String teacher_name, String position, String start_time, String end_time, String signInIP){
		this.course_id = course_id;
		this.course_name = course_name;
		this.teacher_name = teacher_name;
		this.position = position;
		this.start_time = start_time;
		this.end_time = end_time;
		this.signInIP = signInIP;
	}

	public int getCourse_id() {
		return course_id;
	}

	public void setCourse_id(int course_id) {
		this.course_id = course_id;
	}

	public String getCourse_name() {
		return course_name;
	}

	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}

	public String getTeacher_name() {
		return teacher_name;
	}

	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public String getSignInIP() {
		return signInIP;
	}

	public void setSignInIP(String signInIP) {
		this.signInIP = signInIP;
	}
	
}
