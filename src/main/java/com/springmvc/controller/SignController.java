package com.springmvc.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.model.Course;
import com.springmvc.model.SignRecord;
import com.springmvc.service.ICourseService;
import com.springmvc.service.ISignRecordService;

@Controller
@RequestMapping(value={"/sign"})
public class SignController extends BaseController{
	
	/**
	 * 获取用户的签到签退记录
	 * */
	@RequestMapping(value={"/signRecord"})
	public String signRecord(HttpServletRequest request){
		
		return "signRecord";
	}
	
	@RequestMapping(value={"/signIn"})
	@ResponseBody
	public String signIn(HttpServletRequest request){
		
		int course_id = Integer.parseInt(request.getParameter("course_id").toString());
		ICourseService courseService = (ICourseService) this.context.getBean("courseServiceImpl");
		Course current_course = courseService.selectCourseById(course_id);
		
		if(!request.getRemoteAddr().startsWith(current_course.getSignInIP()))
			return "refused";
		
		int user_id = Integer.parseInt(request.getParameter("user_id").toString());
		String sign_date = request.getParameter("sign_date").toString();
		int signInTime = Integer.parseInt(request.getParameter("signInTime").toString());
			
		ISignRecordService signRecordService = (ISignRecordService) this.context.getBean("signRecordServiceImpl");
		SignRecord signRecord = new SignRecord(user_id, course_id, sign_date, signInTime, 0);
		int update_id = signRecordService.updateSignInRecord(signRecord);
		//如果未更新，则返回failed
		if(update_id == 0)
			return "failed";
		return "successed";
	}
	
	@RequestMapping(value={"/signOut"})
	@ResponseBody
	public String signOut(HttpServletRequest request){
		
		int course_id = Integer.parseInt(request.getParameter("course_id").toString());
		ICourseService courseService = (ICourseService) this.context.getBean("courseServiceImpl");
		Course current_course = courseService.selectCourseById(course_id);
		
		if(!request.getRemoteAddr().startsWith(current_course.getSignInIP()))
			return "refused";
		
		int user_id = Integer.parseInt(request.getParameter("user_id").toString());
		String sign_date = request.getParameter("sign_date").toString();
		int signOutTime = Integer.parseInt(request.getParameter("signOutTime").toString());
			
		ISignRecordService signRecordService = (ISignRecordService) this.context.getBean("signRecordServiceImpl");
		SignRecord signRecord = new SignRecord(user_id, course_id, sign_date, 0, signOutTime);
		int update_id = signRecordService.updateSignOutRecord(signRecord);
		if(update_id == 0)
			return "failed";
		return "successed";
	}
	
	@RequestMapping(value={"/getSignRecordData"})
	@ResponseBody
	public void getSignRecordData(HttpServletRequest request){
		
	}
	
}
