package com.springmvc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.model.Course;
import com.springmvc.model.SignRecord;
import com.springmvc.model.User;
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
	
	@RequestMapping(value={"/getSignRecordData"}, method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getSignRecordData(HttpServletRequest request){
		int course_id = Integer.parseInt(request.getParameter("course_id"));
		User user = (User)request.getSession().getAttribute("currentUser");
		int user_id = user.getUser_id();
		
		//获取该课程应当签到签退的时间 HH:MM, 并转化为int参数
		ICourseService courseService = (ICourseService) this.context.getBean("courseServiceImpl");
		Course course = courseService.selectCourseById(course_id);
		String[] signIn = course.getStart_time().split(":");
		String[] signOut = course.getEnd_time().split(":");
		
		int shouldSignInTime = Integer.parseInt(signIn[0]) * 3600 + Integer.parseInt(signIn[1]) * 60;
		int shouldSignOutTime = Integer.parseInt(signOut[0]) * 3600 + Integer.parseInt(signOut[1]) * 60;
		
		// 设置上课后的15分钟及下课前的15分钟内为签到签退时间, 即900秒
		ISignRecordService signRecordService = (ISignRecordService) this.context.getBean("signRecordServiceImpl");
		List<SignRecord> allSignRecords = signRecordService.getOnesAllSignRecordByUser_idANDCourse_id(user_id, course_id);
		
		List<SignRecord> lateSignRecords = signRecordService.getOnesLateRecordByCourse_id(user_id, course_id, shouldSignInTime, 900);
		List<SignRecord> earlyLeaveSignRecords = signRecordService.getOnesEarlyLeaveRecordByCourse_id(user_id, course_id, shouldSignOutTime, 900);
		
		Map<String, Object> signRecordsMap = new HashMap<String, Object>();
		signRecordsMap.put("allSignRecords", allSignRecords);
		signRecordsMap.put("lateSignRecords", lateSignRecords);
		signRecordsMap.put("earlyLeaveSignRecords", earlyLeaveSignRecords);
		signRecordsMap.put("total_class_num", course.getWeek_time());
		return signRecordsMap;
	}
	
}
