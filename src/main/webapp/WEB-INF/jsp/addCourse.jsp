<%@ include file="header.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="main-content">
	<div class="breadcrumbs" id="breadcrumbs">
		<script type="text/javascript">
			try {
				ace.settings.check('breadcrumbs', 'fixed')
			} catch (e) {
			}
		</script>

		<ul class="breadcrumb">
			<li><i class="icon-dashboard"></i> <a href="/ClassManagement/">首页</a></li>

			<li class="active">添加课程</li>
		</ul>
		<!-- .breadcrumb -->

		<div class="nav-search" id="nav-search">
			<form class="form-search">
				<span class="input-icon"> <input type="text"
					placeholder="Search ..." class="nav-search-input"
					id="nav-search-input" autocomplete="off" /> <i
					class="icon-search nav-search-icon"></i>
				</span>
			</form>
		</div>
		<!-- #nav-search -->
	</div>

	<div class="page-content">
		<div class="row">
			<div class="col-xs-12" style="width: 96%;">
				<!-- PAGE CONTENT BEGINS -->
				<div class="well" style="background-color: ghostwhite">
					<div class="page-header" style="border-bottom: 1px dotted #438eb9;">
						<h1 style="font-size: 20px; color: #d15b47 !important;">
							所有发布课程 <small> <i class="icon-double-angle-right"></i>
								All published courses
							</small>
						</h1>
					</div>
					<!-- /.page-header end -->

					<div style="margin: 0 8px; border-bottom: 1px dotted #438eb9; padding: 10px 0;">
						<div class="row">
							<div class="col-xs-12 col-sm-12">
								<div class="control-group" style="width:100%; border-bottom:1px dotted #438eb9;">
									<label class="control-label bolder blue" style="font-size:20px;">未添加课程</label>
									<div id="unaddedCourse">
										<c:if test="${allUnaddedCourses.size()==0}">
											<label class="control-label border" style="color:#98908E;">暂无未添加课程</label>
										</c:if>
										<c:forEach items="${allUnaddedCourses}" var="course">
											<div class="checkbox" style="width:96%; float:left; margin-top:10px;">
												<label>
													<div style="padding-right:20px;"> 
														<input name="form-field-checkbox" type="checkbox" class="ace" onclick="updateCoursesList(${course.course_id}, '${course.course_name}')"> 
														<span class="lbl infobox-dark" style="background-color:#A9244F;display:block;float:left;"> 
															《${course.course_name}》 
														</span>
														<span class="infobox-dark" style="background-color:#709CC1; padding:4px;display:block;float:left;margin-left:1px;">
															上课时间：${course.start_time}~${course.end_time}&nbsp; 教师：${course.teacher_name}
														</span>
													</div>
												</label>
											</div>
										</c:forEach>
									</div>
									<c:if test="${allUnaddedCourses.size()!=0}">
										<div><button class="btn btn-success btn-app" disabled=true id="add_course_btn" onclick="add_course_btn()" style="margin-right:7px;margin-bottom:10px;margin-top:20px;">确认添加</button></div>
									</c:if>
								</div>
								<div class="control-group" style="margin-top:20px;width:100%;">
									<label class="control-label bolder blue" style="font-size:20px;">已添加课程</label>
									<div>
										<c:if test="${allAddedCourses.size()==0}">
											<label class="control-label border" style="color:#98908E;">暂无已添加课程</label>
										</c:if>
										<c:forEach items="${allAddedCourses}" var="course">
											<div class="alert alert-danger" style="padding:5px 5px;" id="alreadyAddedCourse_${course.course_id}" >
												<button class="close" onclick="return removeCourse(${course.course_id}, '${course.course_name}', '${course.start_time}', '${course.end_time}', '${course.teacher_name}')">
													<i class="icon-remove"></i>
												</button>
												<strong>《${course.course_name}》</strong>
												老师：${course.teacher_name}&nbsp;&nbsp;上课时间：${course.start_time}~${course.end_time}
											</div>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="footer.jsp"%>

<script type="text/javascript">
	var appendList = "|";
	function updateCoursesList(course_id, course_name){
		if(appendList[0] != "|"){
			appendList = "|" + appendList;
		}
		if(appendList.indexOf("|"+course_id+"|") > -1){
			appendList = appendList.replace("|"+course_id+"|", "|");
		}else{
			appendList = appendList + course_id + "|";
		}
		
		var btn_state = document.getElementById("add_course_btn");
		if(appendList != "|"){
			btn_state.disabled = false;
		}else{
			btn_state.disabled = true;
		}
	}
	
	function add_course_btn(){
		if(appendList[0] == "|"){
			appendList = appendList.substring(1);
		}
		$.ajax({
			url:'/ClassManagement/course/addCourse',
			data:{appendList : appendList},
			type:'post',
			success : function(){
				alert("添加成功");
				window.location.href = window.location.href;
			}
		});
	}
	
	function removeCourse(course_id, course_name, start_time, end_time, teacher_name){
		if(confirm("确定移除课程《"+course_name+"》吗？")){
			document.getElementById("alreadyAddedCourse_"+course_id).hidden = true;
			var temp = document.getElementById("unaddedCourse").innerHTML;
			if(temp.indexOf("暂无未添加课程") > -1){
				document.getElementById("unaddedCourse").innerHTML = 
					'<div class="checkbox" style="width:96%; float:left; margin-top:10px;">'+
						'<label>'+
							'<div style="padding-right:20px;"> '+
								'<input name="form-field-checkbox" type="checkbox" class="ace" onclick="updateCoursesList('+course_id+', \''+course_name+'\')">'+ 
								'<span class="lbl infobox-dark" style="background-color:#A9244F;display:block;float:left;">'+ 
								'《'+course_name+'》'+ 
								'</span>'+
								'<span class="infobox-dark" style="background-color:#709CC1; padding:4px;display:block;float:left;margin-left:1px;">'+
								'上课时间：'+start_time+'~'+end_time+'&nbsp; 教师：'+teacher_name+
								'</span>'+
							'</div>'+
						'</label>'+
					'</div>'+
					'<div>'+
						'<button class="btn btn-success btn-app" id="add_course_btn" disabled=true onclick="add_course_btn()" style="margin-right:7px;margin-bottom:10px;margin-top:20px;">确认添加</button>'+
					'</div>';
			}else{
				document.getElementById("unaddedCourse").innerHTML = 
					'<div class="checkbox" style="width:96%; float:left; margin-top:10px;">'+
						'<label>'+
							'<div style="padding-right:20px;"> '+
								'<input name="form-field-checkbox" type="checkbox" class="ace" onclick="updateCoursesList('+course_id+', \''+course_name+'\')">'+ 
								'<span class="lbl infobox-dark" style="background-color:#A9244F;display:block;float:left;">'+ 
								'《'+course_name+'》'+ 
								'</span>'+
								'<span class="infobox-dark" style="background-color:#709CC1; padding:4px;display:block;float:left;margin-left:1px;">'+
								'上课时间：'+start_time+'~'+end_time+'&nbsp; 教师：'+teacher_name+
								'</span>'+
							'</div>'+
						'</label>'+
					'</div>'
					+ temp;
			}
			$.ajax({
				url:'/ClassManagement/course/removeCourse',
				data: {course_id :course_id},
				type:'post',
				success : function(){
					alert("移除成功!");
				}
			});
			return true;
		}
		return false;
	}
</script>