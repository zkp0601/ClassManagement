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
			<li><i class="icon-dashboard"></i> <a href="/ClassManagement/index/">我的课程</a></li>
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
							</h3>
							<div id="notification" class="accordion-style1 panel-group">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse"
												data-parent="#accordion" href="#collapseOne"> <i
												class="icon-angle-down bigger-110"
												data-icon-hide="icon-angle-down"
												data-icon-show="icon-angle-right"></i> &nbsp;Notification
											</a>
										</h4>
									</div>

									<div class="panel-collapse collapse in" id="collapseOne">
										<div class="panel-body">Anim pariatur cliche
											reprehenderit, enim eiusmod high life accusamus terry
											richardson ad squid. 3 wolf moon officia aute, non cupidatat
											skateboard dolor brunch. Food truck quinoa nesciunt laborum
											eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on
											it squid single-origin coffee nulla assumenda shoreditch et.
											Nihil anim keffiyeh helvetica, craft beer labore wes anderson
											cred nesciunt sapiente ea proident.</div>
									</div>
								</div>
							</div>
						</div>
						<!-- /span -->

						<div class="col-sm-6">
							<h3 class="header smaller lighter orange">
								&nbsp;<i class="icon-trophy"></i> 考勤专栏
								<small style="float:right;margin-top:12px;">
									<a href="/ClassManagement/sign/signRecord?user_id=${user_info.user_id}"><i class="icon-hand-right">&nbsp;查看详情</i></a>
								</small>
								<!-- /span -->
							</h3>
							<div>
								<table class="table table-striped table-bordered" style="background-color:ghostwhite !important;">
									<thead>
										<tr>
											<th style="text-align:center;">出勤率</th>
											<th style="text-align:center;">迟到率</th>
											<th style="text-align:center;">早退率</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th style="text-align:center;">
												<div class="easy-pie-chart percentage" data-percent="90"
													data-color="#3A963A">
													<span class="percent">90</span>%
												</div>
											</th>
											<th style="text-align:center;">
												<div class="easy-pie-chart percentage" data-percent="10"
													data-color="#4398AF">
													<span class="percent">10</span>%
												</div>
											</th>
											<th style="text-align:center;">
												<div class="easy-pie-chart percentage" data-percent="5"
													data-color="#BF3838">
													<span class="percent">5</span>%
												</div>
											</th>
										</tr>
										<tr style="border:none;">
											<th style="text-align:center;"><button class="btn-app btn-success" id="signIn">今日签到</button></th>
											<th style="text-align:center;">--</th>
											<th style="text-align:center;"><button class="btn-app btn-success" id="signOut">今日签退</button></th>
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
									<th style="color:#2679b5;margin-right:10px;">${classmate_info.name}</th>
									<th>
										<a href='/ClassManagement/user/profile?user_id=${classmate_info.user_id}'><button class="btn-app btn-success">查看资料</button>
										<a href='#' onclick='openChattingRoom(${classmate_info.user_id})'><button class="btn-app btn-success">发起聊天</button></a>
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
						alert("当前IP不符合，无法签到");
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
						alert("当前IP不符合，无法签退");
					}
				},
				error : function(){
					alert("签退异常，请稍后再试");
				}
			})
		})
		
		
	});
</script>