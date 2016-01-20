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
			<li class="active" style="color:#DA5430;weight:bold;">${current_course.course_name}</li>
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

	<!-- Notice -->
	<div class="page-content">
		<div class="row">
			<div class="col-xs-12" style="width: 96%;">
				<div class="well" style="background-color: ghostwhite">
					<div class="page-header">
						<h1>
							课程概况总览 <small> <i class="icon-double-angle-right"></i>
								Course Overview
							</small>
						</h1>
					</div>
					<!-- /.page-header -->

					<div class="row">
						<div class="col-sm-6">
							<h3 class="header smaller lighter green">
								&nbsp;<i class="icon-bullhorn"></i> 公告专栏
								<small style="float:right;margin-top:12px;">
									<a href="/ClassManagement/notice/index?course_id=${current_course.course_id}">
										<i class="icon-hand-right">&nbsp;查看公告详情</i>
									</a>
								</small>
							</h3>
							<div id="notification" class="accordion-style1 panel-group">
								<div class="panel panel-default" style="background-color:ghostwhite;">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse"
												data-parent="#accordion" href="#collapseOne"> <i
												class="icon-angle-down bigger-110"
												data-icon-hide="icon-angle-down"
												data-icon-show="icon-angle-right"></i> &nbsp;<i class="icon-bell-alt icon-animated-bell"></i>&nbsp;&nbsp;Notification
											</a>
										</h4>
									</div>

									<div class="panel-collapse collapse in" id="collapseOne" style="overflow:auto;height:150px;background-color:ghostwhite;">
										<ol style="color:#4c8fbd;">
										<c:forEach items="${notices}" var="notice">
											<li style="border:1px solid #cdd8e3; margin-top:10px;">
												<i class="icon-star btn btn-warning no-hover" style="border-radius: 100%;font-size: 16px;height: 36px;line-height: 30px;width: 36px;text-align: center;text-shadow: none!important;padding: 0;border: 3px solid #FFF!important;"></i>
												<span class="pull-right" style="padding:5px;">
													<i class="icon-time green">&nbsp;${notice.date}&nbsp;${notice.time}&nbsp;</i>
												</span>
												<table style="width:100%; border-top:1px solid #cdd8e3;">
													<tr>
														<td class="label label-danger" style="border:1px solid #cdd8e3;width:100%;">发布者:</td><td style="font-weight:bold;color:#4c8fbd;padding-left:10px;">${notice.publisher}</td>
													</tr>
													<tr>
														<td class="label label-danger" style="border:1px solid #cdd8e3;width:100%;">主题:</td><td style="font-weight:bold;color:#4c8fbd;padding-left:10px;">${notice.subject }</td>
													</tr>
													<tr>
														<td class="label label-danger" style="border:1px solid #cdd8e3;width:100%;">公告内容:</td><td style="font-weight:bold;color:#4c8fbd;padding-left:10px;">${notice.content}</td>
													</tr>
												</table>
											</li>
											<br/>
										</c:forEach>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<!-- /span -->

						<div class="col-sm-6">
							<h3 class="header smaller lighter orange">
								&nbsp;<i class="icon-trophy"></i> 考勤专栏
								<small style="float:right;margin-top:12px;">
									<a href="/ClassManagement/sign/signRecord?course_id=${current_course.course_id}"><i class="icon-hand-right">&nbsp;查看出勤详情</i></a>
								</small>
								<!-- /span -->
							</h3>
							<div>
								<table class="table table-striped table-bordered" style="background-color:ghostwhite !important;">
									<thead>
										<tr>
											<th style="text-align:center;">已完成课时率</th>
											<th style="text-align:center;">迟到率</th>
											<th style="text-align:center;">早退率</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th style="text-align:center;">
												<div class="easy-pie-chart percentage" id="present_percent" data-percent="95" data-color="#3A963A">
													<span class="percent" id="present_percent_content">95%</span>
												</div>
											</th>
											<th style="text-align:center;">
												<div class="easy-pie-chart percentage" id="late_percent" data-percent="0" data-color="#4398AF">
													<span class="percent" id="late_percent_content">0%</span>
												</div>
											</th>
											<th style="text-align:center;">
												<div class="easy-pie-chart percentage" id="earlyLeave_percent" data-percent="5" data-color="#BF3838">
													<span class="percent" id="earlyLeave_percent_content">5%</span>
												</div>
											</th>
										</tr>
										<tr style="border:none;">
											<th style="text-align:center;"><button class="btn btn-inverse" id="signIn">今日签到</button></th>
											<th style="text-align:center;">--</th>
											<th style="text-align:center;"><button class="btn btn-inverse" id="signOut">今日签退</button></th>
										</tr>
									</tbody>
								</table>
								<!-- table end -->
							</div>
						</div>
					</div>
				</div>
				<!-- /well -->
				<div class="well" style="width:100%;background-color: ghostwhite;display:block; float:left;">
					<div class="page-header">
						<h1>
							我的同学 
							<small> <i class="icon-double-angle-right"></i>
								My ClassMates
							</small>
						</h1>
					</div>
					
					<c:forEach items="${user_infos}" var="classmate_info">
						<c:if test="${classmate_info.user_id !=  user_info.user_id}">
							<table style="border:1px solid #cdd8e3;display:block; float:left;margin:10px;">
								<tr>
									<th class="ace-nav" style="line-height:45px;height: 45px;">
										<img class="nav-user-photo" src='<c:url value="/img/avatars/user.jpg"></c:url>' alt="Kalper's Photo" />
									</th>
									<th style="color:#2679b5;">${classmate_info.name}</th>
									<th style="padding-left:10px;">
										<a href='/ClassManagement/user/profile?user_id=${classmate_info.user_id}'><button class="btn btn-primary" style="padding:3px 8px;">查看资料</button>
										<a href='#' onclick='openChattingRoom(${classmate_info.user_id})'><button class="btn btn-primary" style="padding:3px 8px;">发起聊天</button></a>
									</th>
								</tr>
							</table>
						</c:if>
					</c:forEach>
				</div>
			</div>
			<!-- /row -->
		</div>
	</div>
	
