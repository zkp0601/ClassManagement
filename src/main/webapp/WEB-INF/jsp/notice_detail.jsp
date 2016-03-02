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
			<li><i class="icon-home"></i> <a href="/ClassManagement/index/">首页</a></li>
			<li><a style="color: #DA5430; weight: bold;"
				href="/ClassManagement/course/index?course_id=${current_course.course_id}">${current_course.course_name}</a></li>
			<li class="active">公告</li>
		</ul>
		<!-- .breadcrumb -->

		<div class="nav-search" id="nav-search">
			<form class="form-search">
				<span class="input-icon"> <input type="text"
					placeholder="Search..." class="nav-search-input"
					id="nav-search-input" autocomplete="off" /> <i
					class="icon-search nav-search-icon"></i>
				</span>
			</form>
		</div>
		<!-- #nav-search -->
	</div>

	<div class="page-content">
		<div class="page-header">
			<h1>
				公告详情
				<small> 
					<i class="icon-double-angle-right"></i>
					&nbsp;Notice Detail
				</small>
				<c:if test="${is_teacher==true}">
					<button class="btn btn-app btn-info pull-right" data-toggle="modal" data-target="#add_notice_page" id="add_notice" style="padding:2px 12px;font-size:15px;">
						添加公告
					</button>
				</c:if>
			</h1>
		</div>

		<div class="row">
			<div class="col-xs-12" style="width: 96%;">
				<div id="timeline-1" class="">
					<div class="row">
						<div class="col-xs-12 col-sm-10 col-sm-offset-1">
							<c:if test="${notices_list.size()==0}">
								<div style="color:#5D5757; font-size:20px; text-align:center;">暂无公告</div>
							</c:if>
							<c:forEach items="${notices_list}" var="notice_item">
								<div class="timeline-container" id="notice_detail_${notice_item._notice.notice_id}">
									<div class="timeline-label">
										<span class="label label-primary arrowed-in-right label-lg">
											<b>${notice_item._notice.date}</b>
										</span>
									</div>
	
									<div class="timeline-items">
										<div class="timeline-item clearfix">
											<div class="timeline-info">
												<img alt="Susan't Avatar" src='<c:url value="/img/avatars/avatar2.jpg"></c:url>' />
												<span class="label label-info label-sm">${notice_item._notice.time }</span>
											</div>
	
											<div class="widget-box transparent">
												<div class="widget-header widget-header-small">
													<h5 class="smaller">
														<a href="#" class="blue"><i class="icon-user" style="color:;"></i>&nbsp;${notice_item._notice.publisher }</a> <span class="grey">
														published a notice</span>
													</h5>
	
													<span class="widget-toolbar no-border"> 
														<i class="icon-time bigger-110"></i> ${notice_item._notice.time }
													</span> 
													<span class="widget-toolbar"> 
														<a href="#" data-action="collapse" data-toggle="tooltip" title="Pack up"> 
															<i class="icon-chevron-up"></i>
															&nbsp;&nbsp;<a href="#" data-toggle="tooltip" title="Like"> <i class="icon-heart red bigger-125"></i> </a>
														</a>
													</span>
												</div>
	
												<div class="widget-body">
													<div class="widget-main">
														<textarea style="width:100%; resize:none; background-color:#f2f6f9;" disabled="disabled" id="content_editable_${notice_item._notice.notice_id}">${notice_item._notice.content}</textarea>
														<div class="space-6"></div>
	
														<div class="widget-toolbox clearfix">
															<div class="pull-right action-buttons">
																<a href="#" data-toggle="tooltip" id="save_${notice_item._notice.notice_id}" title="Save" onclick="operation('save',${notice_item._notice.notice_id})"> <i class="icon-ok green bigger-130"></i>
																</a> <a href="#" data-toggle="tooltip" id="edit_${notice_item._notice.notice_id}" title="Edit" onclick="operation('edit',${notice_item._notice.notice_id})"> <i class="icon-pencil blue bigger-125"></i>
																</a> <a href="#" data-toggle="tooltip" id="delete_${notice_item._notice.notice_id}" title="Delete" onclick="operation('delete',${notice_item._notice.notice_id})"> <i class="icon-remove red bigger-125"></i>
																</a>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
	
										<div class="timeline-item clearfix">
											<div class="timeline-info">
												<i class="timeline-indicator icon-star btn btn-info no-hover green"></i>
											</div>
	
											<div class="widget-box transparent">
												<div class="widget-header widget-header-small hidden"></div>
	
												<div class="widget-body">
													<div class="widget-main">
														<i class="icon-star" style="color:#E45B50;"></i>&nbsp;主题:
														&nbsp;<textarea class="label label-info" style="width:80%;max-width:250px;resize:none;"disabled="disabled" id="subject_editable_${notice_item._notice.notice_id}">#${notice_item._notice.subject}#</textarea>
													</div>
												</div>
											</div>
										</div>
	
										<div class="timeline-item clearfix">
											<div class="timeline-info">
												<i class="timeline-indicator icon-bug btn btn-danger no-hover"></i>
											</div>
	
											<div class="widget-box transparent">
												<div class="widget-header widget-header-small" style="background-color:#527094;">
													<h5 class="smaller" style="color:white;">Status</h5>
												</div>
	
												<div class="widget-body">
													<div style="padding:6px;">
														<div class="space-6"></div>
														<c:if test="${notice_item.is_valid=='公告已过期'}">
															<span class="label">${notice_item.is_valid}</span>
														</c:if>
														<c:if test="${notice_item.is_valid=='公告进行中'}">
															<span class="label label-info">${notice_item.is_valid}</span>
															<span class="label label-danger">将在${notice_item._notice.end_date}过期</span>
														</c:if>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- /.timeline-items -->
								</div>
								<!-- /.timeline-container -->
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="add_notice_page" style="width:50%;height:40%;min-height:300px;min-width:300px;margin:auto; margin-top:10%; background-color:white;">
	<div class="modal-header" style="background-color:#3a87ad;">
		<button class="close" type="button" data-dismiss="modal">×</button>
		<span id="add_notice_header" class="label label-info" style="font-size:20px;line-height:1.5; height:40px;">添加公告</span>
	</div>
	<div class="modal-body">
		<table class="table-striped table-bordered" style="width:100%;">
			<tbody>
				<tr>
					<td style="margin:auto;text-align:center;">主题:</td>
					<td><input type="text" id="subject_input" style="width:100%;"></td>
				</tr>
				<tr>
					<td style="margin:auto;text-align:center;">公告内容:</td>
					<td><textarea type="text" id="notice_content_input" style="width:100%;resize:none;"></textarea>
				</tr>
				<tr>
					<td style="margin:auto;text-align:center;">过期时间:</td>
					<td><input type="text" id="end_date_input" style="width:100%;"></td>
				</tr>
			</tbody>
		</table>
		<span>
			<span class="pull-left" style="color:red;"><i class="icon-warning-sign"></i>&nbsp;主题长度不能超过16个字，公告内容不能超过200个字</span>
			<button id="btn_notice_publish" class="pull-right btn btn-app btn-info" style="margin-top:20px;">发布</button>
		</span>
	</div>
