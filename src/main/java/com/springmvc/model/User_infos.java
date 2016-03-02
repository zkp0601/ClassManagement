package com.springmvc.model;

public class User_infos {
	private int user_id;
	private String name;
	private String personal_num;
	private String courseList;
	private String sex;
	private String phone_num;
	private String email;
	private String img_url;
	
	public User_infos(){
		
	}
	public User_infos(String name, String personal_num, String courseList, String sex, String phone_num, String email, String img_URL){
		this.name = name;
		this.personal_num = personal_num;
		this.courseList = courseList;
		this.sex = sex;
		this.phone_num = phone_num;
		this.email = email;
		this.img_url = img_URL;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPersonal_num() {
		return personal_num;
	}
	public void setPersonal_num(String personal_num) {
		this.personal_num = personal_num;
	}
	public String getCourseList() {
		return courseList;
	}
	public void setCourseList(String courseList) {
		this.courseList = courseList;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getPhone_num() {
		return phone_num;
	}
	public void setPhone_num(String phone_num) {
		this.phone_num = phone_num;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setImg_url(String img_url){
		this.img_url = img_url;
	}
	public String getImg_url(){
		return img_url;
	}
}
