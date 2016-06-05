package com.springmvc.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.model.Course;
import com.springmvc.model.Message;
import com.springmvc.model.Notice;
import com.springmvc.model.SignRecord;
import com.springmvc.model.User;
import com.springmvc.model.User_infos;
import com.springmvc.service.ICourseService;
import com.springmvc.service.ISignRecordService;
import com.springmvc.service.IUserService;
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
	
	/** 首页老师发布课程或者学生添加课程 
	 * @throws IOException */
	@RequestMapping(value={"/publish", "/add"})
	public String addCourse(HttpSession session, Model model, HttpServletResponse response) throws IOException{
		User_infos user_info = (User_infos) session.getAttribute("currentUser_info");
		if(user_info == null){
			response.sendRedirect("/ClassManagement/index");
			return null;
		}
		model.addAttribute("user_info", user_info);
		boolean is_teacher = (boolean) session.getAttribute("is_teacher");
		
		/** 若非老师，则只添加课程至个人列表中，否则是新发布课程 */
		if(!is_teacher){
			String courseList = user_info.getCourseList();
			String addedCourses[] = courseList.split("|");
			ICourseService courseService = (ICourseService) this.context.getBean("courseServiceImpl");
			List<Course> allUnaddedCourses = courseService.selectUnaddedCourses(addedCourses);
			model.addAttribute("allUnaddedCourses", allUnaddedCourses);
			
			/** 获取已添加课程信息 */
			int temp[] = new int[100];
			for(int i = 0; i < addedCourses.length; i++){
				if(addedCourses[i].equals("") || addedCourses[i].equals("|")){
					continue;
				}
				temp[i] = Integer.parseInt(addedCourses[i].toString());
			}
			List<Course> allAddedCourses = courseService.selectCourseByIDs(temp);
			model.addAttribute("allAddedCourses", allAddedCourses);
			return "addCourse";
		}
		return "publishCourse";	
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
	
	/** 获取未读消息 */
	@RequestMapping(value={"/getUnreadMessageStatistic"})
	@ResponseBody
	public Map<Integer, Map<String, String>> getUnreadMessageStatistic(HttpSession session){
		User user = (User) session.getAttribute("currentUser");
		if(user == null)
			return null;
		int receiver_id = user.getUser_id();
		int is_read = 0;
		Map<Integer, List<Message>> allMessages = this.getUnreadMessageByReceiver_id(receiver_id, is_read);
		
		/** 当前所有发送消息的用户的id，通过这些id可以获取name */
		int[] user_ids = new int[100];
		Iterator it = allMessages.entrySet().iterator();
		int index = 0;
		while(it.hasNext()){
			Map.Entry<Integer, String> entry = (Entry<Integer, String>) it.next();
			user_ids[index++] = entry.getKey();
		}
		IUserService userService = (IUserService) this.context.getBean("userServiceImpl");
		IUser_infosService user_infosService = (IUser_infosService) this.context.getBean("user_infosServiceImpl");
		User_infos[] user_infos = user_infosService.selectUser_infosByIDs(user_ids);
		Map<Integer, String> img_url_maps = new HashMap<Integer, String>();
		for(int i = 0; i < user_infos.length; i++){
			img_url_maps.put(user_infos[i].getUser_id(), user_infos[i].getImg_url());
		}
		List<User> names = userService.selectUser_namesByIds(user_ids);
		Map<Integer, String> user_name_maps = new HashMap<Integer, String>();
		for(int i = 0; i < names.size(); i++){
			user_name_maps.put(names.get(i).getUser_id(), names.get(i).getUsername());
		}
		
		Map<Integer, Map<String, String>> result = new HashMap<Integer, Map<String, String>>();
		it = allMessages.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry<Integer, List<Message>> entry = (Entry<Integer, List<Message>>) it.next();
			
			Map<String,  String> temp = new HashMap<String, String>();
			temp.put("sender_id", entry.getKey()+"");
			temp.put("sender_name", user_name_maps.get(entry.getKey()));
			temp.put("message_num", entry.getValue().size()+"");
			temp.put("date", entry.getValue().get(0).getSend_time());
			temp.put("img_url", img_url_maps.get(entry.getKey()));
			result.put(entry.getKey(), temp);
		}

		return result;
	}
	
	/** 获取所有课程公告 */
	@RequestMapping(value={"/getAllNoticesStatistic"})
	@ResponseBody
	public Map<Integer, Map<String, String>> getAllNotice(HttpSession session){
		User user = (User) session.getAttribute("currentUser");
		if(user == null)
			return null;
		int user_id = user.getUser_id();
		
		Map<Integer, List<Notice>> notices = this.getAllNoticesByUser_id(user_id);
		
		// 获取所有课程的名字
		int[] course_ids = new int[100];
		Iterator it = notices.entrySet().iterator();
		int count = 0;
		while(it.hasNext()){
			Map.Entry<Integer, List<Notice>> entry = (Entry<Integer, List<Notice>>) it.next();
			System.out.println("course_id:"+entry.getKey());
			course_ids[count++] = entry.getKey();
		}
		ICourseService courseService = (ICourseService) this.context.getBean("courseServiceImpl");
		List<Course> courses = courseService.selectCourseByIDs(course_ids);
		
		/** 将课程id跟课程名称对应起来，存在一个map中 */
		Map<Integer,String> course_name = new HashMap<Integer, String>();
		for(int i = 0; i < courses.size(); i++){
			Course course = courses.get(i);
			course_name.put(course.getCourse_id(), course.getCourse_name());
		}
		Map<Integer, Map<String, String>> result = new HashMap<Integer, Map<String, String>>();
		it = notices.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry<Integer, List<Notice>> entry = (Entry<Integer, List<Notice>>) it.next();
			Map<String, String> temp = new HashMap<String, String>();
			List<Notice> item_list = entry.getValue();
			int course_id = item_list.get(0).getCourse_id();
			temp.put("course_id", course_id+"");
			temp.put("notice_num", item_list.size()+"");
			temp.put("course_name", course_name.get(course_id));
			result.put(course_id, temp);
		}
		return result;
	}
	
	/** 获取个人的所有课程信息 */
	@RequestMapping(value={"/getAllCourse_infos"})
	@ResponseBody
	public List<Course> getAllCourse_infos(HttpSession session){
		User_infos user_info = (User_infos) session.getAttribute("currentUser_info");
		if(user_info == null)
			return null;
		String[] course_list = user_info.getCourseList().split("\\|");
		ICourseService courseService = (ICourseService) this.context.getBean("courseServiceImpl");
		int[] course_ids = new int[100];
		for(int index = 1; index < course_list.length; index++){
			course_ids[index] = Integer.parseInt(course_list[index]);
		}
		return courseService.selectCourseByIDs(course_ids);
	}
}
