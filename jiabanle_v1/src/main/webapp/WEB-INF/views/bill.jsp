<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>账单查询</title>
</head>
<body>
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
				<select class="form-control" name="saleDate" id="bill_date_select">
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
							<th>编号</th>
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
</body>
</html>