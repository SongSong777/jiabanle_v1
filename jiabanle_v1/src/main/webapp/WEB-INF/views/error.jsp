<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>error</title>
<style type="text/css">
	.align-center{ 
		margin:0 auto; /* 居中 这个是必须的，，其它的属性非必须 */ 
		width:500px; /* 给个宽度 顶到浏览器的两边就看不出居中效果了 */ 
		text-align:center; /* 文字等内容居中 */ 
	} 
</style>
<script type="text/javascript">
	setTimeout("javascript:location.href='http://localhost:8080/jiabanle_v1/index.jsp'",3000);	
</script>

</head>
<body>
	<div class="align-center">
		<h3>Error</h3>
		<p style="color:red;">${msg}</p>
		<h4><a href="http://localhost:8080/jiabanle_v1/index.jsp" >立即跳转</a></h4>
	</div>
	

</body>
</html>