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
			<li class="active">查看详情</li>
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

	<div class="page-content" style="margin-left:10px;">
		<div class="row">
			<div class="col-xs-12" style="width: 96%;">
				<div class="widget-box">
					<div class="widget-header header-color-dark" id="widget-header-color">
						<h5 class="bigger lighter">
							<i class="icon-table"></i> 签到签退详情 <i class="icon-double-angle-right"></i>
								Sign Record Detail
						</h5>

						<div class="widget-toolbar widget-toolbar-light no-border">
							<select id="simple-colorpicker" class="hide" style="display: none;">
								<option selected="" data-class="dark" value="#404040">#404040</option>
								<option data-class="blue2" value="#5090C1">#5090C1</option>
								<option data-class="blue3" value="#6379AA">#6379AA</option>
								<option data-class="green" value="#82AF6F">#82AF6F</option>
								<option data-class="green2" value="#2E8965">#2E8965</option>
								<option data-class="green3" value="#5FBC47">#5FBC47</option>
								<option data-class="red" value="#E2755F">#E2755F</option>
								<option data-class="red2" value="#E04141">#E04141</option>
								<option data-class="red3" value="#D15B47">#D15B47</option>
								<option data-class="orange" value="#FFC657">#FFC657</option>
								<option data-class="purple" value="#7E6EB0">#7E6EB0</option>
								<option data-class="pink" value="#CE6F9E">#CE6F9E</option>
								<option data-class="blue" value="#307ECC">#307ECC</option>
								<option data-class="grey" value="#848484">#848484</option>
								<option data-class="default" value="#EEE">#EEE</option>
							</select>
						</div>
					</div>

					<c:if test="${is_teacher==true}">
						<div class="widget-body">
							<div class="widget-main no-padding">
								<table class="table table-striped table-bordered table-hover">
									<thead class="thin-border-bottom">
										<tr>
											<th><i class="icon-user" style="color:#3a87ad!important;"></i> 用户ID</th>
											<th><i class="icon-time green"></i> 出勤</th>
											<th><i class="icon-spinner orange"></i> 迟到</th>
											<th><i class="icon-remove red"></i> 早退</th>
										</tr>
									</thead>
	
									<tbody>
										<c:forEach items="${records}" var="record">
											<tr>
												<td>
													<span class="label label-info">
														<a href="/ClassManagement/user/profile?user_id=${record.value.user_id}" data-toggle="tooltip" title="点击查看" style="color:white">
															${record.value.user_id}
														</a>
													</span>
												</td>
		
												<td><span class="label label-success">${record.value.present_times}次</span></td>
		
												<td><span class="label label-warning">${record.value.late_times}次</span></td>
												<td><span class="label label-danger">${record.value.earlyLeave_times}次</span></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</c:if>
					
					<c:if test="${is_teacher==false}">
						<div class="widget-body">
							<div class="widget-main no-padding">
								<table class="table table-striped table-bordered table-hover">
									<thead class="thin-border-bottom">
										<tr>
											<th><i class="icon-calendar" style="color:#3a87ad!important;"></i> 日期</th>
											<th><i class="icon-level-up black"></i> 签到</th>
											<th><i class="icon-level-down black"></i> 签退</th>
											<th><i class="icon-shield green"></i> 状态</th>
										</tr>
									</thead>
	
									<tbody>
										<c:forEach items="${records}" var="signRecord">
											<tr>
												<td><span class="label label-info"><c:out value="${signRecord.sign_date}"/></span></td>
		
												<td><span class="label label-inverse arrowed arrowed-right">${signRecord.signInTime}</span></td>
		
												<td><span class="label label-inverse arrowed arrowed-right">${signRecord.signOutTime}</span></td>
												<td>
													<c:if test="${signRecord.late=='false' &&signRecord.earlyLeave=='false'}"><span class="label label-success">正常</span></c:if>
													<c:if test="${signRecord.late=='true'}"><span class="label label-warning">迟到</span></c:if>
													<c:if test="${signRecord.earlyLeave=='true'}"><span class="label label-danger">早退</span></c:if>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</c:if>
					
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="footer.jsp"%>

<script type="text/javascript">

	$(function () { $("[data-toggle='tooltip']").tooltip(); });

	jQuery(function($) {
		$("#simple-colorpicker").ace_colorpicker({pull_right:true}).on('change', function(){
			var color_class = $(this).find('option:selected').data('class');
			var new_class = 'widget-header';
			if(color_class != 'default')  new_class += ' header-color-'+color_class;
			$('#widget-header-color').attr('class', new_class);
		});
	});
</script>