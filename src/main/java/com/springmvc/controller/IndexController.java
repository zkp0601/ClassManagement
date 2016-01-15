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
import com.springmvc.model.User_infos;
import com.springmvc.service.ICourseService;
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
	@RequestMapping("getCourseData")
	@ResponseBody
	public Map<String, String> getCoursesData(HttpServletRequest request){
		Map<String, String> data = new HashMap<String, String>();
		String params = request.getParameter("courseList").toString();
		String[] courseList = params.split("\\|");
		int[] course_ids = new int[100];
		for(int i = 1; i < courseList.length; i++){
			course_ids[i] =  Integer.parseInt(courseList[i].toString());
		}
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
		return data;
	}
}
