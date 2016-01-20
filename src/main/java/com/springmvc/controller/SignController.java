package com.springmvc.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.model.Course;
import com.springmvc.model.SignRecord;
import com.springmvc.model.User;
import com.springmvc.model.User_infos;
import com.springmvc.service.ICourseService;
import com.springmvc.service.ISignRecordService;
import com.springmvc.service.IUser_infosService;

@Controller
@RequestMapping(value={"/sign"})
public class SignController extends BaseController{
	
	/**
	 * 获取用户的签到签退记录
	 * @throws IOException 
	 * */
	@RequestMapping(value={"/signRecord"})
	public String signRecord(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException{
		
		if(this.isSessionExists(request.getSession()) == null){
			response.sendRedirect("/ClassManagement/user/login");
			return "login";
		}
		
		int course_id = Integer.parseInt(request.getParameter("course_id").toString());
		ICourseService courseService = (ICourseService) this.context.getBean("courseServiceImpl");
		Course current_course = courseService.selectCourseById(course_id);
		model.addAttribute("current_course", current_course);
		
		// 通过 Session 获取当前的用户信息
		User_infos user_info = (User_infos) request.getSession().getAttribute("currentUser_info");
		model.addAttribute("user_info", user_info);
		boolean is_teacher = (boolean) request.getSession().getAttribute("is_teacher");
		model.addAttribute("is_teacher", is_teacher);
		
		//获取用户签到信息
		int user_id = user_info.getUser_id();
		ISignRecordService signRecordService = (ISignRecordService) this.context.getBean("signRecordServiceImpl");
		
		List<SignRecord> allSignRecords = null;
		if(!is_teacher){
			allSignRecords = signRecordService.getOnesAllSignRecordByUser_idANDCourse_id(user_id, course_id);
			
			List<Map<String, String>> records = new ArrayList<Map<String, String>>();
			for(int i = 0; i < allSignRecords.size(); i++){
				Map<String, String> temp = new HashMap<String, String>();
				SignRecord signRecord = allSignRecords.get(i);
				temp.put("sign_date", signRecord.getSign_date());
				/** 设置签到时间*/
				String hour = (signRecord.getSignInTime()/3600 < 10 ? "0" + signRecord.getSignInTime()/3600 : ""+signRecord.getSignInTime()/3600);
				String min = (signRecord.getSignInTime()%3600)/60 < 10 ? "0" + (signRecord.getSignInTime()%3600)/60 : ""+(signRecord.getSignInTime()%3600)/60;
				temp.put("signInTime", hour + ":" + min);
				
				/** 设置签退时间*/
				hour = (signRecord.getSignOutTime()/3600 < 10 ? "0" + signRecord.getSignOutTime()/3600 : ""+signRecord.getSignOutTime()/3600);
				min = (signRecord.getSignOutTime()%3600)/60 < 10 ? "0" + (signRecord.getSignOutTime()%3600)/60 : ""+(signRecord.getSignOutTime()%3600)/60;
				temp.put("signOutTime", hour + ":" + min);
				
				/** 获取当前课程应当签到签退的时间, 判断用户是否迟到早退*/
				String[] signIn = current_course.getStart_time().split(":");
				String[] signOut = current_course.getEnd_time().split(":");
				
				int shouldSignInTime = Integer.parseInt(signIn[0]) * 3600 + Integer.parseInt(signIn[1]) * 60;
				int shouldSignOutTime = Integer.parseInt(signOut[0]) * 3600 + Integer.parseInt(signOut[1]) * 60;
				
				if(signRecord.getSignInTime() > shouldSignInTime + 900){
					temp.put("late", "true");
				}else{
					temp.put("late", "false");
				}
				
				if(signRecord.getSignOutTime() < shouldSignOutTime - 900){
					temp.put("earlyLeave", "true");
				}else{
					temp.put("earlyLeave", "false");
				}
				records.add(i, temp);
			}
			System.out.println("records_size"+ records.size());
			model.addAttribute("records", records);
			model.addAttribute("records_size", records.size());
		}else{
			/** 设置上课后的15分钟及下课前的15分钟内为签到签退时间, 即900秒*/
			allSignRecords = signRecordService.getAllSignRecordByCourse_id(course_id);
			
			/** 获取当前课程应当签到签退的时间*/
			String[] signIn = current_course.getStart_time().split(":");
			String[] signOut = current_course.getEnd_time().split(":");
			
			int shouldSignInTime = Integer.parseInt(signIn[0]) * 3600 + Integer.parseInt(signIn[1]) * 60;
			int shouldSignOutTime = Integer.parseInt(signOut[0]) * 3600 + Integer.parseInt(signOut[1]) * 60;
			
			/** 统计每个学生的签到签退和出勤次数 */
			Map<Integer, Map<String, String>> records = new HashMap<Integer, Map<String, String>>();
			for(int i = 0; i < allSignRecords.size(); i++){
				SignRecord signRecord = allSignRecords.get(i);
				int stu_id = signRecord.getUser_id();
				if(records.containsKey(stu_id) && (signRecord.getSignInTime()!=0 || signRecord.getSignOutTime()!=0)){
					/** 计算出勤记录 */
					Map<String, String> temp = records.get(stu_id);
					int present_times = Integer.parseInt( temp.get("present_times") );
					records.get(stu_id).remove("present_times");
					records.get(stu_id).put("present_times", present_times+1+"");
					
					/** 计算迟到次数 */
					int signInTime = signRecord.getSignInTime();
					if(signInTime > shouldSignInTime){
						int late_times = Integer.parseInt( records.get(stu_id).get("late_times") );
						records.get(stu_id).remove("late_times");
						records.get(stu_id).put("late_times", late_times+1+"");
					}
					
					/** 计算早退次数 */
					int signOutTime = signRecord.getSignOutTime();
					if(signOutTime < shouldSignOutTime){
						int earlyLeave_times = Integer.parseInt( temp.get("earlyLeave_times") );
						records.get(stu_id).remove("earlyLeave_times");
						records.get(stu_id).put("earlyLeave_times", earlyLeave_times+1+"");
					}
				}else{
					Map<String, String> temp = new HashMap<String, String>();
					if( signRecord.getSignInTime()==0 && signRecord.getSignOutTime()==0){
						temp.put("present_times", "0");
					}else{
						temp.put("present_times", "1");
					}
					temp.put("user_id", signRecord.getUser_id()+"");
					temp.put("late_times", "0");
					temp.put("earlyLeave_times", "0");
					records.put(stu_id, temp);
				}
			}
			model.addAttribute("records", records);
			model.addAttribute("records_size", records.size());
		}
		
		return "signRecord";
	}
	
	@RequestMapping(value={"/signIn"})
	@ResponseBody
	public String signIn(HttpServletRequest request){
		
		if(this.isSessionExists(request.getSession()) == null){
			return "redirect://ClassManagement/user/login";
		}
		
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
	public String signOut(HttpServletRequest request ){
		if(this.isSessionExists(request.getSession()) == null){
			return "redirect://ClassManagement/user/login";
		}
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
		Map<String, Object> signRecordsMap = new HashMap<String, Object>();
		if(course_id == 0){
			User_infos user_info = (User_infos) request.getSession().getAttribute("currentUser_info");
			String[] courseList = user_info.getCourseList().split("\\|");
			int[] course_ids = new int[100];
			for(int i = 1; i < courseList.length; i++){
				course_ids[i] =  Integer.parseInt(courseList[i].toString());
			}
			/** 获取男女比例数据 */
			IUser_infosService user_infosService = (IUser_infosService) this.context.getBean("user_infosServiceImpl");
			List<User_infos> user_infos = user_infosService.selectUser_infosByCourse_ids(course_ids);
			int total_num = user_infos.size(), male_num = 0, female_num = 0;
			for(int i = 0; i < total_num; i++){
				if(user_infos.get(i).getSex().equals("男")){
					male_num++;
				}else{
					female_num++;
				}
			}
			signRecordsMap.put("male_num", String.format("%.2f", male_num * 100 / (double)total_num));
			signRecordsMap.put("female_num", String.format("%.2f", female_num * 100 / (double) total_num));
			
			return signRecordsMap;
		}
		User user = (User)request.getSession().getAttribute("currentUser");
		int user_id = user.getUser_id();
		
		/** 获取该课程应当签到签退的时间 HH:MM, 并转化为int参数 */
		ICourseService courseService = (ICourseService) this.context.getBean("courseServiceImpl");
		Course course = courseService.selectCourseById(course_id);
		String[] signIn = course.getStart_time().split(":");
		String[] signOut = course.getEnd_time().split(":");
		
		int shouldSignInTime = Integer.parseInt(signIn[0]) * 3600 + Integer.parseInt(signIn[1]) * 60;
		int shouldSignOutTime = Integer.parseInt(signOut[0]) * 3600 + Integer.parseInt(signOut[1]) * 60;
		
		/** 设置上课后的15分钟及下课前的15分钟内为签到签退时间, 即900秒 */
		ISignRecordService signRecordService = (ISignRecordService) this.context.getBean("signRecordServiceImpl");
		List<SignRecord> allSignRecords = signRecordService.getOnesAllSignRecordByUser_idANDCourse_id(user_id, course_id);
		
		List<SignRecord> lateSignRecords = signRecordService.getOnesLateRecordByCourse_id(user_id, course_id, shouldSignInTime, 900);
		List<SignRecord> earlyLeaveSignRecords = signRecordService.getOnesEarlyLeaveRecordByCourse_id(user_id, course_id, shouldSignOutTime, 900);
		
		signRecordsMap.put("allSignRecords", allSignRecords);
		signRecordsMap.put("lateSignRecords", lateSignRecords);
		signRecordsMap.put("earlyLeaveSignRecords", earlyLeaveSignRecords);
		signRecordsMap.put("total_class_num", course.getWeek_time());
		
		/** 根据传入的course_id获取该门课程的男女比例 */
		IUser_infosService user_infosService = (IUser_infosService) this.context.getBean("user_infosServiceImpl");
		List<User_infos> user_infos = user_infosService.selectUser_infosByCourse_id(course_id);
		int male_num = 0, female_num = 0;
		for(int i = 0; i < user_infos.size(); i++){
			if(user_infos.get(i).getSex().equals("男")){
				male_num++;
			}else{
				female_num++;
			}
		}
		signRecordsMap.put("male_num", male_num);
		signRecordsMap.put("female_num", female_num);
		return signRecordsMap;
	}
	
}
