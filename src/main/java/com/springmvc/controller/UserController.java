package com.springmvc.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.model.Message;
import com.springmvc.model.User;
import com.springmvc.model.User_infos;
import com.springmvc.service.IMessageService;
import com.springmvc.service.IUserService;
import com.springmvc.service.IUser_infosService;

@Controller
@RequestMapping(value={"/user"})
public class UserController extends BaseController{
	
	@RequestMapping("/login")
	public String login(HttpServletRequest request, Model model){
		String login_result = request.getParameter("login_result");
		if(login_result != null)
			model.addAttribute("login_result", false);
		return "login";
	}
	
	@RequestMapping("/register")
	public String register(){
		
		return "register";
	}
	
	@RequestMapping("/profile")
	public String profile(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException{
		// 当前查看的用户id
		String request_id = request.getParameter("user_id");
		User currentUser = (User) request.getSession().getAttribute("currentUser");
		if(currentUser == null){
			response.sendRedirect("/ClassManagement/user/login");
			return "login";
		}
		
		int currentUser_id = currentUser.getUser_id();
		int user_id = currentUser_id;
		if( !(request_id == null)){
			try{
				user_id = Integer.parseInt(request_id);
			}catch(Exception e){
				return "404_error";
			}
		}
		
		// user_id参数为空或者与当前用户id相同时，说明是查看自己信息
		model.addAttribute("user_name", currentUser.getUsername());
		if( request_id==null || currentUser_id == user_id){
			model.addAttribute("myself", true);
			model.addAttribute("target_user_name", currentUser.getUsername());
		}else{
			IUserService userService = (IUserService) this.context.getBean("userServiceImpl");
			String user_name = userService.selectUser_nameById(user_id);
			// 所要查看的用户不存在
			if(user_name == null)
				return "404_error";
			model.addAttribute("target_user_name", user_name);
		}
		IUser_infosService user_infosService = (IUser_infosService) this.context.getBean("user_infosServiceImpl");
		User_infos user_info = user_infosService.selectUser_infosByID(user_id);
		model.addAttribute("target_user_info", user_info);
		model.addAttribute("user_info", request.getSession().getAttribute("currentUser_info"));
		
		return "user_profile";
	}
	
	@RequestMapping("/chatting")
	public String chatting(HttpServletRequest request, Model model){
		User user = (User) request.getSession().getAttribute("currentUser");
		int sender_id = user.getUser_id();
		int receiver_id = Integer.parseInt(request.getParameter("receiver_id").toString());
		model.addAttribute("user", user);
		
		IUserService userService = (IUserService) this.context.getBean("userServiceImpl");
		String receiver_name = userService.selectUser_nameById(receiver_id);
		model.addAttribute("receiver_name", receiver_name);
		
		IUser_infosService user_infosService = (IUser_infosService) this.context.getBean("user_infosServiceImpl");
		model.addAttribute("sender_info", user_infosService.selectUser_infosByID(sender_id));
		model.addAttribute("receiver_info", user_infosService.selectUser_infosByID(receiver_id));
		
		IMessageService messageService = (IMessageService)this.context.getBean("messageServiceImpl");
		List<Message> allMessages = messageService.selectMessagesBySenderAndReceiverId(sender_id, receiver_id);
		model.addAttribute("allMessages", allMessages);
		return "chatting_room";
	}
	
	@ResponseBody
	@RequestMapping(value={"/updateProfile"}, method=RequestMethod.POST)
	public String updateProfile(HttpServletRequest request){
		String sex = request.getParameter("sex").toString();
		String phone_num = request.getParameter("phone_num").toString();
		String email = request.getParameter("email").toString();
		
		// 获取session中的当前用户, 更新用户个人信息
		try{
			User currentUser = (User) request.getSession().getAttribute("currentUser");
			int user_id = currentUser.getUser_id();
			IUser_infosService user_infosService = (IUser_infosService) this.context.getBean("user_infosServiceImpl");
			User_infos user_info = user_infosService.selectUser_infosByID(user_id);
			user_info.setSex(sex);
			user_info.setEmail(email);
			user_info.setPhone_num(phone_num);
			user_infosService.updateUser_infosByID(user_info);
		}catch(Exception e){
			return "false";
		}
		return "true";
	}
	
	@RequestMapping("/logout")
	public void logout(HttpSession session, HttpServletResponse response) throws Exception{
		User user = (User) session.getAttribute("currentUser");
		session.removeAttribute("currentUser");
		response.sendRedirect("/ClassManagement/user/login");
	}
		
	@RequestMapping("/getCurrentUserFromSession")
	@ResponseBody
	public User getCurrentUserFromSession(HttpServletRequest request){
		String attribute = request.getParameter("attribute").toString();
		Object object = request.getSession().getAttribute(attribute);
		User user = null;
		if(object != null)
			user = (User) object;
		
		return user;
	}
}


