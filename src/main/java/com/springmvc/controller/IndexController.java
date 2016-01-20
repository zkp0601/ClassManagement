package com.springmvc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.model.Course;
import com.springmvc.model.SignRecord;
import com.springmvc.model.User;
import com.springmvc.model.User_infos;
import com.springmvc.service.ICourseService;
import com.springmvc.service.ISignRecordService;
import com.springmvc.service.IUser_infosService;

@Controller
@RequestMapping(value={"/", "/index", ""})
public class IndexController extends BaseController{
	
	/** 网站首页 http://localhost/ClassManagement/index */
	@RequestMapping(value={"", "/", "/index"})
	public String index(HttpSession session, HttpServletResponse response, Model model) throws Exception{
		if( this.isSessionExists(session) != null ){
			// 通过session获取当前用户id
			// int user_id = ((User) session.getAttribute("currentUser")).getUser_id();
			// 获取用户信息，并获得参与的课程列表
			User_infos user_info = (User_infos) session.getAttribute("currentUser_info");
			model.addAttribute("user_info", user_info);
			if(user_info.getCourseList().equals("|")){
				model.addAttribute("anyCourses", false);
				return "index";
			}else{
				model.addAttribute("anyCourses", true);
			}
			
			String[] courseList = user_info.getCourseList().split("\\|");
			int[] course_ids = new int[100];
			for(int i = 1; i < courseList.length; i++){
				course_ids[i] = Integer.parseInt(courseList[i].toString());
			}
			ICourseService courseService = (ICourseService) this.context.getBean("courseServiceImpl");
			List<Course> course_infos = courseService.selectCourseByIDs(course_ids);
			model.addAttribute("course_infos", course_infos);
			model.addAttribute("is_teacher", session.getAttribute("is_teacher"));
			return "index";
		}else {
			//未登录跳转至登录界面
			response.sendRedirect("/ClassManagement/user/login");
			return "login";
		}
	}
	
	/** 首页添加课程 */
	@RequestMapping("/add")
	public String addCourse(){
		return "addCourse";	
	}
	
	/** 查看日历 */
	@RequestMapping("/calendar")
	public String calendar(){
		return "calendar";
	}
	
	/** 获取首页中课程数据情况 */
	@RequestMapping("/getCourseData")
	@ResponseBody
	public Map<String, String> getCoursesData(HttpServletRequest request){
		Map<String, String> data = new HashMap<String, String>();
		String params = request.getParameter("courseList").toString();
		String[] courseList = params.split("\\|");
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
		data.put("male_ratio", String.format("%.2f", male_num * 100 / (double)total_num));
		data.put("female_ratio", String.format("%.2f", female_num * 100 / (double) total_num));
		
		/** 获取个人单门课程的出勤数据 */
		ISignRecordService signRecordService = (ISignRecordService) this.context.getBean("signRecordServiceImpl");
		if(course_ids.length == 1){
			User user = (User) request.getSession().getAttribute("current_user");
			int user_id = user.getUser_id();
			List<SignRecord> records = signRecordService.getOnesAllSignRecordByUser_idANDCourse_id(user_id, course_ids[0]);
			ICourseService courseService = (ICourseService) this.context.getBean("courseServiceImpl");
			Course course = courseService.selectCourseById(course_ids[0]);
			
			String[] signIn = course.getStart_time().split(":");
			String[] signOut = course.getEnd_time().split(":");
			
			int shouldSignInTime = Integer.parseInt(signIn[0]) * 3600 + Integer.parseInt(signIn[1]) * 60;
			int shouldSignOutTime = Integer.parseInt(signOut[0]) * 3600 + Integer.parseInt(signOut[1]) * 60;
			
			int total_week_time = course.getWeek_time();
			int present_time = 0, late_time = 0, earlyLeave_time = 0;
			for(int i = 0; i < records.size(); i++){
				SignRecord record = records.get(i);
				/** 出勤次数 */
				if(record.getSignInTime() != 0 || record.getSignOutTime() != 0){
					present_time ++;
				}
				/** 迟到次数 */
				if(record.getSignInTime() > shouldSignInTime+900){
					late_time ++;
				}
				/** 早退次数 */
				if(record.getSignOutTime() < shouldSignOutTime-900){
					earlyLeave_time++;
				}
				data.put("present_time", present_time+"");
				data.put("late_time", late_time+"");
				data.put("earlyLeave_time", earlyLeave_time+"");
				data.put("to_finish", total_week_time-present_time +"");
			}
		}
		
		return data;
	}
}
