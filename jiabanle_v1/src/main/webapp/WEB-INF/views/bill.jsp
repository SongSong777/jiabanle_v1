<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>账单查询</title>
</head>
<body>

	<!-- 详情的模态框 -->
	<div class="modal fade" id="billDetailsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h5 class="modal-title">账单详情</h5>
	      </div>
	      <div class="modal-body">
	      	  <form class="form-horizontal" id="billDetailsForm">
				  <div class="form-group">
				    <label for="billUser" class="col-sm-2 control-label">员工:</label>
				    <div class="col-sm-4">
				    	<p class="form-control-static" id="billUser"></p>
				    </div>
				    <label for="billDate" class="col-sm-2 control-label">账单日期:</label>
				    <div class="col-sm-4">
				    	<p class="form-control-static" id="billDate"></p>
				    </div>
				  </div>		  		  				  
			  </form>
			  <table class="table" id="bill_details_table">
					<thead>
						<tr>						
							<th>订单编号</th>
							<th>订单时间</th>
							<th>订单总额</th>		
						</tr>
					</thead>
					<tbody>
						
					
					</tbody>
					
				</table>
				<div class="row">
					<!-- 分页文字信息 -->
					<div class="col-md-6" id="bills_details_page_info_area">
				
					</div>
					<!-- 分页条信息 -->
					<div class="col-md-6" id="bills_details_page_nav_area">
				
					</div>
				</div>
				 
				  		
	      </div>
	      
	    </div>
	  </div>
	</div>
	
	<!-- 搭建显示页面 -->
   
	<div class="container">
		<!-- 页面标题 -->
		<div class="row">
			<div class="col-md-12">
				<h3>账单查询</h3>
			</div>
		</div>	
		<!-- 按钮 -->
		<div class="row">			
			<form class="form-inline col-md-4 col-md-offset-8" id="get_bills_form" >
			  <div class="form-group">
			    <label for="bill_date_select" >账单日期</label>	
				<select class="form-control" name="billDate" id="bill_date_select">
				</select>
			  </div>			  
			  <button type="button" class="btn btn-primary" id="bill_get_btn">查询</button>
			</form>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-striped table-hover" id="bills_table">
					<thead>
						<tr>						
							<th>部门</th>
							<th>组别</th>
							<th>员工姓名</th>
							<th>账单总额</th>				
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
			<div class="col-md-6" id="bills_page_info_area">
				
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="bills_page_nav_area">
				
			</div>
		</div>
	
	</div>
	
	<script type="text/javascript">
		$(function() {  
	   	 var allinfo = last_year_month();
	   	 
	        //生成前12个月日期下拉框  
	        $.each(allinfo,function(i){
	        	if(i==0){
	        		var m = $("<option></option>").append(allinfo[i]).attr("value",allinfo[i]).attr("selected",true);
		       	 }else{
	        		var m = $("<option></option>").append(allinfo[i]).attr("value",allinfo[i]);
		       	 }
	       	 m.appendTo("#bill_date_select");
	       	 //$("#bill_date_select").append("<option></option>").append(allinfo[i]).attr("value",allinfo[i]);
	        });
        
    	}); 
		
		$(function(){
			to_billpage(1);
		});
		
		//跳转到相应页码的页面
		function to_billpage(pn){
			var data = $.param({"pn":pn})+"&"+$("#get_bills_form").serialize();
			//console.log(data);
			$.ajax({
				url:"${APP_PATH}/bills",
				data:data,
				type:"GET",
				dateType:"json",
				success:function(result){
					//console.log(result);
					//1.解析并显示数据
					build_bill_table(result);
					//2.解析并显示分页信息
					build_bill_page_info(result);
					//3.解析显示分页条数据
					build_bill_page_nav(result);					
				}				
			});

		}
		
		//解析并显示数据
		function build_bill_table(result){
			//ajax无刷新，要先清空
			$("#bills_table tbody").empty();
			
			var billsData = result.extend.pageInfo.list;
			$.each(billsData,function(index,item){
				var userName = $("<td></td>").append(item.name);
				var userDepartment = $("<td></td>").append(item.department);
				var userTeam = $("<td></td>").append(item.team);
				var billSum = $("<td></td>").append(numToMoney(item.sum));
				var detailsBtn = $("<button></button>").addClass("btn btn-xs bill_details_btn").append("详情");
				//为编辑按钮添加自定义属性，来表示当前订单的id
				detailsBtn.attr("details-uid",item.uid).attr("details-date",item.date).attr("details-username",item.name);				
				var btn = $("<td></td>").append(detailsBtn);
				//append方法执行完成以后还是返回原来的元素
				$("<tr></tr>")					
					.append(userDepartment)
					.append(userTeam)
					.append(userName)
					.append(billSum)
					.append(btn)
					.appendTo("#bills_table tbody");
			});
		}
		 
		//解析并显示分页信息
		function build_bill_page_info(result){
			$("#bills_page_info_area").empty();
			
			$("#bills_page_info_area").append("当前是第"
					+result.extend.pageInfo.pageNum +"页，总计"
					+result.extend.pageInfo.pages +"页，总计"
					+result.extend.pageInfo.total +"条记录");
		}
		//解析并显示分页条
		function build_bill_page_nav(result){
			$("#bills_page_nav_area").empty();
			
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
					to_billpage(1);
				});
				prePageLi.click(function(){
					to_billpage(result.extend.pageInfo.pageNum-1);
				});
			}
			//没有下一页，则后一页和末页不可用
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_billpage(result.extend.pageInfo.pageNum+1);
				});
				lastPageLi.click(function(){
					to_billpage(result.extend.pageInfo.pages);
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
					to_billpage(item);
				});
				ul.append(numLi);
			});
			//添加下一页和末页
			ul.append(nextPageLi).append(lastPageLi);
			//ul加入nav元素
			var navEle = $("<nav></nav>").append(ul);
			//
			navEle.appendTo("#bills_page_nav_area");						
		}
		
		//条件查询
		$("#bill_get_btn").click(function(){
			to_billpage(1);
		});
		
		//账单详情
		$(document).on("click",".bill_details_btn", function(){	
								
			//1.查出订单信息
			//console.log($(this).attr("details-uid"));
			getOrderByUserId(1,$(this).attr("details-uid"));
					
			//弹出模态框
			$("#billDetailsModal").modal({
					backdrop:"static"
			});
		});
		
		//获取详情信息
		function getOrderByUserId(pn,uid){			
			var data = $.param({"pn":pn})+"&"+$("#get_bills_form").serialize();
			
			$.ajax({
				url:"${APP_PATH}/billdetails/"+uid,
				type:"GET",
				data:data,
				dateType:"json",
				success:function(result){
					console.log(result);
					//1.解析并显示数据
					build_bill_details_table(result);
					//2.解析并显示分页信息
					build_bill_details_page_info(result);
					//3.解析显示分页条数据
					build_bill_details_page_nav(result);
					
																
				}				
			});
		}
			//解析并显示详情数据
			function build_bill_details_table(result){
				//ajax无刷新，要先清空
				var billsData = result.extend.pageInfo.list;
				var username = result.extend.username;
				console.log(billsData);
				//billDetailsForm	
				$("#billDetailsForm")[0].reset();
				$("#bill_details_table tbody").empty();
				
				console.log($(".bill_details_btn").attr("details-uid"));
				
				
				$.each(billsData,function(index,item){	
					$("#billUser").text(item.user.name);
					$("#billDate").text($(".bill_details_btn").attr("details-date"));
					var orderId = $("<td></td>").append(item.id);
					var orderDate = $("<td></td>").append(unixToDate(item.date));
					var orderSum = $("<td></td>").append(numToMoney(item.sum));					
					$("<tr></tr>")
						.append(orderId)
						.append(orderDate)
						.append(orderSum)
						.appendTo("#bill_details_table tbody");
				});
				
			}
			
			//解析并显示分页信息
			function build_bill_details_page_info(result){
				$("#bills_details_page_info_area").empty();
				
				$("#bills_details_page_info_area").append("当前是第"
						+result.extend.pageInfo.pageNum +"页，总计"
						+result.extend.pageInfo.pages +"页，总计"
						+result.extend.pageInfo.total +"条记录");
			}
			
			//解析并显示分页条
			function build_bill_details_page_nav(result){
				$("#bills_details_page_nav_area").empty();
				
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
						getOrderByUserId(1,result.extend.pageInfo.list[0].userId);
					});
					prePageLi.click(function(){
						getOrderByUserId(result.extend.pageInfo.pageNum-1,result.extend.pageInfo.list[0].userId);
					});
				}
				//没有下一页，则后一页和末页不可用
				if(result.extend.pageInfo.hasNextPage == false){
					nextPageLi.addClass("disabled");
					lastPageLi.addClass("disabled");
				}else{
					nextPageLi.click(function(){
						getOrderByUserId(result.extend.pageInfo.pageNum+1,result.extend.pageInfo.list[0].userId);
					});
					lastPageLi.click(function(){
						getOrderByUserId(result.extend.pageInfo.pages,result.extend.pageInfo.list[0].userId);
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
						getOrderByUserId(item,result.extend.pageInfo.list[0].userId);
					});
					ul.append(numLi);
				});
				//添加下一页和末页
				ul.append(nextPageLi).append(lastPageLi);
				//ul加入nav元素
				var navEle = $("<nav></nav>").append(ul);
				//
				navEle.appendTo("#bills_details_page_nav_area");						
			}
			

	
	</script>
</body>
</html>