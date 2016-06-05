<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>一站式课程管理系统</title>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<!-- CSS -->
	<link rel='stylesheet' href='<c:url value="/css/reset.css"></c:url>' type="text/css"/>
	<link rel='stylesheet' href='<c:url value="/css/supersized.css"></c:url>' type="text/css"/>
	<link rel='stylesheet' href='<c:url value="/css/style.css"></c:url>' type="text/css"/>
	
</head>
<body>
<div class="page-container">
	<% 	
		String register_result = request.getAttribute("register").toString();
		if( register_result.equals("register_success") ) {
	%>
			<h1>注册成功, 2秒后跳转至登录页面...</h1>
	<% 
			// 设置在该页面停留2秒
			String URL = "/ClassManagement/user/login";
			String content = 2 + ";URL=" + URL;
			response.setHeader("REFRESH", content); 
		}
	%>
	
    <!-- Javascript -->
    <script type="text/javascript" src='<c:url value="/js/jquery-1.8.2.min.js"></c:url>'></script>
    <script type="text/javascript" src='<c:url value="/js/scripts.js"></c:url>'></script>
    <script type="text/javascript" src='<c:url value="/js/supersized.3.2.7.min.js"></c:url>'></script>
    <script type="text/javascript" src='<c:url value="/js/supersized-init.js"></c:url>'></script>
</div>
</body>
</html>
