<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消费查询</title>
</head>
<body>
	<!-- 详情的模态框 -->
	<div class="modal fade" id="orderDetailsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">订单详情</h4>
	      </div>
	      <div class="modal-body">
	      	  <form class="form-horizontal" enctype="multipart/form-data" id="orderDetailsForm">
				  <div class="form-group">
				    <label for="detailsOrderId" class="col-sm-2 control-label">订单编号:</label>
				    <div class="col-sm-4">
				    	<p class="form-control-static" id="detailsOrderId"></p>
				    </div>
				  </div>				  		  				  
			  </form>
			  <table class="table" id="details_table">
					<thead>
						<tr>						
							<th>商品名称</th>
							<th>原价</th>
							<th>结算价</th>
							<th>数量</th>
							<th>小计</th>				
						</tr>
					</thead>
					<tbody>
						
					
					</tbody>
					
				</table>
				 
				  		
	      </div>
	      
	    </div>
	  </div>
	</div>

	<!-- 搭建显示页面 -->
   
	<div class="container">
		<!-- 页面标题 -->
		<div class="row">
			<div class="col-md-12">
				<h3>消费查询</h3>
			</div>
		</div>	
		<!-- 按钮 -->
		<div class="row">			
			<form class="form-inline col-md-9 col-md-offset-3" id="get_sales_form" >
			  <div class="form-group">
			    <label for="bill_date_select" >订单日期</label>	
				<select class="form-control" name="saleDate" id="sale_date_select">
					<option value="0000-00">所有日期</option>
				</select>
			  </div>
			  <div class="form-group">
			    <label for="sale_time_select" >订单时间段</label>	
				<select class="form-control" name="saleTime" id="sale_time_select">
					<option value="0">所有时间</option>
					<option value="1">法定节假</option>
					<option value="2">晚6时后</option>										
				</select>
			  </div>
			  <div class="form-group">
			    <label for="sale_dept_select" >部门</label>	
				<select class="form-control" name="saleDept" id="sale_dept_select">
					<option value="0">所有部门</option>
				</select>
			  </div>			  
			  <div class="form-group">
			    <label for="sale_team_select" >小组</label>	
				<select class="form-control" name="saleTeam" id="sale_team_select">
					<option value="0">所有小组</option>
				</select>
			  </div>
			  <button type="button" class="btn btn-primary" id="sale_get_btn">查询</button>
			</form>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-striped table-hover" id="sales_table">
					<thead>
						<tr>						
							<th>编号</th>
							<th>消费日期</th>
							<th>消费总额</th>
							<th>员工姓名</th>
							<th>部门</th>
							<th>组别</th>					
							<th>详情</th>					
						</tr>
					</thead>
					<tbody>
						
					
					</tbody>
					
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="sales_page_info_area">
				
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="sales_page_nav_area">
				
			</div>
		</div>
	
	</div>
	
	<script type="text/javascript">
		
		/* -------------------------------------------日期----------------------------------- */
		 var last_year_month = function() {  
	         var d = new Date();
	         //alert(d);
	         var result = [];  
	         for(var i = 0; i < 12; i++) {  
	        	 var m = d.getMonth()+1; 
	        	 //alert(m);
	             m = m < 10 ? "0" + m : m;  	               	             
	             //在这里可以自定义输出的日期格式  
	             result.push(d.getFullYear() + "-" + m);  
	             //result.push(d.getFullYear() + "年" + m + '月');  
	             d.setMonth(d.getMonth()-1);
	            // alert(d.getMonth());
	         }  
	         return result;  
	     }  
	     $(function() {  
	    	 var allinfo = last_year_month();
	    	 
	         //生成前12个月日期下拉框  
	         $.each(allinfo,function(i){
	        	 var m = $("<option></option>").append(allinfo[i]).attr("value",allinfo[i]);
	        	 m.appendTo("#sale_date_select");
	        	 //$("#bill_date_select").append("<option></option>").append(allinfo[i]).attr("value",allinfo[i]);
             });
	         
	         
	         getOrderDepts("#sale_dept_select");
	         getOrderTeams("#sale_team_select")
	         
	     }); 
	     
			//查出所有部门信息并显示在指定元素中
			function getOrderDepts(ele){
				$.ajax({
					url:"${APP_PATH}/depts",
					type:"GET",
					async : false,
					success:function(result){
						//{"code":100,"msg":"处理成功！","extend":{"depts":[{"dId":1,"dName":"研发部"},{"dId":2,"dName":"综合"},{"dId":3,"dName":"科教"},{"dId":4,"dName":"售后"},{"dId":5,"dName":"财务"},{"dId":6,"dName":"仓管"},{"dId":7,"dName":"车间"},{"dId":8,"dName":"科普"},{"dId":9,"dName":"企发"},{"dId":10,"dName":"实验室"},{"dId":11,"dName":"市场"},{"dId":12,"dName":"营销"}]}}
						//console.log(result);
						//显示部门信息在下拉列表中
						//$("#dept_select").append("")
						$.each(result.extend.depts,function(){
							var optionEle = $("<option></option>").append(this.dName).attr("value",this.dName);
							optionEle.appendTo(ele);
						});
						
					}
					
				});
			}
			//查询所有组信息并显示在指定元素
			function getOrderTeams(ele){				
				$.ajax({
					url:"${APP_PATH}/teams",
					type:"GET",
					async : false,
					success:function(result){
						//console.log(result);
						//显示小组信息在下拉列表中
						//$("#team_select").append("")
						$.each(result.extend.teams,function(){
							var optionEle = $("<option></option>").append(this.tName).attr("value",this.tName);						
							optionEle.appendTo(ele);
						});
						
					}
					
				});
			}
	     
	     
	     /* -------------------------------------------全部查询----------------------------------- */
	     //1.页面加载完成后，直接发送一个ajax请求，要到分页数据
		$(function(){
			to_salepage(1);
		});
		
		//跳转到相应页码的页面
		function to_salepage(pn){
			var data = $.param({"pn":pn})+"&"+$("#get_sales_form").serialize();
			console.log(data);
			$.ajax({
				url:"${APP_PATH}/sales",
				data:data,
				type:"GET",
				dateType:"json",
				success:function(result){
					console.log(result);
					//1.解析并显示用户数据
					build_sale_table(result);
					//2.解析并显示分页信息
					build_sale_page_info(result);
					//3.解析显示分页条数据
					build_sale_page_nav(result);					
				}				
			});
		}
		
		//时间戳转格式
		function unixToDate(unixTime){
			var unixTimeInt = parseInt(unixTime);
			var time = new Date(unixTimeInt);
			var ymdhis ="";
			var years = time.getFullYear();
            var months = time.getMonth()+1;
            var days = time.getDate();
            if(months < 10){
            	months = "0"+months;               
            }
            if(days < 10){
            	days = "0"+days;
            }
            
			ymdhis += years + "-";
            ymdhis += months + "-";
            ymdhis += days;
            
            var hours = time.getHours();
            var minutes = time.getMinutes();
            var seconds = time.getSeconds();
            if(hours < 10){
                hours = "0"+hours;               
            }
            if(minutes < 10){
                minutes = "0"+minutes;
            }
            if(seconds < 10){
                seconds = "0"+seconds;
            }
            ymdhis += " " + hours + ":";
            ymdhis += minutes + ":";
            ymdhis += seconds;            
            return ymdhis;			
		}
		
		//金额转格式
		function numToMoney(value){
			var value = Math.round(parseFloat(value)*100)/100;
			var xsd = value.toString().split(".");
			if(xsd.length == 1){
			  value = value.toString()+".00";
			  return value;
			}
			if(xsd.length > 1){
			  if(xsd[1].length<2){
			  value = value.toString()+"0";
			}
			  return value;
			}
			
		}
		
		
		
	    //解析并显示用户数据
		function build_sale_table(result){
			//ajax无刷新，要先清空
			$("#sales_table tbody").empty();
			
			var sales = result.extend.pageInfo.list;
			$.each(sales,function(index,item){
				var saleId = $("<td></td>").append(item.id);				
				var saleDate = $("<td></td>").append(unixToDate(item.date));
				var saleSum = $("<td></td>").append(numToMoney(item.sum));
				var userName = $("<td></td>").append(item.user.name);
				var userDepartment = $("<td></td>").append(item.user.department);
				var userTeam = $("<td></td>").append(item.user.team);
				var detailsBtn = $("<button></button>").addClass("btn btn-xs details_btn").append("详情");
				//为编辑按钮添加自定义属性，来表示当前订单的id
				detailsBtn.attr("details-id",item.id);				
				var btn = $("<td></td>").append(detailsBtn);
				//append方法执行完成以后还是返回原来的元素
				$("<tr></tr>").append(saleId)
					.append(saleDate)
					.append(saleSum)					
					.append(userName)
					.append(userDepartment)
					.append(userTeam)
					.append(btn)
					.appendTo("#sales_table tbody");
			});
		}
		 
		//解析并显示分页信息
		function build_sale_page_info(result){
			$("#sales_page_info_area").empty();
			
			$("#sales_page_info_area").append("当前是第"
					+result.extend.pageInfo.pageNum +"页，总计"
					+result.extend.pageInfo.pages +"页，总计"
					+result.extend.pageInfo.total +"条记录");
		}
		//解析并显示分页条
		function build_sale_page_nav(result){
			$("#sales_page_nav_area").empty();
			
			var ul = $("<ul></ul>").addClass("pagination");
			
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
			
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href", "#"));			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href", "#"));
			//没有上一页，则前一页和首页不可用
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				firstPageLi.click(function(){
					to_salepage(1);
				});
				prePageLi.click(function(){
					to_salepage(result.extend.pageInfo.pageNum-1);
				});
			}
			//没有下一页，则后一页和末页不可用
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_salepage(result.extend.pageInfo.pageNum+1);
				});
				lastPageLi.click(function(){
					to_salepage(result.extend.pageInfo.pages);
				});
			}						
			//添加首页和前一页
			ul.append(firstPageLi).append(prePageLi);			
			//遍历并添加页码
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_salepage(item);
				});
				ul.append(numLi);
			});
			//添加下一页和末页
			ul.append(nextPageLi).append(lastPageLi);
			//ul加入nav元素
			var navEle = $("<nav></nav>").append(ul);
			//
			navEle.appendTo("#sales_page_nav_area");						
		}
		
		//条件查询
		$("#sale_get_btn").click(function(){
			to_salepage(1);
		});
		
		$(document).on("click",".details_btn", function(){	
					
			
			//1.查出订单信息
			console.log($(this).attr("details-id"));
			getDetailsByOrderId($(this).attr("details-id"));
			
			
			
			//弹出模态框
			$("#orderDetailsModal").modal({
				backdrop:"static"
			});
		});
		
		function getDetailsByOrderId(id){
			$.ajax({
				url:"${APP_PATH}/details/"+id,
				type:"GET",
				success:function(result){
					console.log(result);
					var itemsData = result.extend.orderItems;
					
					$("#details_table tbody").empty();
					
					$.each(itemsData,function(index,item){
						var orderId = $("#detailsOrderId").text(item.orderId);
						var goodsName = $("<td></td>").append(item.goods.name);
						var goodsPrice = $("<td></td>").append(item.goods.price);
						var discountPrice = $("<td></td>").append(item.discountPrice);
						var num = $("<td></td>").append(item.num);
						var sum = $("<td></td>").append(item.discountPrice*item.num);
						
						$("<tr></tr>")
							.append(goodsName)
							.append(goodsPrice)
							.append(discountPrice)
							.append(num)
							.append(sum)
							.appendTo("#details_table tbody");
					});
					
								
				}				
			});
			
			
		}

	
	</script>

</body>
</html>