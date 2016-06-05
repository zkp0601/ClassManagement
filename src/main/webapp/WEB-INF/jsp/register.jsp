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
	<h1>新用户注册</h1>
    <form action="../register/index" method="post">
        <input type="text" name="username" class="username" placeholder="用户名" /><label style="color:red; font-size:20px; margin-left:8px;">*</label>
        <input type="text" name="name" class="name" placeholder="姓名" /><label style="color:red; font-size:20px; margin-left:8px;">*</label>
        <input type="text" name="sex" class="sex" placeholder="性别">&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="text" name="personal_num" placeholder="学号/教师工号" />&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="text" name="phone_num" placeholder="电话号码" />&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="text" name="email" class="email" placeholder="邮箱" /><label style="color:red; font-size:20px; margin-left:8px;">*</label>
        <input type="password" name="password" class="password" placeholder="密码" /><label style="color:red; font-size:20px; margin-left:8px;">*</label>
        <input type="password" name=pass_confirm" class="pass_confirm" placeholder="确认密码" /><label style="color:red; font-size:20px; margin-left:8px;">*</label>
        <div class="error"><span>+</span></div>
        
        <p class="submit">
            <button type="submit" tabindex="100" />注册</button>&nbsp;&nbsp;&nbsp;&nbsp;
        	<a href="../user/login" style="float:right;margin-top:5%;text-decoration:none;color:white;">已注册？点此登录</a>
        </p>
    </form>

     <!-- Javascript -->
     <script type="text/javascript" src='<c:url value="/js/jquery-1.8.2.min.js"></c:url>'></script>
     <script type="text/javascript" src='<c:url value="/js/register.js"></c:url>'></script>
     <script type="text/javascript" src='<c:url value="/js/supersized.3.2.7.min.js"></c:url>'></script>
     <script type="text/javascript" src='<c:url value="/js/supersized-init.js"></c:url>'></script>
</div>

<div class="clear"></div>
</body>
</html>
