<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品列表</title>
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
	<!-- 补货的模态框 -->
	<div class="modal fade" id="stockModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">商品补货</h4>
	      </div>
	      <div class="modal-body">
	      	  <form class="form-horizontal">
	      	  	<div class="form-group">
				    <label for="goods_stock_select" class="col-sm-3 control-label">商品名称</label>
				    <div class="col-sm-6">
				    	<select class="form-control" name="goods_id" id="goods_stock_select">
						</select>
				    </div>
				  </div>
	      	  
				  <div class="form-group">
				    <label for="stock_num_input" class="col-sm-3 control-label ">补货数量</label>
				    <div class="col-sm-6">
				    	<input type="text" name="stock_num" class="form-control" id="stock_num_input" >
				       <span class="help-block"></span>				      
				    </div>				    
				  </div>
				  
				  <div class="form-group">
				    <label for="stock_price_input" class="col-sm-3 control-label ">补货价格</label>
				    <div class="col-sm-6">
				    	<input type="text" name="stock_price" class="form-control" id="stock_price_input" >
				       <span class="help-block"></span>				      
				    </div>
				  </div>
				  			  
			  </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="stock_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- 新增的模态框 -->
	<div class="modal fade" id="goodsAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">新增商品</h4>
	      </div>
	      <div class="modal-body">
	      	  <form class="form-horizontal" enctype="multipart/form-data">
				  <div class="form-group">
				    <label for="name_add_input" class="col-sm-3 control-label">商品名称</label>
				    <div class="col-sm-6">
				      <input type="text" name="name" class="form-control" id="name_add_input" >
				       <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="description_add_input" class="col-sm-3 control-label">商品描述</label>
				    <div class="col-sm-6">
				    	<input type="text" name="description" class="form-control" id="description_add_input" >
				       <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="price_add_input" class="col-sm-3 control-label">商品定价</label>
				    <div class="col-sm-6">
				    	<input type="text" name="price" class="form-control" id="price_add_input" >
				       <span class="help-block"></span>
				    </div>
				  </div>
				  				  
				  <div class="form-group">
				    <label for="image_add_input" class="col-sm-3 control-label">商品图片</label>
				    <div class="col-sm-6">
				    	<input type="file" name="image"  id="image_add_input" >
				       <span class="help-block"></span>
				    </div>
				  </div>				  				  
			  </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="goods_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- 编辑的模态框 -->
	<div class="modal fade" id="goodsUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">编辑商品</h4>
	      </div>
	      <div class="modal-body">
	      	  <form class="form-horizontal" enctype="multipart/form-data">
				  <div class="form-group">
				    <label for="goodsName_update_input" class="col-sm-3 control-label">商品名称</label>
				    <div class="col-sm-6">
				      <input type="text" name="name" class="form-control" id="goods_update_input" >
				       <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="describe_update_input" class="col-sm-3 control-label">商品描述</label>
				    <div class="col-sm-6">
				    	<input type="text" name="describe" class="form-control" id="describe_update_input" >
				       <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="price_update_input" class="col-sm-3 control-label">商品定价</label>
				    <div class="col-sm-6">
				    	<input type="text" name="price" class="form-control" id="price_update_input" >
				       <span class="help-block"></span>
				    </div>
				  </div>
				  				  
				  <div class="form-group">
				    <label for="image_update_input" class="col-sm-3 control-label">商品图片</label>
				    <div class="col-sm-6">
				    	<input type="file" name="image" class="form-control" id="image_update_input" >
				       <span class="help-block"></span>
				    </div>
				  </div>				  				  
			  </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="goods_edit_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- 搭建显示页面 -->
   
	<div class="container">
		<!-- 页面标题 -->
		<div class="row">
			<div class="col-md-12">
				<h3>商品管理</h3>
			</div>
		</div>	
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="goods_add_modal_btn">
				<span class="glyphicon glyphicon-plus"  aria-hidden="true" ></span>
				新增
				</button>								
				
				<button class="btn btn-danger" id="goods_stock_modal_btn">
				<span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>
				补货
				</button>							
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-striped table-hover" id="goods_table">
					<thead>
						<tr>
							<th>编号</th>
							<th>商品名</th>
							<th>描述</th>
							<th>价格</th>
							<th>图片</th>
							<th>数量</th>
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
			<div class="col-md-6" id="page_info_area">
				
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area">
				
			</div>
		</div>
	
	</div>
	
	
	<script type="text/javascript">
	
		var totalRecord, currentPage;
	
		//1.页面加载完成后，直接发送一个ajax请求，要到分页数据
		$(function(){
			to_page(1);
		});
		
		//跳转到相应页码的页面
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/goods",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);
					//1.解析并显示商品数据
					build_goods_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析显示分页条数据
					build_page_nav(result);
					
				}
				
			});
		}
		
		//解析并显示商品数据
		function build_goods_table(result){
			//ajax无刷新，要先清空
			$("#goods_table tbody").empty();
			
			var goods = result.extend.pageInfo.list;
			$.each(goods,function(index,item){
				var goodsId = $("<td></td>").append(item.id);
				var goodsName = $("<td></td>").append(item.name);
				var goodsDes = $("<td></td>").append(item.des);
				var goodsPrice = $("<td></td>").append(item.price);
				var goodsImage = $("<td></td>").append(item.image);
				var goodsNumber = $("<td></td>").append(item.number);
				var editBtn = $("<button></button>").addClass("btn btn-xs edit_btn").append("编辑");
				//为编辑按钮添加自定义属性，来表示当前商品的id
				editBtn.attr("edit-id",item.id);
				
				var delBtn = $("<button></button>").addClass("btn btn-xs delete_btn").append("删除");
				delBtn.attr("del-id",item.id);
				
				var btn = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				//append方法执行完成以后还是返回原来的元素
				$("<tr></tr>")
					.append(goodsId)
					.append(goodsName)
					.append(goodsDes)
					.append(goodsPrice)
					.append(goodsImage)
					.append(goodsNumber)
					.append(btn)
					.appendTo("#goods_table tbody");
			});
		}
		//解析并显示分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			
			$("#page_info_area").append("当前是第"
					+result.extend.pageInfo.pageNum +"页，总计"
					+result.extend.pageInfo.pages +"页，总计"
					+result.extend.pageInfo.total +"条记录");
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}
		//解析并显示分页条
		function build_page_nav(result){
			$("#page_nav_area").empty();
			
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
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				});
			}
			//没有下一页，则后一页和末页不可用
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
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
					to_page(item);
				});
				ul.append(numLi);
			});
			//添加下一页和末页
			ul.append(nextPageLi).append(lastPageLi);
			//ul加入nav元素
			var navEle = $("<nav></nav>").append(ul);
			//
			navEle.appendTo("#page_nav_area");						
		}
		
		function reset_form(ele){
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-success has-error");
			$(ele).find(".help-block").text("");
			
		}
		//点击新增按钮弹出模态框
		$("#goods_add_modal_btn").click(function(){
			//清除表单数据（表单完整重置：数据、样式）
			reset_form("#goodsAddModal form");
			
			//弹出模态框
			$("#goodsAddModal").modal({
				backdrop:"static"
			});
			
		});
		
		//校验表单数据
		function validate_add_form(){
			//1.拿到要校验的数据，使用正则表达式
			//验证商品名
			var goodsName = $("#name_add_input").val();
			var regName = /^[\u2E80-\u9FFF]{2,20}$/;
			
			if(!regName.test(goodsName)){				
				show_validate_msg("#name_add_input","error","商品名称为2-20位中文");
				return false;
			}else{
				show_validate_msg("#name_add_input","success","");
									
			}
			//验证商品价格
			var goodsPrice = $("#price_add_input").val();
			var regPrice = /^([0-9]*)+(.[0-9]{1,2})?$/;
			
			if(!regPrice.test(goodsPrice)){				
				show_validate_msg("#price_add_input","error","商品价格最多两位小数");
				return false;
			}else{
				show_validate_msg("#price_add_input","success","");						
			}
			
			
			return true;
						
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
		
		$("#name_add_input").change(function(){
			//1.发送ajax请求校验商品名称是否可用
			var goodsName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkgoods",
				type:"POST",
				data:"goodsName="+goodsName,
				success:function(result){
					if(result.code == 100){
						show_validate_msg("#name_add_input","success","用户名可用");
						$("#goods_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#name_add_input","error",result.extend.va_msg);
						$("#goods_save_btn").attr("ajax-va","error");
					}
				}
			});
		});
		//商品价格验证
		$("#price_add_input").change(function(){			
			validate_add_form();
		});
		
		//点击保存
		$("#goods_save_btn").click(function(){
			//1.模态框中填写的表单数据交给服务器进行保存
			//2.先对要提交给服务器的数据进行校验
			if(!validate_add_form()){
				return false;
			}
			//3.判断用户名校验是否成功
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			//4.发送ajax请求保存用户			
			$.ajax({
				url:"${APP_PATH}/savegoods",
				type:"POST",
				data:$("#goodsAddModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					if(result.code == 100){
						//保存成功：
						//1.关闭模态框
						$("#goodsAddModal").modal("hide");					
						//2.来到最后一页，显示刚插入信息
						//发送ajax请求显示最后一页数据
						to_page(totalRecord);
					}else{
						//显示失败信息
						//console.log(result);
						//有哪个字段的错误信息就显示哪个字段
						if(undefined != result.extend.errorFields.name){
							//显示员工名字错误信息
							show_validate_msg("#goodsName_add_input","error",result.extend.errorFields.name);
						}
						if(undefined != result.extend.errorFields.price){
							//显示员工名字错误信息
							show_validate_msg("#price_add_input","error",result.extend.errorFields.price);
						}	
					}
					
					
					
				}
			}) 
			
		});
		
		
		
		
		
	</script>
</body>
</html>