</div>

<%@ include file="footer.jsp"%>

<script type="text/javascript">
	$(function(){
		$("[data-toggle='tooltip']").tooltip();
		
		var course_id = ${current_course.course_id};
		var publisher = "${user_info.name}";
		
		$('#btn_notice_publish').click(function(){
			var content = document.getElementById('notice_content_input').value;
			var subject = document.getElementById('subject_input').value;
			var end_date = document.getElementById('end_date_input').value;
			
			if(subject.length == 0 || content.length == 0 || end_date.length == 0){
				alert("请把发布的公告信息填写完整");
				return;
			}
			if(subject.length>16){
				alert("主题长度不能超过16，当前长度为"+subject.length);
				return;
			}
			if(content.length > 200){
				alert("公告内容长度不能超过200，当前长度为"+content.length);
				return;
			}
			
			document.getElementById('subject_input').value = "";
			document.getElementById('notice_content_input').value = "";
			document.getElementById('end_date_input').value = "";
			
			var full_time = new Date();
			var month = (full_time.getMonth()+1) < 10 ? "0"+(full_time.getMonth()+1) : full_time.getMonth()+1;
			var day = full_time.getDate() < 10 ? "0"+full_time.getDate() : full_time.getDate();
			var date = full_time.getFullYear() + "-" + month + "-" + day;
			
			var hours = full_time.getHours() < 10 ? "0" + full_time.getHours() : full_time.getHours();
			var min = full_time.getMinutes() < 10 ? "0" + full_time.getMinutes() : full_time.getMinutes();
			var time = hours + ":" + min;

			$.ajax({
				url : '/ClassManagement/notice/publish',
				data :{course_id:course_id, content:content, subject:subject, end_date:end_date, date:date, time:time, publisher:publisher},
				type : 'post',
				
				success:function(){
					$('#add_notice_page').modal('hide');
					alert("公告发布成功");
					window.location.href = window.location.href;
				}
			});
			
		});
	});
	
	function operation(oper, notice_id){
		var is_teacher = ${is_teacher};
		if(!is_teacher){
			alert("无权限操作");
			return;
		}
		if(oper == "delete"){
			var result = confirm("确定删除？");
			if(result){
				$.ajax({
					url:"/ClassManagement/notice/delete",
					data:{notice_id:notice_id},
					type:"post",
					
					success : function(){
						document.getElementById('notice_detail_'+notice_id).style.display="none";
					}
				});
			}
		}
		/** 将公告内容变成可编辑状态 */
		if(oper == "edit"){
			document.getElementById("content_editable_"+notice_id).disabled="";
			document.getElementById("subject_editable_"+notice_id).disabled="";
			document.getElementById("content_editable_"+notice_id).focus();
		}
		
		if(oper == "save"){
			document.getElementById("content_editable_"+notice_id).disabled="disabled";
			document.getElementById("subject_editable_"+notice_id).disabled="disabled";
			
			var content = document.getElementById("content_editable_"+notice_id).value;
			var subject = document.getElementById("subject_editable_"+notice_id).value;

			$.ajax({
				url:'/ClassManagement/notice/update',
				data:{notice_id:notice_id, content:content, subject:subject},
				type:"post",
				
				success : function(r){
					if(r == "success"){
						alert("保存成功");
					}else{
						alert("保存失败：出现未知错误");
					}
				},
				error : function(){
					alert("保存失败，出现未知错误");
				}
			});
		}
	}
</script>