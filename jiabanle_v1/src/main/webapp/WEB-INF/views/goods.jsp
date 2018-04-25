<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品管理</title>
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
	      	  <form class="form-horizontal" id="stock_form">
	      	  	
	      	  
	      	  	<div class="form-group">
				    <label for="goods_stock_select" class="col-sm-3 control-label">商品名称</label>
				    <div class="col-sm-6">
				    	<select class="form-control" name="goodsId" id="goods_stock_select">
						</select>
				    </div>
				  </div>
	      	  
				  <div class="form-group">
				    <label for="stock_num_input" class="col-sm-3 control-label ">补货数量</label>
				    <div class="col-sm-6">
				    	<input type="text" name="stockNum" class="form-control" id="stock_num_input" >
				       <span class="help-block"></span>				      
				    </div>				    
				  </div>
				  
				  <div class="form-group">
				    <label for="stock_price_input" class="col-sm-3 control-label ">补货价格</label>
				    <div class="col-sm-6">
				    	<input type="text" name="stockPrice" class="form-control" id="stock_price_input" >
				       <span class="help-block"></span>				      
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="stock_sum_input" class="col-sm-3 control-label ">总额</label>
				    <div class="col-sm-6">
				    	<input type="text" name="sum" class="form-control" id="stock_sum_input" readonly="readonly">
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
	      	  <form class="form-horizontal" id="addGoodsForm" enctype="multipart/form-data">
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
				    	<input type="file" name="file"  id="image_add_input" >
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
	      	  <form class="form-horizontal" enctype="multipart/form-data" id="updateGoodsForm">
				  <div class="form-group">
				    <label for="name_update_input" class="col-sm-3 control-label">商品名称</label>
				    <div class="col-sm-6">
				    	<input type="text" name="name" class="form-control" id="name_update_input" readonly="readonly">
				       <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="description_update_input" class="col-sm-3 control-label">商品描述</label>
				    <div class="col-sm-6">
				    	<input type="text" name="description" class="form-control" id="description_update_input" >
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
				    	<img id="image_update_show" alt="" src=""/>
				    	<input type="file" name="file" id="image_update_input" >
				       <span class="help-block"></span>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    
				    	<input type="hidden" name="number" id="number_update_input" >
				       
				  </div>
				  
				  				  				  
			  </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="goods_update_btn">更新</button>
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
		var perPageNum, optionIndex;
	
		//1.页面加载完成后，直接发送一个ajax请求，要到分页数据
		$(function(){
			to_page(1);
		});
		
		//跳转到相应页码的页面
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/allgoods",
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
		/* ----------------------------------查询显示所有-------------------------------- */
		//解析并显示商品数据
		function build_goods_table(result){
			//ajax无刷新，要先清空
			$("#goods_table tbody").empty();
			
			var goods = result.extend.pageInfo.list;
			$.each(goods,function(index,item){
				var goodsId = $("<td></td>").append(item.id);
				var goodsName = $("<td></td>").append(item.name);
				var goodsDes = $("<td></td>").append(item.description);
				var goodsPrice = $("<td></td>").append(numToMoney(item.price));
				var image = $("<img></img>").attr("src",item.image).attr("style","width:50px;height:50px;");
				var goodsImage = $("<td></td>").append(image).addClass("images");				
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
			perPageNum = result.extend.pageInfo.pageSize;
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
		
		/* ----------------------------------新增-------------------------------- */
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
					console.log(result.code);
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
			//4.发送ajax请求保存商品		
			var formData = new FormData($("#addGoodsForm")[0]);
			$.ajax({
				url:"${APP_PATH}/goods",
				type:"POST",
				data:formData,
				processData: false,
			    contentType: false,
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
							show_validate_msg("#name_add_input","error",result.extend.errorFields.name);
						}
						if(undefined != result.extend.errorFields.price){
							//显示员工名字错误信息
							show_validate_msg("#price_add_input","error",result.extend.errorFields.price);
						}	
					}										
					
				}
			}) 
			
		});
		/* ----------------------------------修改-------------------------------- */
		$("#price_update_input").change(function(){			
			validate_add_form();
		});
		//编辑按钮事件
		$(document).on("click",".edit_btn", function(){	
			//alert("edit");			
			
			//1.查出商品信息
			getGoodsById($(this).attr("edit-id"));	
			
			//2.把商品id传递给模态框更新按钮
			$("#goods_update_btn").attr("edit-id",$(this).attr("edit-id"));
			
			//弹出模态框
			$("#goodsUpdateModal").modal({
				backdrop:"static"
			});
		});
		//查询商品信息
		function getGoodsById(id){
			$.ajax({
				url:"${APP_PATH}/goods/"+id,
				type:"GET",
				success:function(result){
					console.log(result);
					var goodsData = result.extend.goods;
					$("#name_update_input").val(goodsData.name);					
					$("#description_update_input").val(goodsData.description);
					$("#price_update_input").val(goodsData.price);
					$("#image_update_show").attr("src",goodsData.image).attr("style","width:100px;height:100px;")
					$("#image_update_input").val(goodsData.file);
					$("#number_update_input").val(goodsData.number);
					
				}
				
			});
		}
		
		//商品价格验证
		$("#price_update_input").change(function(){			
			var goodsPrice = $("#price_update_input").val();
			var regPrice = /^([0-9]*)+(.[0-9]{1,2})?$/;
			
			if(!regPrice.test(goodsPrice)){				
				show_validate_msg("#price_update_input","error","商品价格最多两位小数");
				return false;
			}else{
				show_validate_msg("#price_update_input","success","");						
			}
		});
		
		//点击更新，更新商品信息
		$("#goods_update_btn").click(function(){
			
			var formDataUpdate = new FormData($("#updateGoodsForm")[0]);
			//1.验证格式
			
			
			//2.发送ajax请求，保存用户数据
			//type:"POST",
			
			$.ajax({
				url:"${APP_PATH}/goods/"+$(this).attr("edit-id"),
				type:"POST",
				data:formDataUpdate,
				contentType: false,  
		        processData: false,
				success:function(result){
					if(result.code == 100){
						//保存成功：
						//1.关闭模态框
						$("#goodsUpdateModal").modal("hide");					
						//2.来到最后一页，显示刚插入信息
						//发送ajax请求显示最后一页数据
						to_page(currentPage);
					}else{
						
						if(undefined != result.extend.errorFields.price){
							//显示错误信息
							show_validate_msg("#price_update_input","error",result.extend.errorFields.price);
						}	
					}	

				}				
				
			});
		});
		
		//更新图像立即显示
		$("#image_update_input").change(function(){
			var $file = $(this);  
			var objUrl = $file[0].files[0];
			var windowURL = window.URL || window.webkitURL;
			var dataURL;
			dataURL = windowURL.createObjectURL(objUrl);
			$("#image_update_show").attr("src",dataURL);			
		});
		
		/* ----------------------------------删除-------------------------------- */
		//删除商品
		$(document).on("click",".delete_btn",function(){
			//1.弹出是否删除对话框
			var goodsName = $(this).parents("tr").find("td:eq(1)").text();
			var goodsId = $(this).attr("del-id");
			if(confirm("确认删除【"+goodsName+"】吗？")){
				//确认发送ajax请求删除即可
				$.ajax({
					url:"${APP_PATH}/goods/"+goodsId,
					type:"DELETE",
					success:function(result){
						//alert(result.msg)
						//1.回到本页面
						to_page(currentPage);
					}
				});

			}
		});
		
		/* ----------------------------------补货-------------------------------- */
		//添加补货按钮事件
		$("#goods_stock_modal_btn").click(function(){
			//清除表单数据（表单完整重置：数据、样式）
			reset_form("#stock_form");
						
			//发送ajax请求，从数据库查出列表信息，显示在下拉列表中
			getGoods("#goods_stock_select");
			
			//弹出模态框
			$("#stockModal").modal({
				backdrop:"static"
			});			
		});
		
		
		
		//查询所有商品名
		function getGoods(ele){
			//清空之前下拉列表的值
			$(ele).empty();
			
			$.ajax({
				url:"${APP_PATH}/goodsnames",
				type:"GET",
				success:function(result){
					//{"code":100,"msg":"处理成功！","extend":{"depts":[{"dId":1,"dName":"研发部"},{"dId":2,"dName":"综合"},{"dId":3,"dName":"科教"},{"dId":4,"dName":"售后"},{"dId":5,"dName":"财务"},{"dId":6,"dName":"仓管"},{"dId":7,"dName":"车间"},{"dId":8,"dName":"科普"},{"dId":9,"dName":"企发"},{"dId":10,"dName":"实验室"},{"dId":11,"dName":"市场"},{"dId":12,"dName":"营销"}]}}
					//console.log(result);
					//显示部门信息在下拉列表中
					//$("#dept_select").append("")
					$.each(result.extend.allgoods,function(){
						var optionEle = $("<option></option>").append(this.name).attr("value",this.id);
						optionEle.appendTo(ele);
					});
					
				}
				
			});
		}
				
		
		//校验表单数据
		function validate_stock_form(){
			var stockPrice = $("#stock_price_input").val();
			var regPrice = /^([0-9]*)+(.[0-9]{1,2})?$/;
			
			if(!regPrice.test(stockPrice)){		
				show_validate_msg("#stock_price_input","error","价格最多两位小数");
				return false;
			}else{
				show_validate_msg("#stock_price_input","success","");						
			}
			
			var stockNum = $("#stock_num_input").val();
			var regNum = /^[1-9]\d*$/;
			
			if(!regNum.test(stockNum)){				
				show_validate_msg("#stock_num_input","error","数量为非零正整数");
				return false;
			}else{
				show_validate_msg("#stock_num_input","success","");						
			}
			
		}
		$("#stock_price_input").change(function(){	
			validate_stock_form();
			showSum();
		});
		$("#stock_num_input").change(function(){			
			validate_stock_form();
			showSum();
		});
				
		//总额
		function showSum(){
			if($("#stock_price_input").val() != null && $("#stock_num_input").val() != null){
				$("#stock_sum_input").attr("value", $("#stock_price_input").val()*$("#stock_num_input").val());
			}
		}
				
		//保存补货单
		$("#stock_save_btn").click(function(){
			optionIndex = $("#goods_stock_select option:selected").index("option");
			page = Math.ceil(optionIndex/perPageNum);
			
			//4.发送ajax请求保存		
			$.ajax({
				url:"${APP_PATH}/stock",
				type:"POST",
				data:$("#stock_form").serialize(),
				success:function(result){
					//alert(result.msg);
					if(result.code == 100){
						//保存成功：
						//1.关闭模态框
						$("#stockModal").modal("hide");					
						//2.来到最后一页，显示刚插入信息
						//发送ajax请求显示数据
						
						
						to_page(page);
					}else{
						//显示失败信息
						//console.log(result);
						//有哪个字段的错误信息就显示哪个字段
						if(undefined != result.extend.errorFields.stockPrice){
							//显示错误信息
							show_validate_msg("#stock_price_input","error",result.extend.errorFields.stockPrice);
						}
						if(undefined != result.extend.errorFields.stockNum){
							//显示错误信息
							show_validate_msg("#stock_num_input","error",result.extend.errorFields.stockNum);
						}	
					}										
					
				}
			}) 
			
		});
		
		
		
		
		
		
	</script>
</body>
</html>