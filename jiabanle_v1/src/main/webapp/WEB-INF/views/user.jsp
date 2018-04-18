<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ include file = "logincheck.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表</title>
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
	<!-- 修改的模态框 -->
	<div class="modal fade" id="userUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">修改用户</h4>
	      </div>
	      <div class="modal-body">
	      	  <form class="form-horizontal">
				  <div class="form-group">
				    <label for="userName_update_input" class="col-sm-3 control-label ">用户名</label>
				    <div class="col-sm-6">
						    <input type="text" name="name" class="form-control" id="userName_update_input"  readonly="readonly">
					       <span class="help-block"></span>   
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="dept_update_select" class="col-sm-3 control-label">部门</label>
				    <div class="col-sm-6">
				    	<select class="form-control" name="department" id="dept_update_select">
						</select>
				    </div>
				  </div>
				  <div class="form-group">
					<label for="team_update_select" class="col-sm-3 control-label" >分组</label>
				    <div class="col-sm-6">
				    	<select class="form-control" name="team" id="team_update_select">
						</select>
				    </div>
				  </div>				  
			  </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="user_update_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>


	<!-- 新增的模态框 -->
	<div class="modal fade" id="userAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">新增用户</h4>
	      </div>
	      <div class="modal-body">
	      	  <form class="form-horizontal">
				  <div class="form-group">
				    <label for="userName_add_input" class="col-sm-3 control-label">用户名</label>
				    <div class="col-sm-6">
				      <input type="text" name="name" class="form-control" id="userName_add_input" placeholder="userName">
				       <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="dept_add" class="col-sm-3 control-label">部门</label>
				    <div class="col-sm-6">
				    	<select class="form-control" name="department" id="dept_add_select">
						</select>
				    </div>
				  </div>
				  <div class="form-group">
					<label for="team_add" class="col-sm-3 control-label" >分组</label>
				    <div class="col-sm-6">
				    	<select class="form-control" name="team" id="team_add_select">

						</select>
				    </div>
				  </div>				  
			  </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="user_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>



	<!-- 搭建显示页面 -->
   
	<div class="container">
		<!-- 页面标题 -->
		<div class="row">
			<div class="col-md-12">
				<h3>用户管理</h3>
			</div>
		</div>	
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="user_add_modal_btn">
				<span class="glyphicon glyphicon-plus"  aria-hidden="true" ></span>
				新增
				</button>								
				
				<button class="btn btn-danger" id="user_delete_all_btn">
				<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
				删除
				</button>							
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-striped table-hover" id="users_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>编号</th>
							<th>用户名</th>
							<th>部门</th>
							<th>分组</th>
							<th>操作</th>						
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
			<div class="col-md-6" id="page_info_area1">
				
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area1">
				
			</div>
		</div>
	
	</div>
	
	
	<script type="text/javascript">
	
		var totalRecord1, currentPage1;
	
		//1.页面加载完成后，直接发送一个ajax请求，要到分页数据
		$(function(){
			to_userpage(1);
		});
		
		//跳转到相应页码的页面
		function to_userpage(pn){
			$.ajax({
				url:"${APP_PATH}/users",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);
					//1.解析并显示用户数据
					build_users_table(result);
					//2.解析并显示分页信息
					build_page_info1(result);
					//3.解析显示分页条数据
					build_page_nav1(result);
					
				}
				
			});
		}
		
		/* ------------------------------------查询所有用户------------------------------- */
		
		//解析并显示用户数据
		function build_users_table(result){
			//ajax无刷新，要先清空
			$("#users_table tbody").empty();
			
			var users = result.extend.pageInfo.list;
			$.each(users,function(index,item){
				var checkBox = $("<td><input type='checkbox' class='check_item' /></td>");
				var userId = $("<td></td>").append(item.id);
				var userName = $("<td></td>").append(item.name);
				var userDepartment = $("<td></td>").append(item.department);
				var userTeam = $("<td></td>").append(item.team);
				var editBtn = $("<button></button>").addClass("btn btn-xs user_edit_btn").append("编辑");
				//为编辑按钮添加自定义属性，来表示当前用户的id
				editBtn.attr("edit-id",item.id);
				
				var delBtn = $("<button></button>").addClass("btn btn-xs user_delete_btn").append("删除");
				delBtn.attr("del-id",item.id);
				
				var btn = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				//append方法执行完成以后还是返回原来的元素
				$("<tr></tr>").append(checkBox)
					.append(userId)
					.append(userName)
					.append(userDepartment)
					.append(userTeam)
					.append(btn)
					.appendTo("#users_table tbody");
			});
		}
		//解析并显示分页信息
		function build_page_info1(result){
			$("#page_info_area1").empty();
			
			$("#page_info_area1").append("当前是第"
					+result.extend.pageInfo.pageNum +"页，总计"
					+result.extend.pageInfo.pages +"页，总计"
					+result.extend.pageInfo.total +"条记录");
			totalRecord1 = result.extend.pageInfo.total;
			currentPage1 = result.extend.pageInfo.pageNum;
		}
		//解析并显示分页条
		function build_page_nav1(result){
			$("#page_nav_area1").empty();
			
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
					to_userpage(1);
				});
				prePageLi.click(function(){
					to_userpage(result.extend.pageInfo.pageNum-1);
				});
			}
			//没有下一页，则后一页和末页不可用
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_userpage(result.extend.pageInfo.pageNum+1);
				});
				lastPageLi.click(function(){
					to_userpage(result.extend.pageInfo.pages);
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
					to_userpage(item);
				});
				ul.append(numLi);
			});
			//添加下一页和末页
			ul.append(nextPageLi).append(lastPageLi);
			//ul加入nav元素
			var navEle = $("<nav></nav>").append(ul);
			//
			navEle.appendTo("#page_nav_area1");						
		}
		
		function reset_form1(ele){
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-success has-error");
			$(ele).find(".help-block").text("");
			
		}
		
		/* -----------------------------------------新增--------------------------------------- */
		//点击新增按钮弹出模态框
		$("#user_add_modal_btn").click(function(){
			//清除表单数据（表单完整重置：数据、样式）
			reset_form1("#userAddModal form");
						
			//发送ajax请求，从数据库查出列表信息，显示在下拉列表中
			getDepts("#dept_add_select");
			getTeams("#team_add_select");
			
			//弹出模态框
			$("#userAddModal").modal({
				backdrop:"static"
			});
			
		});
		//查出所有部门信息并显示在指定元素中
		function getDepts(ele){
			//清空之前下拉列表的值

			$(ele).empty();
			
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
		function getTeams(ele){
			
			//清空之前下拉列表的值
			$(ele).empty();
			
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
		//校验表单数据
		function validate_add_form1(){
			//1.拿到要校验的数据，使用正则表达式
			var userName = $("#userName_add_input").val();
			var regName = /^[\u2E80-\u9FFF]{2,5}$/;
			
			if(!regName.test(userName)){
				// alert("用户名为2-5位中文"); 
				
				show_validate_msg("#userName_add_input","error","用户名为2-5位中文");
				return false;
			}else{
				show_validate_msg("#userName_add_input","success","");
				return true;						
			}
						
		}
		//显示校验结果的提示信息
		function show_validate_msg(ele,status,msg){
			//清空之前样式
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
				
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
			
		}
		
		$("#userName_add_input").change(function(){
			//1.发送ajax请求校验用户名是否可用
			var userName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				type:"POST",
				data:"userName="+userName,
				success:function(result){
					if(result.code == 100){
						show_validate_msg("#userName_add_input","success","用户名可用");
						$("#user_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#userName_add_input","error",result.extend.va_msg);
						$("#user_save_btn").attr("ajax-va","error");
					}
				}
			});
			
			
		});
						
		
		//点击保存
		$("#user_save_btn").click(function(){
			//1.模态框中填写的表单数据交给服务器进行保存
			//2.先对要提交给服务器的数据进行校验
			if(!validate_add_form1()){
				return false;
			}
			//3.判断用户名校验是否成功
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			//4.发送ajax请求保存用户			
			$.ajax({
				url:"${APP_PATH}/user",
				type:"POST",
				data:$("#userAddModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					if(result.code == 100){
						//保存成功：
						//1.关闭模态框
						$("#userAddModal").modal("hide");					
						//2.来到最后一页，显示刚插入信息
						//发送ajax请求显示最后一页数据
						to_userpage(totalRecord1);
					}else{
						//显示失败信息
						//console.log(result);
						//有哪个字段的错误信息就显示哪个字段
						if(undefined != result.extend.errorFields.name){
							//显示员工名字错误信息
							show_validate_msg("#userName_add_input","error",result.extend.errorFields.name);
						}							
					}					
				}
			}) 
			
		});
		
		
		/* ----------------------------------------编辑------------------------------------------ */
		//无法绑事件，按钮创建之前绑定click，所以绑定不上
		//1.创建按钮的时候绑定事件；2.绑定.live()
		//jquery新版无live，使用on替代
		/* $(".edit_btn").click(function(){			
		}); */
		$(document).on("click",".user_edit_btn", function(){	
			//alert("edit");			
			//0.查出部门信息，并显示部门列表
			getDepts("#dept_update_select");
			
			
			getTeams("#team_update_select");
			
			
			//1.查出用户信息，显示用户信息
			getUser($(this).attr("edit-id"));
			
			
			//2.把用户id传递给模态框更新按钮
			$("#user_update_btn").attr("edit-id",$(this).attr("edit-id"));
			
			//弹出模态框
			$("#userUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		//查询用户信息
		function getUser(id){
			
			$.ajax({
				url:"${APP_PATH}/user/"+id,
				type:"GET",
				async : false,
				success:function(result){
					console.log(result);
					var userData = result.extend.user;
					//alert(userData.department+","+userData.team);
					
					$("#userName_update_input").val(userData.name);					
					$("#userName_update_input").text(userData.name);
					
					//$("#dept_update_select").find("option:contains("+userData.department+")").attr("selected",true);
					$("#dept_update_select").val(userData.department);					
					//alert("部门："+$("#dept_update_select").val());
					
					//$("#team_update_select").find("option:contains("+userData.team+")").attr("selected",true);
					$("#team_update_select").val(userData.team);
					//alert("小组："+$("#team_update_select").val());
									
				}
				
			});
		}
		//点击更新，更新用户信息
		$("#user_update_btn").click(function(){
			//1.验证格式
			//2.发送ajax请求，保存用户数据
			//type:"POST",
			//data:$("#userUpdateModal form").serialize()+"&_method=PUT",
			$.ajax({
				url:"${APP_PATH}/user/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#userUpdateModal form").serialize(),
				success:function(result){
					//1.关闭模态框
					$("#userUpdateModal").modal("hide");
					//2.回到本页面
					to_userpage(currentPage1);
				}				
				
			});
		});
		
		//单个删除
		$(document).on("click",".user_delete_btn",function(){
			//1.弹出是否删除对话框
			//alert($(this).parents("tr").find("td:eq(1)").text());
			var userName = $(this).parents("tr").find("td:eq(2)").text();
			var userId = $(this).attr("del-id");
			if(confirm("确认删除【"+userName+"】吗？")){
				//确认发送ajax请求删除即可
				$.ajax({
					url:"${APP_PATH}/user/"+userId,
					type:"DELETE",
					success:function(result){
						//alert(result.msg)
						//1.回到本页面
						to_userpage(currentPage1);
					}
				});

			}
		});
		
		//全选/全不选功能
		$("#check_all").click(function(){
			//attr获取checked是undefind，对于dom原生的属性，用prop获取值
			//alert($(this).prop("checked"));
			$(".check_item").prop("checked",$(this).prop("checked"));
			
		});
		//check_item
		$(document).on("click",".check_item",function(){
			//判断当前选中元素是否为5个
			var flag = $(".check_item:checked").length == $(".check_item").length;
			$("#check_all").prop("checked",flag);
			
		});
		
		//点击全部删除，批量删除
		$("#user_delete_all_btn").click(function(){
			var userNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				
				userNames += $(this).parents("tr").find("td:eq(2)").text()+"，";
				//组装员工id
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
				
			});
			//去除最后一个多余，-
			userNames = userNames.substring(0, userNames.length-1);
			del_idstr = del_idstr.substring(0, del_idstr.length-1);
			
			if(confirm("确认删除【"+userNames+"】吗？")){
				//发送ajax请求
				$.ajax({
					url:"${APP_PATH}/user/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到当前页面
						to_userpage(currentPage1);						
					}
					
				});
			}
			
		});
		
		
	</script>
</body>
</html>