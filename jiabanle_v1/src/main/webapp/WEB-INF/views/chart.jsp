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
			<div class="col-md-12" id="monthTitle">
				<h3>本月消费统计</h3>
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
				<div id="monthChart" style="width:600px; height:400px; margin:auto;">	
						
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" id="yearTitle">
				<h3>本年消费统计</h3>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">	
				<form class="form-horizontal" id="billDetailsForm">
					<div class="form-group">
						  <label for="yorderNum" class="col-sm-2 control-label">订单数量:</label>
						  <div class="col-sm-1">
						    <p class="form-control-static" id="yorderNum"></p>
						  </div>
						  <label for="yuserNum" class="col-sm-2 control-label">消费员工:</label>
						  <div class="col-sm-1">
						    <p class="form-control-static" id="yuserNum"></p>
						  </div>
						  <label for="ygoodsNum" class="col-sm-2 control-label">商品销量：</label>
						  <div class="col-sm-1">
						    <p class="form-control-static" id="ygoodsNum"></p>
						  </div>
						  <label for="ytotal" class="col-sm-2 control-label">销售总额：</label>
						  <div class="col-sm-1">
						    <p class="form-control-static" id="ytotal"></p>
						  </div>
						  
					</div>		  		  				  
				</form>
			</div>
		</div>
		<div class="row" style="margin-bottom:10px; ">
			<div class="col-md-12">	
				<div id="yearChart" style="width:600px; height:400px; margin:auto;">	
					
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		
		
		$(function(){
			$.ajax({
				url:"${APP_PATH}/charts",
				type:"GET",
				success:function(result){
					console.log(result);
					$("#orderNum").text(result.extend.orderCounts[2]+"个");
					$("#userNum").text(result.extend.userCounts[2]+"人");
					$("#goodsNum").text(result.extend.goodsCount+"个");
					$("#total").text(numToMoney(result.extend.totalSum)+"元");
					
					var myChart1 = echarts.init(document.getElementById("monthChart"),"light");
					option1 = {  
                            title: {  
                                text: '分时段消费人数图'//标题内容  
                            },  
                            tooltip: {},  
                            legend: {  
                                data:['人数']//标签内容  
                                //注意例子格式为数组，后台传过来的需要对应格式处理数据  
                                //data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]  
                            },  
                            xAxis: {  
                                data: ['周末/节假日','晚6时后','其他时段']     
                            },  
                            
                            yAxis: {},  
                            series: [{  
                                name: '人数',//与标签内容相同  
                                type: 'bar',  
                                //增加数据的单位展示  
                                label:{  
                                 normal: {  
                                        show: true,  
                                        position: 'top',  
                                        formatter: '{c}人'   
                                    }  
                                 },  
                                //注意例子格式为数组，后台传过来的需要对应格式处理数据  
                                //data: [5, 20, 36, 10, 10, 20]  
                                data:[result.extend.userCounts[0],
                                      result.extend.userCounts[1],
                                      result.extend.userCounts[2]-result.extend.userCounts[0]-result.extend.userCounts[1]]  
                            }]  
                        };  
                     // 使用刚指定的配置项和数据显示图表。  
                    myChart1.setOption(option1);  
                     
                    $("#yorderNum").text(result.extend.yorderCounts[2]+"个");
					$("#yuserNum").text(result.extend.yuserCounts[2]+"人");
					$("#ygoodsNum").text(result.extend.ygoodsCount+"个");
					$("#ytotal").text(numToMoney(result.extend.ytotalSum)+"元");
					
					var myChart2 = echarts.init(document.getElementById("yearChart"),"light");
					option2 = {  
                            title: {  
                                text: '分时段消费人数图'//标题内容  
                            },  
                            tooltip: {},  
                            legend: {  
                                data:['人数']//标签内容  
                                //注意例子格式为数组，后台传过来的需要对应格式处理数据  
                                //data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]  
                            },  
                            xAxis: {  
                                data: ['周末/节假日','晚6时后','其他时段']     
                            },  
                            
                            yAxis: {},  
                            series: [{  
                                name: '人数',//与标签内容相同  
                                type: 'bar',  
                                //增加数据的单位展示  
                                label:{  
                                 normal: {  
                                        show: true,  
                                        position: 'top',  
                                        formatter: '{c}人'   
                                    }  
                                 },  
                                //注意例子格式为数组，后台传过来的需要对应格式处理数据  
                                //data: [5, 20, 36, 10, 10, 20]  
                                data:[result.extend.yuserCounts[0],
                                      result.extend.yuserCounts[1],
                                      result.extend.yuserCounts[2]-result.extend.yuserCounts[0]-result.extend.yuserCounts[1]]  
                            }]  
                        };  
                     // 使用刚指定的配置项和数据显示图表。  
                    myChart2.setOption(option2);   
                 
				}				
			});		      
		});
		
		
		
	
	
	
	</script>

</body>
</html>