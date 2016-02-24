<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>一站式课程管理系统</title>
		<meta name="keywords" content="Bootstrap模版,Bootstrap模版下载,Bootstrap教程,Bootstrap中文" />
		<meta name="description" content="站长素材提供Bootstrap模版,Bootstrap教程,Bootstrap中文翻译等相关Bootstrap插件下载" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />

		<!-- basic styles -->
		<link href='<c:url value="/css/bootstrap.min.css"></c:url>' rel="stylesheet" />
		<link rel="stylesheet" href='<c:url value="/css/fontawesome/font-awesome.min.css"></c:url>' />

		<!--[if IE 7]>
		  <link rel="stylesheet" href="assets/css/font-awesome-ie7.min.css" />
		<![endif]-->

		<!-- page specific plugin styles -->
		<link rel="stylesheet" href='<c:url value="/css/jquery.gritter.css"></c:url>' />
		<link rel="stylesheet" href='<c:url value="/css/select2.css"></c:url>' />
		<link rel="stylesheet" href='<c:url value="/css/select2.css"></c:url>' />
		<link rel="stylesheet" href='<c:url value="/css/bootstrap-editable.css"></c:url>' />
		<!-- fonts -->

		<!--  加载失败，故注释掉
			<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300" />
		-->
		<!-- ace styles -->

		<link rel="stylesheet" href='<c:url value="/css/ace.min.css"></c:url>' />
		<link rel="stylesheet" href='<c:url value="/css/ace-rtl.min.css"></c:url>' />
		<link rel="stylesheet" href='<c:url value="/css/ace-skins.min.css"></c:url>' />

		<!--[if lte IE 8]>
		  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
		<![endif]-->

		<!-- inline styles related to this page -->

		<!-- ace settings handler -->
		<script>
    		var start_time = new Date();
    		var end_time = "" ;
    		var t = setInterval(function(){
       			if(document.readyState=="complete"){showRunTime();}
    			},500)
 
    		function showRunTime(){
        		end_time = new Date();
        		document.getElementById("runTime").innerHTML = "执行时间: " + (end_time.getTime()/1000.0 - start_time.getTime()/1000.0  + "s");
        		clearInterval(t);
    		}
		</script>
		<script src='<c:url value="/js/ace-extra.min.js"></c:url>'></script>
		<script src='<c:url value="/js/sockjs.min.js"></c:url>'></script>
		<script type="text/javascript">
			// websocket 实现
			var url = "ws://192.168.1.109:8080/ClassManagement/websocket";
			var ws = new WebSocket(url);
			
		</script>
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

		<!--[if lt IE 9]>
		<script src="assets/js/html5shiv.js"></script>
		<script src="assets/js/respond.min.js"></script>
		<![endif]-->
	</head>

	<body onunload="closeSubwin();">
		<div class="navbar navbar-default" id="navbar">
			<script type="text/javascript">
				try{ace.settings.check('navbar' , 'fixed')}catch(e){}
			</script>

			<div class="navbar-container" id="navbar-container">
				<div class="navbar-header pull-left">
					<a href="/ClassManagement/" class="navbar-brand">
						<small>
							<span style="font-size:30px;">♔</span>
							一站式课程管理系统
						</small>
					</a><!-- /.brand -->
				</div><!-- /.navbar-header -->

				<div class="navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
						<li class="grey">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-tasks"></i>
								<span class="badge badge-info"></span>
							</a>

							<ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close" id="all_my_courses">
							
							</ul>
						</li>

						<li class="purple">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-bell-alt icon-animated-bell"></i>
								<span class="badge badge-important" id="total_notices_num"></span>
							</a>

							<ul class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close" id="all_notices_show">
								
							</ul>
						</li>

						<li class="green">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-comment icon-animated-vertical"></i>
								<span class="badge badge-success" id="unread_message_num"></span>
							</a>

							<ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close" id="message_unread_show">
								<li class="dropdown-header">
									<i class="icon-envelope-alt"></i>
									Received Messages
								</li>

								<li>
									<a href="#">
										<img src='<c:url value="/img/avatars/avatar.jpg"></c:url>' class="msg-photo" alt="Alex's Avatar" />
										<span class="msg-body">
											<span class="msg-title">
												<span class="blue">Alex:</span>
												Ciao sociis natoque penatibus et auctor ...
											</span>

											<span class="msg-time green">
												<i class="icon-time green"></i>
												<span>a moment ago</span>
											</span>
										</span>
									</a>
								</li>

								<li style="background-color:#ecf2f7;">
									<div style="text-align:center; color:#8090a0;">
										<i class="icon-fire"></i>End
										<i class="icon-fire"></i>
									<div>
								</li>
							</ul>
						</li>

						<li class="light-blue">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<img class="nav-user-photo" src='<c:url value="/img/avatars/user.jpg"></c:url>' alt="Kalper's Photo" />
								${user_info.name}
								<i class="icon-caret-down"></i>
							</a>

							<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<li>
									<a href="/ClassManagement/user/profile">
										<i class="icon-edit"></i>编辑信息
									</a>
								</li>

								<li>
									<a href="#">
										<i class="icon-trophy"></i><span>签到记录</span>
									</a>
								</li>

								<li class="divider"></li>

								<li>
									<a href="/ClassManagement/user/logout">
										<i class="icon-off"></i>退出
									</a>
								</li>
							</ul>
						</li>
					</ul><!-- /.ace-nav -->
				</div><!-- /.navbar-header -->
			</div><!-- /.container -->
		</div>

		<div class="main-container" id="main-container">
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>

			<div class="main-container-inner">
				<a class="menu-toggler" id="menu-toggler" href="#">
					<span class="menu-text"></span>
				</a>

				<div class="sidebar" id="sidebar">
					<script type="text/javascript">
						try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
					</script>

					<div class="sidebar-shortcuts" id="sidebar-shortcuts">

						<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
							<span class="btn btn-success"></span>

							<span class="btn btn-info"></span>

							<span class="btn btn-warning"></span>

							<span class="btn btn-danger"></span>
						</div>
					</div><!-- #sidebar-shortcuts -->

					<ul class="nav nav-list">
						<li class="active">
							<a href="/ClassManagement/index">
								<i class="icon-home" style="font-size:18px;"></i>
								<span class="menu-text"> 首页 </span>
							</a>
						</li>
						
						<li>
							<a href="#" class="dropdown-toggle">
								<i class="icon-dashboard"></i>
								<span class="menu-text"> 我的课程 </span>
								
								<b class="arrow icon-angle-down"></b>
							</a>
							<ul class="submenu">
								<li>
									<a href="#">
										<i class="icon-double-angle-right"></i>
											数据结构
									</a>
								</li>
								<li>
									<a href="#">
										<i class="icon-double-angle-right"></i>
										Java EE
									</a>
								</li>
							</ul>
						</li>

						<li>
							<a href="/ClassManagement/user/profile">
								<i class="icon-edit"></i>
								<span class="menu-text"> 个人信息 </span>
							</a>
						</li>

						<li>
							<a href="/ClassManagement/index/calendar">
							<i class="icon-calendar"></i>
								<span class="menu-text">日历</span>
							</a>
						</li>

						<li class="active open">
							<a href="#" class="dropdown-toggle">
								<i class="icon-list"></i>

								<span class="menu-text">
									其他
									<span class="badge badge-primary ">5</span>
								</span>
							</a>

							<ul class="submenu">
								<li>
									<a href="faq.html">
										<i class="icon-double-angle-right"></i>
										帮助
									</a>
								</li>

								<li>
									<a href="error-404.html">
										<i class="icon-double-angle-right"></i>
										404错误页面
									</a>
								</li>

								<li>
									<a href="error-500.html">
										<i class="icon-double-angle-right"></i>
										500错误页面
									</a>
								</li>

								<li>
									<a href="grid.html">
										<i class="icon-double-angle-right"></i>
										网格
									</a>
								</li>

								<li class="active">
									<a href="blank.html">
										<i class="icon-double-angle-right"></i>
										空白页面
									</a>
								</li>
							</ul>
						</li>
					</ul><!-- /.nav-list -->

					<div class="sidebar-collapse" id="sidebar-collapse">
						<span class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></span>
					</div>

					<script type="text/javascript">
						try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
					</script>
				</div>

				