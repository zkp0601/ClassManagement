package com.springmvc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Service;

import com.springmvc.dao.ICourseDAO;
import com.springmvc.model.Course;
import com.springmvc.model.User_infos;
import com.springmvc.service.ICourseService;

@Service
@Configuration
public class CourseServiceImpl implements ICourseService{
	
	@Autowired
	private ICourseDAO courseDAO;
	
	public Course selectCourseById(int course_id){
		return courseDAO.selectCourseById(course_id);
	}
	
	public List<User_infos> selectUsersById(int course_id){
		return courseDAO.selectUsersById(course_id);
	}
	
	public void insertCourse(Course course){
		courseDAO.insertCourse(course);
	}
	
	public List<Course> selectCourseByIDs(int course_ids[]){
		return courseDAO.selectCourseByIDs(course_ids);
	}
	
	public List<Course> selectUnaddedCourses(String[] addedCourses){
		return courseDAO.selectUnaddedCourses(addedCourses);
	}
}
