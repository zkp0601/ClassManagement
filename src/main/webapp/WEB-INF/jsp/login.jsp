<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>一站式课程管理系统</title>
<!-- CSS -->
<link rel='stylesheet' href='<c:url value="/css/bootstrap.min.css"></c:url>' type="text/css" />
<link rel='stylesheet' href='<c:url value="/css/reset.css"></c:url>'
	type="text/css" />
<link rel='stylesheet'
	href='<c:url value="/css/supersized.css"></c:url>' type="text/css" />
<link rel='stylesheet' href='<c:url value="/css/style.css"></c:url>'
	type="text/css" />

</head>
<body>
	<div class="page-container">
		<h1>一站式课程管理系统</h1>
		<form action="../login/index" method="post">
			<c:if test="${login_result == false}">
				<div class="alert alert-danger" style="width:80%;margin-left:10%; margin-bottom:0px; border:none; font-weight:bold;">用户名或者密码错误</div>
			</c:if>
			<input type="text" name="username" class="username" placeholder="用户名">
			<input type="password" name="password" class="password"
				placeholder="密码">
			<div class="error">
				<span>+</span>
			</div>

			<p class="submit">
				<button type="submit" tabindex="100" />
				登录
				</button>
				<a href="../user/register"
					style="float: right; margin-top: 5%; text-decoration: none; color: white;">点此注册</a>
			</p>
		</form>

		<!-- Javascript -->
		<script type="text/javascript"
			src='<c:url value="/js/jquery-1.8.2.min.js"></c:url>'></script>
		<script type="text/javascript"
			src='<c:url value="/js/login.js"></c:url>'></script>
		<script type="text/javascript"
			src='<c:url value="/js/supersized.3.2.7.min.js"></c:url>'></script>
		<script type="text/javascript"
			src='<c:url value="/js/supersized-init.js"></c:url>'></script>
	</div>

	<div class="clear"></div>
</body>
</html>
<script src='<c:url value="/js/jquery.min.js"></c:url>' />
<script src='<c:url value="/js/bootstrap.min.js"></c:url>' />
