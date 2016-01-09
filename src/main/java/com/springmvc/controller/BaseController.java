package com.springmvc.controller;

import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.springmvc.model.User;

/** 基类控制器 */
public class BaseController {
	
	protected ApplicationContext context ;
	
	BaseController(){
		context = new ClassPathXmlApplicationContext(new String[]{"classpath:conf/spring.xml", "classpath:conf/spring-mybatis.xml"});
	}
	
	public User isSessionExists(HttpSession session){
		return (User) session.getAttribute("currentUser");
	}
}
