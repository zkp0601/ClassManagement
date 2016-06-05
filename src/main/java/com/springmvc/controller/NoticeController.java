package com.springmvc.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.springmvc.model.Notice;
import com.springmvc.model.User_infos;
import com.springmvc.service.ICourseService;
import com.springmvc.service.INoticeService;

@Controller
@RequestMapping(value={"/notice"})
public class NoticeController extends BaseController{
	
	@RequestMapping(value={"", "/", "index"})
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		if(this.isSessionExists(request.getSession()) == null){
			response.sendRedirect("/ClassManagement/user/login");
			return "login";
		}
		User_infos user_info = (User_infos) request.getSession().getAttribute("currentUser_info");
		model.addAttribute("user_info", user_info);
		
		int course_id = Integer.parseInt(request.getParameter("course_id").toString());
		ICourseService courseService = (ICourseService) this.context.getBean("courseServiceImpl");
		Course course_info = courseService.selectCourseById(course_id);
		model.addAttribute("current_course", course_info);
		
		boolean is_teacher = (boolean)request.getSession().getAttribute("is_teacher");
		model.addAttribute("is_teacher", is_teacher);
		
		/** 获取课程公告信息 */
		INoticeService noticeService = (INoticeService) this.context.getBean("noticeServiceImpl");
		List<Notice> notices = noticeService.getNoticeByCourse_id(course_id);

		/** 判断公告是否过期 */
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		List<Map<String, Object>> notices_list = new ArrayList<Map<String,Object>>();
		Date now = new Date();
		for(int i = 0; i < notices.size(); i++){
			Notice notice = notices.get(i);
			Map<String, Object> temp = new HashMap<String, Object>();
			temp.put("_notice", notice);
			Date end_date = simpleDateFormat.parse(notices.get(i).getEnd_date());
			/** 结束日期早于现在，说明已过期 */
			if(end_date.before(now)){
				temp.put("is_valid", "公告已过期");
			}else{
				temp.put("is_valid", "公告进行中");
			}
			notices_list.add(temp);
		}
		model.addAttribute("notices_list", notices_list);
		return "notice_detail";
	}
	
	@RequestMapping(value={"/publish"}, method=RequestMethod.POST)
	@ResponseBody
	public void insert(HttpServletRequest request){
		String subject = request.getParameter("subject").toString();
		String content = request.getParameter("content").toString();
		String end_date = request.getParameter("end_date").toString();
		String date = request.getParameter("date").toString();
		String time = request.getParameter("time").toString();
		String publisher = request.getParameter("publisher").toString();
		int course_id = Integer.parseInt(request.getParameter("course_id"));
		
		INoticeService noticeService = (INoticeService) this.context.getBean("noticeServiceImpl");
		Notice notice = new Notice();
		notice.setCourse_id(course_id);
		notice.setContent(content);
		notice.setEnd_date(end_date);
		notice.setSubject(subject);
		notice.setDate(date);
		notice.setTime(time);
		notice.setPublisher(publisher);
		noticeService.insertNotice(notice);
	}
	
	@RequestMapping(value={"/delete"}, method=RequestMethod.POST)
	@ResponseBody
	public void delete(HttpServletRequest request){
		int notice_id = Integer.parseInt(request.getParameter("notice_id"));
		
		INoticeService noticeService = (INoticeService) this.context.getBean("noticeServiceImpl");
		noticeService.deleteNotice(notice_id);
	}
	
	@RequestMapping(value={"/update"}, method=RequestMethod.POST)
	@ResponseBody
	public String update(HttpServletRequest request){
		int notice_id = Integer.parseInt(request.getParameter("notice_id").toString());
		String content = request.getParameter("content").toString();
		String subject = request.getParameter("subject").toString();

		INoticeService noticeService = (INoticeService) this.context.getBean("noticeServiceImpl");
		int update_result = noticeService.updateContentAndSubjectById(notice_id, content, subject);
		
		if(update_result > 0){
			return "success";
		}
		return "error";
	}
}
