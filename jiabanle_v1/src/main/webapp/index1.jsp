<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>加班乐后台</title>
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
<script type="text/javascript" src="${APP_PATH}/static/js/jquery.cookie.js"></script>

<!-- 引入样式 -->
<link href="${APP_PATH}/static/custom/css/login.css" rel="stylesheet">
</head>
<body>
	<div class="mmcontent ">
	<div class="w-top">
		<div class="w960 fn-clear">
			<div class="slogan w-fl">
				<p>欢迎来到数字人加班乐后台管理系统！</p>
			</div>
			
		</div>
	</div>
</div>

<div class="mmcontent ">
	<div class="w-navi">
		<div class="w960 fn-clear navi-header">
			<div class="navi-logo w-fl">
				<a href="#" >
					<img border="0" alt="" src="${APP_PATH}/images/logo.png" style="height:58px">
				</a>
			</div>
			<div class="navi-tit w-fl">
				<span>数字人加班乐 | 欢迎登录</span>
			</div>
		</div>
	</div>
</div>


<div class="mmcontent ">
	<div class="w-con-login">
		<div class="w960 fn-clear">
			<div class="login-img w-fl">
				<div class="login-img-c">
				</div>
			</div>
			<div class="login-con w-fr">
				<div class="login-con-c" style="background:white">
					<form id="loginForm" action="${APP_PATH}/login" method="post" >
						<div class="login-tit">
							<span class="login-error left" style="display:none;"></span>
							<span class="login-title" style="display:inline;">登录</span>
						</div>
						<div class="login-item">
							<div class="w-fl">
								<span class="login-user">
									<em class="y_input_ico y_usr"></em>
								</span>
							</div>
							<div class="w-fl login-input" style="position:relative;">
								<input name="username" id="user_name" type="text" class="y_input_text_d" placeholder="用户名" value="">
								<span style="position:absolute;top:14px;left:100px;display:none;"><img style="height:20px;width:20px;cursor:pointer" src="./优市网登录页面_files/loading333.gif"></span>
							</div>
						</div>
						<div class="login-item">
							<div class="w-fl">
								<span class="login-password">
									<em class="y_input_ico y_pas"></em>
								</span>
							</div>
							<div class="w-fl login-input">
								<input name="password" id="password" type="password" class="y_input_text_d" placeholder="密码">
							</div>
						</div>
						
						<div class="login-item1">
							<span class="w-fl login-remember">
								<input type="checkbox" value="1" id="" name="remember_me">
							</span>
							<span class="w-fl">记住密码</span>
							
						</div>
						<input type="hidden" name="redirect_uri" value="">
						<div class="login-item1">
							<span class="w-fl login-button">
								<input name="" id="submit" type="submit" value="登录" class="">
							</span>
						</div>

					</form>
				</div>
			</div>
		</div>
	</div>
</div>









<script>

var loginTitle = $('.login-title'), loginError = $('.login-error');


function check_user_name(obj) {
	var user_name = obj.val();
	if (user_name == '') {
		loginTitle.hide();loginError.show().text('用户名不得为空！');
		$(this).focus();
		return false;
	} else {
		loginTitle.show();loginError.hide();
	}
	return true;
}

function check_password(obj) {
	var password = obj.val();
	if (password == '') {
		loginTitle.hide();loginError.show().text('密码不得为空！');
		$(this).focus();
		return false;
	}else {
		loginTitle.show();loginError.hide();
	}
	return true;
}



$(function () {

	var but_click = false;

	// 本次url
	var location_href = window.location.href;
	$('#user_name').attr('disabled', false);
	
	$('#user_name').on('blur', function () {
		if (!check_user_name($(this))) {
			return false;
		}
	});
	
	$('#password').on('blur', function () {
		check_password($(this));
	});

	
})
$("#submit").click(function(){
		/* loginTitle.hide();loginError.show().text('用户名或密码错误！');
		$("#loginForm")[0].reset(); */

	});

</script>
</body>
</html>