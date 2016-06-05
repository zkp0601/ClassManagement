package com.springmvc.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springmvc.model.User;
import com.springmvc.model.User_infos;
import com.springmvc.service.IUserService;
import com.springmvc.service.IUser_infosService;

@Controller
@RequestMapping(value={"/login"})
public class LoginController extends BaseController {
	
	/** 账号登录验证 */
	@RequestMapping(value={"/", "", "/index"})
	public void index(HttpServletRequest request, HttpServletResponse response) throws Exception{
		IUserService userService = (IUserService) this.context.getBean("userServiceImpl");
		User user = new User();
		user.setUsername(request.getParameter("username"));
		user.setPassword(request.getParameter("password"));
		Map results = userService.selectUserByUser(user);
		
		if(results != null){
			// 设置Session
			int user_id = Integer.parseInt(results.get("user_id").toString());
			user.setId(user_id);
			request.getSession().setAttribute("currentUser", user);
			
			IUser_infosService user_infosService = (IUser_infosService) this.context.getBean("user_infosServiceImpl");
			User_infos user_info = user_infosService.selectUser_infosByID(user_id);
			request.getSession().setAttribute("currentUser_info", user_info);
			
			// 若学号为八位，则说明为学生，否则为教师
			if(user_info.getPersonal_num().length() == 8){
				request.getSession().setAttribute("is_teacher", false);
			}else{
				request.getSession().setAttribute("is_teacher", true);
			}
			response.sendRedirect("/ClassManagement/index");
		}
		else {
			response.sendRedirect("/ClassManagement/user/login?login_result=error"); //登录失败
		}
	}
}
