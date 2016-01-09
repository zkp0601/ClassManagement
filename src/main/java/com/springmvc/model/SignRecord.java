package com.springmvc.model;

public class SignRecord {
	private int user_id;
	private int course_id;
	private String sign_date;
	private int signInTime;
	private int signOutTime;
	
	public SignRecord(int user_id, int course_id, String sign_date, int signInTime, int signOutTime){
		this.user_id = user_id;
		this.course_id = course_id;
		this.sign_date = sign_date;
		this.signInTime = signInTime;
		this.signOutTime = signOutTime;
	}
	
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getCourse_id() {
		return course_id;
	}
	public void setCourse_id(int course_id) {
		this.course_id = course_id;
	}
	public String getSign_date() {
		return sign_date;
	}
	public void setSign_date(String sign_date) {
		this.sign_date = sign_date;
	}
	public int getSignInTime() {
		return signInTime;
	}
	public void setSignInTime(int signInTime) {
		this.signInTime = signInTime;
	}
	public int getSignOutTime() {
		return signOutTime;
	}
	public void setSignOutTime(int signOutTime) {
		this.signOutTime = signOutTime;
	}
	
	
}
