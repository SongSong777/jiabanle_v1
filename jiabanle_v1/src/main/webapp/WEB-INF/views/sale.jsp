<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消费查询页面</title>
</head>
<body>
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
			<form class="form-inline col-md-4 col-md-offset-8" id="get_bills_form" action="${APP_PATH}/sales" method="post" >
			  <div class="form-group">
			    <label for="bill_date_select" >账单日期</label>	
				<select class="form-control" name="billDate" id="bill_date_select"></select>
			  </div>
			  <button type="submit" class="btn btn-primary" id="bill_get_btn">查询</button>
			</form>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-striped table-hover" id="sales_table">
					<thead>
						<tr>						
							<th>编号</th>
							<th>部门</th>
							<th>组别</th>
							<th>员工姓名</th>
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
		
		/* -------------------------------------------查询表单----------------------------------- */
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
	        	 m.appendTo("#bill_date_select");
	        	 //$("#bill_date_select").append("<option></option>").append(allinfo[i]).attr("value",allinfo[i]);
             });
	         
	     }); 
	     
	     /* -------------------------------------------查询表单----------------------------------- */
	     
	
	
	
	</script>

</body>
</html>