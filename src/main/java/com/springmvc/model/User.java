package com.springmvc.model;

import java.io.Serializable;

/**
 *	用户表
 */
public class User implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5066801624574354190L;
	private int user_id;
	private String username;
	private String password;
	
//	public User(){
//		
//	}
//	public User(String username, String password){
//		this.username = username;
//		this.password = password;
//	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setId(int user_id) {
		this.user_id = user_id;
	}

}
