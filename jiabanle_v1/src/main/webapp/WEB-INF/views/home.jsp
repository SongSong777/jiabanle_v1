<%@page import="com.jiabanle.bean.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ include file = "logincheck.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>加班乐后台管理系统</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());

%>
<!-- web路径：
	不以/开始的相对路径，找资源以当前路径为基准
	以/开始的相对路径，找资源以服务器路径为标准http://localhost:3306，需加项目名
	http://localhost:3306/项目名
 -->
<!-- 引入jquery -->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
<!-- 引入样式 -->
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link href="${APP_PATH}/static/custom/css/public.css" rel="stylesheet">
</head>
<body>


	<!-- 标题栏 -->
    <div class="navbar navbar-inverse">
        <div class="navbar-header">
            <a href="#" class="navbar-brand">加班乐后台管理系统</a>
        </div>
        <div class="navbar-admin" style="float:right">
            <a href="#" class="navbar-brand">Admin:${sessionScope.admin.username}</a>
			<a href="${APP_PATH}/logout" class="navbar-brand">退出</a>
        </div>
    </div>
    <div role="navigation">
    	<ul class="nav nav-tabs" id="myTabs">
			<li role="presentation" class="active"><a href="#">首页</a></li>
			<li role="presentation"><a href="#">账单查询</a></li>
			<li role="presentation"><a href="#">消费查询</a></li>
			<li role="presentation"><a href="#">用户管理</a></li>
			<li role="presentation"><a href="#">商品管理</a></li>
		</ul>
	</div>
		
		
	<div class="page">
		<div>
			<%@ include file="chart.jsp" %>
		</div>
		
		<div style="display: none">
			<%@ include file="bill.jsp" %>
		</div>
			
		<div style="display: none">
			<%@ include file="sale.jsp" %>
		</div>
			
		<div style="display: none">
			<%@ include file="user.jsp" %>
		</div>
		
		<div style="display: none">
			<%@ include file="goods.jsp" %>
			
		</div>

	</div>
	<script type="text/javascript">
	
	$(function(){
		$("#myTabs li").click(function (e) {
			var divShow = $(".page").children("div");
			e.preventDefault();
			$(this).tab("show");
			var index = $(this).index();
			$(divShow[index]).show();
			$(divShow[index]).siblings("div").hide();			  
		});
	})	


	</script>
	
	
</body>
</html>