package com.jiabanle.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiabanle.bean.Msg;
import com.jiabanle.bean.User;
import com.jiabanle.service.UserService;

/**
 * 处理用户CRUD请求
 * @author swf19
 */
@CrossOrigin(maxAge = 3600)
@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	
	@CrossOrigin("http://127.0.0.1:8020")
	@RequestMapping(value="/userLogin",method=RequestMethod.POST)
	@ResponseBody
	public Msg loginCheckUser(@RequestBody User user) {
		//System.out.println(user);
		User u = userService.checkLogin(user.getName(), user.getPassword());
		if(u != null){
			//登录成功
			
			return Msg.success().add("msg", "登录成功").add("user", u);
		}else{
			//登录失败
			return Msg.fail().add("msg", "登录名和密码错误，请重新输入");
		}
	}
	
	
	
	
	
	/*
	 * **********************************************后台管理*******************************************
	 */
	
	/**
	 * 单个批量二合一
	 * 批量删除：id1-id2-id3
	 * 单个删除：id
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/user/{ids}",method=RequestMethod.DELETE)
	public Msg deleteUser(@PathVariable("ids")String ids) {
		if(ids.contains("-")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			//组装id的集合
			for (String id : str_ids) {
				del_ids.add(Integer.parseInt(id));
				
			}
			userService.deleteBatch(del_ids);
		}else{
			int del_id = Integer.parseInt(ids);
			userService.deleteUser(del_id);
			
		}
		return Msg.success();
		
	}
	
	
	
	/**
	 * 如果直接发送ajax=PUT请求，除了id，其他都是null
	 * 问题：请求体中有数据，但User对象封装不上
	 * Mapper中update tbl_user where id = 缺少set语句
	 * 原因：
	 * Tomcat:
	 * 		1.将请求体中数据封装一个map
	 * 		2.request.getParameter("userName")就会从这个map中取值
	 * 		3.SpringMVC封装POJO对象的时候，会把POJO中每个属性的值，request.getParameter()取到
	 * AJAX发送PUT请求
	 * 		请求体中的数据request.getParameter()取不到
	 * 		Tomcat看是PUT请求，不会封装请求体数据为map，只有POST才封装请求体
	 * 直接发PUT请求：配置HttpPutFormContentFilter，
	 * 作用：将请求体中数据解析包装成map，request被重新包装，request.getParameter()被重写，从自己封装的map中获取数据
	 * 
	 * 更新用户信息
	 * @param user
	 * @return
	 */
	@RequestMapping(value="/user/{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg saveUserById(User user) {
		System.out.println(user);
		userService.updateUser(user);
		return Msg.success();
	}
	
	
	/**
	 * 按照用户id查询用户
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/user/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getUser(@PathVariable("id")Integer id){ 
		System.out.println(id);
		User user = userService.getUser(id);
		System.out.println(user);
		return Msg.success().add("user", user);
		
	}
	
	/**
	 * 检查用户名是否可用
	 * @param userName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkUser(@RequestParam("userName")String userName) {
		//先判断用户名是否是合法表达式
		String regex = "^[\u2E80-\u9FFF]{2,5}$";
		if(!userName.matches(regex)){
			return Msg.fail().add("va_msg", "用户名必须是2-5位中文");
		}
		boolean b = userService.checkUser(userName);
		if(b){
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名不可用");
		}
		
	}
	
	/**
	 * 员工保存
	 * 1.支持JSR303校验
	 * 2.导入hibernate-validator
	 * @return
	 */
	
	@RequestMapping(value="/user", method=RequestMethod.POST)
	@ResponseBody
	public Msg saveUser(@Valid User user,BindingResult result) {
		if(result.hasErrors()){
			//校验失败，应该返回失败，在模态框中显示校验失败的错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError :errors){
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());			
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			userService.saveUser(user);
			return Msg.success();
		}
		
	}
	
	@RequestMapping("/users")
	@ResponseBody
	public Msg getUsersWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn) {
		PageHelper.startPage(pn, 10);
		List<User> users = userService.getAll();
		PageInfo page = new PageInfo(users,5);//导航页显示数
		return Msg.success().add("pageInfo",page);		
	}
	
	
	/*8
	 * 查询员工数据（分页查询）
	 * @return
	 */
	//@RequestMapping("/users")
	public String getUsers(@RequestParam(value="pn",defaultValue="1")Integer pn, Model model) {
		//引入PageHelper分页插件
		//查询之前只需要调用，传入页码以及每页显示数量
		PageHelper.startPage(pn, 5);
		//startPage后紧跟着的查询就是分页查询
		List<User> users = userService.getAll();
		//使用PageInfo包装查询后的结果，只需要将PageInfo交给页面即可
		//封装了详细的分页信息，包括查询出的数据，第二个参数，连续显示页数
		PageInfo page = new PageInfo(users,5);
		model.addAttribute("pageInfo",page);				
		return "user";
	}

}
