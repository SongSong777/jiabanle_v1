<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());

%>
<script type="text/javascript" src="${APP_PATH}/static/js/echarts.js"></script>
</head>

<body>
	<div class="container">
		<!-- 页面标题 -->
		<div class="row">
			<div class="col-md-12" id="title">
				<h3></h3>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">	
				<form class="form-horizontal" id="billDetailsForm">
					<div class="form-group">
						  <label for="orderNum" class="col-sm-2 control-label">订单数量:</label>
						  <div class="col-sm-1">
						    <p class="form-control-static" id="orderNum"></p>
						  </div>
						  <label for="orderNum" class="col-sm-2 control-label">消费员工:</label>
						  <div class="col-sm-1">
						    <p class="form-control-static" id="userNum"></p>
						  </div>
						  <label for="goodsNum" class="col-sm-2 control-label">商品销量：</label>
						  <div class="col-sm-1">
						    <p class="form-control-static" id="goodsNum"></p>
						  </div>
						  <label for="total" class="col-sm-2 control-label">销售总额：</label>
						  <div class="col-sm-1">
						    <p class="form-control-static" id="total"></p>
						  </div>
						  
					</div>		  		  				  
				</form>
			</div>
		</div>
		<div class="row" style="margin-bottom:10px; ">
			<div class="col-md-12">	
				<div id="orderChart" style="width:600px; height:400px; margin:auto;">	
						
				</div>
			</div>
		</div>
		
		<div class="row" style="margin-bottom:10px; ">
			<div class="col-md-12">	
				<div id="goodsChart" style="width:600px; height:400px; margin:auto;">	
					
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		
		$(function(){
		      var df = new Date();
		      var year =df.getFullYear();
		      //console.log(year);
		      var month = df.getMonth()+1;
		      //console.log(month);
		      $("#title h3").text(year+"年"+month+"月消费统计");
		});
		
		$(function(){
			$.ajax({
				url:"${APP_PATH}/charts",
				type:"GET",
				success:function(result){
					console.log(result);
					$("#orderNum").text(result.extend.orderCounts[2]+"个");
					$("#userNum").text(result.extend.userCount+"人");
					$("#goodsNum").text(result.extend.goodsCount+"个");
					$("#total").text(numToMoney(result.extend.totalSum)+"元");
					
					
				}				
			});		      
		});
		
		
		
	
	
	
	</script>

</body>
</html>