</div>
<%@ include file="footer.jsp"%>
<script type="text/javascript">
	
	function openChattingRoom(receiver_id){
		window.open('/ClassManagement/user/chatting?receiver_id='+receiver_id, 'newwindow', 
				'height=420px, width=600px, top=200px, left=400px, toolbar=no, menubar=no, scrollbars=no, resizable=true, location=no, status=no');
	}
	jQuery(function($) {
		/**
		$('#myTab a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		  console.log(e.target.getAttribute("href"));
		})
		 */
		
		/* $('#show_chatting_room_btn').click(function(){
			var display = $('#show_chatting_room').attr('style');
			if(display == 'display:none')
				$('#show_chatting_room').attr('style',"display:block;");
			else
				$('#show_chatting_room').attr('style', "display:none");
		}); */
		var user_id = 0;
		$.ajax({
			url: "/ClassManagement/user/getCurrentUserFromSession",
			data: {attribute:"currentUser"},
			type : 'post',
			dataType: 'json',
			async: false,
			success : function(r){
				if(r.user_id){
					user_id = r.user_id;
				}
			}
		});
		
		// 获取url参数
		function getUrlParameters(){
			var url = location.search;
			var requestParams = new Object();
			
			if(url.indexOf("?") != -1){
				var str = url.substr(1);
				var param_array = str.split("&");
				for(var i = 0; i < param_array.length; i++){
					requestParams[param_array[i].split("=")[0]] = param_array[i].split("=")[1]
				}
			}
			return requestParams;
		}
		var requestParams = getUrlParameters();
		var course_id = requestParams["course_id"];
		
		// 设置课程首页的迟到率，早退率等
		$.ajax({
			url:'/ClassManagement/sign/getSignRecordData',
			data:{course_id:course_id},
			type:'post',
			dataType:'json',
			async:false,
			
			success : function(resultMap){
				var finish_class_percent = (resultMap.allSignRecords.length / resultMap.total_class_num * 100).toFixed(1);
				var late_percent = (resultMap.lateSignRecords.length / resultMap.total_class_num * 100).toFixed(1);
				var earlyLeave_percent = (resultMap.earlyLeaveSignRecords.length / resultMap.total_class_num * 100).toFixed(1);
				
				$('#present_percent').attr('data-percent', Math.round(finish_class_percent));
				$('#late_percent').attr('data-percent', Math.round(late_percent));
				$('#earlyLeave_percent').attr('data-percent', Math.round(earlyLeave_percent));
				document.getElementById('present_percent_content').innerHTML = finish_class_percent+'%';
				document.getElementById('late_percent_content').innerHTML = late_percent+'%';
				document.getElementById('earlyLeave_percent_content').innerHTML = earlyLeave_percent+'%';
			}
		})
		
		var oldie = /msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase());
		$('.easy-pie-chart.percentage').each(function() {
			$(this).easyPieChart({
				barColor : $(this).data('color'),
				trackColor : '#EEEEEE',
				scaleColor : false,
				lineCap : 'butt',
				lineWidth : 8,
				animate : oldie ? false : 1000,
				size : 75
			}).css('color', $(this).data('color'));
		});
		
		// 获取当前日期，格式 YYYY-MM-DD
		function getCurrentDate(){
			var date = new Date();
			var year = date.getFullYear();
			var month = date.getMonth() + 1;
			var day = date.getDate();
			
			month = month < 10 ? ( "0" + month ) : month;
			day = day < 10 ? ( "0" + day ) : day;
			
			var time = year + "-" + month + "-" + day;
			return time;
		}
		
		// 获取当前时间,转成int类型存储
		function getCurrentTime(){
			var date = new Date();
			var hour = date.getHours() * 3600;
			var min = date.getMinutes() * 60;
			var sec = date.getSeconds();
			
			return hour + min + sec;
		}
		
		$('#signIn').click(function(){
			var date = getCurrentDate();
			var time = getCurrentTime();
			$.ajax({
				url: '/ClassManagement/sign/signIn',
				data: { user_id : user_id, course_id : course_id, sign_date : date, signInTime : time},
				type: 'post',
				
				success : function(r){
					if(r == "successed"){
						alert("签到成功");
					}else if(r == "failed"){
						alert("您今日已经签到");
					}else if(r == "refused"){
						alert("无法签到，请连上相应的网络");
					}else if(r == "redirect://ClassManagement/user/login"){
						window.location.href = "/ClassManagement/user/login";
					}
				},
				error : function(){
					alert("签到异常，请稍后再试");
				} 
			})
		})
		
		$('#signOut').click(function(){
			var date = getCurrentDate();
			var time = getCurrentTime();
			$.ajax({
				url : '/ClassManagement/sign/signOut',
				data: {user_id : user_id, course_id : course_id, sign_date : date, signOutTime : time},
				type: 'post',
				
				success : function(r){
					if(r == "successed"){
						alert("签退成功");
					}else if(r == "failed"){
						alert("您今日已经签退");
					}else if(r == "refused"){
						alert("无法签退，请连上相应的网络");
					}else if(r == "redirect://ClassManagement/user/login"){
						window.location.href = "/ClassManagement/user/login";
					}
				},
				error : function(){
					alert("签退异常，请稍后再试");
				}
			})
		})
		
		
	});
</script>