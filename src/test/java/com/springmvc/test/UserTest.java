package com.springmvc.test;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.springmvc.model.User;
import com.springmvc.model.User_infos;
import com.springmvc.service.IUserService;
import com.springmvc.service.IUser_infosService;

public class UserTest {
	private IUserService userService = null;
	private IUser_infosService user_infosService = null;
	@Before
	public void before(){
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext(new String[]{"classpath:conf/spring.xml"
                ,"classpath:conf/spring-mybatis.xml"});
		userService = (IUserService) context.getBean("userServiceImpl");
		user_infosService = (IUser_infosService) context.getBean("user_infosServiceImpl");
	}
	
//	@Test
//	public void addUser(){
//		User user = new User();
//		user.setUsername("kalper");
//		user.setPassword("kalper");
//		userService.insertUser(user);
//	}
	
	@Test
	public void addUser_infos(){
		User_infos info = new User_infos("郑恺培", "12330417", "", "男", "8989", "753494474@qq.com", "");
		info.setUser_id(4);
		User_infos[] infos = user_infosService.selectUser_infosByIDs(new int[]{1,2});
		System.out.println(infos.length);
		//System.out.println( user_infosService.insertUser_infos(info) );
	}
}
