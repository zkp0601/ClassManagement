package com.springmvc.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.service.IMessageService;

@Controller
@RequestMapping(value={"/message"})
public class MessageController extends BaseController{
	
	@RequestMapping(value={"/updateUnreadStatus"})
	@ResponseBody
	public void updateUnreadStatus(HttpServletRequest request){
		int sender_id = Integer.parseInt(request.getParameter("sender_id").toString());
		int receiver_id = Integer.parseInt(request.getParameter("receiver_id").toString());
		
		IMessageService messageService = (IMessageService) this.context.getBean("messageServiceImpl");
		messageService.updateUnreadMessage(sender_id, receiver_id);
	}
}
