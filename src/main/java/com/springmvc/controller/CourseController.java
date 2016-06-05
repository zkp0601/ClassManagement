package com.springmvc.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.model.Course;
import com.springmvc.model.Notice;
import com.springmvc.model.SignRecord;
import com.springmvc.model.User;
import com.springmvc.model.User_infos;
import com.springmvc.service.ICourseService;
import com.springmvc.service.INoticeService;
import com.springmvc.service.ISignRecordService;
import com.springmvc.service.IUser_infosService;

@Controller
@RequestMapping("/course")
public class CourseController extends BaseController{
	
	@RequestMapping(value={"", "/", "/index"})
	public String index(HttpServletRequest request, Model model, HttpServletResponse response) throws Exception{
		if( this.isSessionExists(request.getSession()) == null )
			response.sendRedirect("/ClassManagement/user/login");
		
		// 通过course_id获取当前的课程信息
		int course_id = Integer.parseInt(request.getParameter("course_id").toString());
		ICourseService courseService = (ICourseService) this.context.getBean("courseServiceImpl");
		Course current_course = courseService.selectCourseById(course_id);
		model.addAttribute("current_course", current_course);
		
		// 通过 Session 获取当前的用户信息
		User_infos user_info = (User_infos) request.getSession().getAttribute("currentUser_info");
		model.addAttribute("user_info", user_info);
		
		// 根据 course_id 获取学生信息
		IUser_infosService user_infosService = (IUser_infosService) this.context.getBean("user_infosServiceImpl");
		List<User_infos> user_infos = user_infosService.selectUser_infosByCourse_id(course_id);
		model.addAttribute("user_infos", user_infos);
		
		try{
			// 当手机IP与课程设置的签到IP处于同个网段时才允许签到
			if(request.getRemoteAddr().startsWith(current_course.getSignInIP())){
				ISignRecordService signRecordService = (ISignRecordService) this.context.getBean("signRecordServiceImpl");
				Date date = new Date();
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
				String today = simpleDateFormat.format(date);
				SignRecord signRecord = new SignRecord(user_info.getUser_id(), course_id, today, 0, 0);
				signRecordService.insertSignRecord(signRecord);
			}
		}catch(Exception e){ }
		
		/** 获取课程公告 */
		INoticeService noticeService = (INoticeService) this.context.getBean("noticeServiceImpl");
		List<Notice> notices = noticeService.getNoticeByCourse_id(course_id);
		model.addAttribute("notices", notices);
		return "myCourse";
	}
	
	/** 教师新增课程接口 */
	@RequestMapping(value={"/insert"}, method=RequestMethod.POST)
	@ResponseBody
	public void insert(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ICourseService courseService = (ICourseService) this.context.getBean("courseServiceImpl");
		String course_name = request.getParameter("course_name").toString();
		String teacher_name = request.getParameter("teacher_name").toString();
		String signInIP = request.getParameter("signInIP").toString();
		String position = request.getParameter("position").toString();
		String start_time = request.getParameter("start_time").toString();
		String end_time = request.getParameter("end_time").toString();
		int week_time = Integer.parseInt(request.getParameter("week_time").toString());
		Course course = new Course(0, course_name, teacher_name, position, start_time, end_time, week_time, signInIP);
		courseService.insertCourse(course);
		int course_id = course.getCourse_id();
		
		// 更新当前用户的课程列表 courseList.
		User currentUser = (User) request.getSession().getAttribute("currentUser");
		int user_id = currentUser.getUser_id();
		IUser_infosService user_infosService = (IUser_infosService) this.context.getBean("user_infosServiceImpl");
		User_infos currentUser_infos = user_infosService.selectUser_infosByID(user_id);
		String courseList = currentUser_infos.getCourseList()+ course_id + "|" ;
		currentUser_infos.setCourseList(courseList);
		user_infosService.updateUser_infosByID(currentUser_infos);
		request.getSession().setAttribute("currentUser_info", currentUser_infos);
		response.sendRedirect("/ClassManagement/course/index?course_id="+course_id);
	}
	
	/**
	 * Method remove_course_from_courseList
	 * -------------------------------------
	 * 《从courseList课程列表中删除指定课程》
	 * @throws IOException 
	 */
	@RequestMapping(value={"/removeCourse"}, method=RequestMethod.POST)
	@ResponseBody
	public void remove_course_from_courseList(HttpServletRequest request, HttpServletResponse response) throws IOException{
		User user = (User) request.getSession().getAttribute("currentUser");
		if(user == null){
			response.sendRedirect("/ClassManagement/index");
			return;
		}
		int user_id = user.getUser_id();
		IUser_infosService user_infosService = (IUser_infosService) this.context.getBean("user_infosServiceImpl");
		User_infos user_info = user_infosService.selectUser_infosByID(user_id);
		String courseList = user_info.getCourseList();
		
		String course_id = request.getParameter("course_id").toString();
		if(courseList.contains("|"+course_id+"|")){
			courseList = courseList.replace("|"+course_id+"|", "|");
			user_info.setCourseList(courseList);
			user_infosService.updateUser_infosByID(user_info);
			request.getSession().setAttribute("currentUser_info", user_info);
		}
	}
	
	/**
	 * Method add_course
	 * ------------------
	 * 《新增课程至courseList中》
	 * @throws IOException 
	 */
	@RequestMapping(value={"/addCourse"}, method=RequestMethod.POST)
	public void add_course(HttpServletRequest request, HttpServletResponse response) throws IOException{
		User user = (User) request.getSession().getAttribute("currentUser");
		if(user == null){
			response.sendRedirect("/ClassManagement/index");
			return;
		}
		int user_id = user.getUser_id();
		IUser_infosService user_infosService = (IUser_infosService) this.context.getBean("user_infosServiceImpl");
		String appendList = request.getParameter("appendList").toString();
		User_infos user_info = user_infosService.selectUser_infosByID(user_id);
		String newCourseList = user_info.getCourseList() + appendList;
		user_info.setCourseList(newCourseList);
		user_infosService.updateUser_infosByID(user_info);
		request.getSession().setAttribute("currentUser_info", user_info);
	}
}
