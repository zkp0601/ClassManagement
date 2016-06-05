package com.springmvc.service;

import java.util.List;

import com.springmvc.model.Course;
import com.springmvc.model.User_infos;

public interface ICourseService {
	
	/** 通过id获取课程信息 */
	public Course selectCourseById(int course_id);
	
	/** 通过id获取课程学生信息 */
	public List<User_infos> selectUsersById(int course_id);
	
	/** 插入新的课程 */
	public void insertCourse(Course course);
	
	/** 通过多个course_id获取多个课程信息 */
	public List<Course> selectCourseByIDs(int course_ids[]);
	
	/** 选择所有的课程 */
	public List<Course> selectUnaddedCourses(String[] addedCourses);
}
