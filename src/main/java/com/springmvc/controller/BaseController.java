package com.springmvc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.springmvc.model.Message;
import com.springmvc.model.Notice;
import com.springmvc.model.User;
import com.springmvc.model.User_infos;
import com.springmvc.service.IMessageService;
import com.springmvc.service.INoticeService;
import com.springmvc.service.IUser_infosService;

/** 基类控制器 */
public class BaseController {
	
	protected ApplicationContext context ;
	
	BaseController(){
		context = new ClassPathXmlApplicationContext(new String[]{"classpath:conf/spring.xml", "classpath:conf/spring-mybatis.xml"});
	}
	
	public User isSessionExists(HttpSession session){
		Object user = session.getAttribute("currentUser");
		if(user!=null)
			return (User) user;
		return null;
	}
	
	/** 获取用户的未读消息 */
	public Map<Integer, List<Message>> getUnreadMessageByReceiver_id(int receiver_id, int is_read){
		IMessageService messageService = (IMessageService) this.context.getBean("messageServiceImpl");
		List<Message> allMessages = messageService.selectMessagesByIs_read(receiver_id, is_read);
		Map<Integer, List<Message>> result = new HashMap<Integer, List<Message>>();
		for(int i = 0; i < allMessages.size(); i++){
			Message message = allMessages.get(i);
			int sender_id = message.getSender_id();
			if(result.containsKey(sender_id)){
				result.get(sender_id).add(message);
			}else{
				List<Message> temp = new ArrayList<Message>();
				temp.add(message);
				result.put(sender_id, temp);
			}
		}
		return result;
	}
	
	/** 获取用户所有课程的公告信息 */
	public Map<Integer, List<Notice>> getAllNoticesByUser_id(int user_id){
		Map<Integer, List<Notice>> result = new HashMap<Integer, List<Notice>>();
		
		/** 获取当前用户的所有课程 */
		IUser_infosService user_infoService = (IUser_infosService) context.getBean("user_infosServiceImpl");
		User_infos user_info = user_infoService.selectUser_infosByID(user_id);
		String[] course_list = user_info.getCourseList().split("\\|");
		int[] course_ids = new int[100];
		
		for(int index = 1; index < course_list.length; index++){
			course_ids[index] = Integer.parseInt(course_list[index]);
		}
		
		if(course_ids.length == 0){
			return null;
		}
		/** 通过当前的course_ids获取所有的公告 */
		INoticeService noticeService = (INoticeService) context.getBean("noticeServiceImpl");
		List<Notice> allNotices = noticeService.getNoticesByCourse_ids(course_ids);
		for(int index = 0; index < allNotices.size(); index++){
			Notice notice = allNotices.get(index);
			int course_id = notice.getCourse_id();
			if(result.containsKey(course_id)){
				result.get(course_id).add(notice);
			}else{
				List<Notice> temp = new ArrayList<Notice>();
				temp.add(notice);
				result.put(course_id, temp);
			}
		}
		
		return result;
	}
	
}
