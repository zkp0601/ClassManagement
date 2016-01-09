package com.springmvc.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.springmvc.model.User;
import com.springmvc.model.User_infos;
import com.springmvc.service.IUserService;
import com.springmvc.service.IUser_infosService;

@Controller
@RequestMapping("/register")
public class RegisterController extends BaseController{
	
	@RequestMapping(value={"/index"}, method=RequestMethod.POST)
	public String index(HttpServletRequest request, Model model){
		try{
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String name = request.getParameter("name");
			String sex = request.getParameter("sex")==null ? "" : request.getParameter("sex");
			String phone_num = request.getParameter("phone_num")==null ? "" : request.getParameter("phone_num");
			String personal_num = request.getParameter("personal_num")==null ? "" : request.getParameter("personal_num");
			String email = request.getParameter("email");
			
			IUser_infosService user_infosService = (IUser_infosService) this.context.getBean("user_infosServiceImpl");
			IUserService userService = (IUserService) this.context.getBean("userServiceImpl");

			// 插入用户登录名和密码至 user 表中
			User user = new User();
			user.setUsername(username);
			user.setPassword(password);
			userService.insertUser(user);
			
			// 插入用户信息至 user_infos 表中
			User_infos info = new User_infos();
			info.setName(name);
			info.setPersonal_num(personal_num);
			info.setCourseList("|");
			info.setSex(sex);
			info.setPhone_num(phone_num);
			info.setEmail(email);
			int info_insert_result = user_infosService.insertUser_infos(info);
			
			if( info_insert_result > 0 ){
				System.out.println("注册成功");
			}
			model.addAttribute("register", "register_success");
			return "success";
			
		}catch(Exception e){
			System.out.println(" Wrong accurs in function index of RegisterController!");
		}
		
		return "";
	}
}
