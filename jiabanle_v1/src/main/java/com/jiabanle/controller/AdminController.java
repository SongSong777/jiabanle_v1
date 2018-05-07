package com.jiabanle.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.jiabanle.bean.Admin;
import com.jiabanle.bean.Msg;
import com.jiabanle.service.AdminService;

/**
 * 处理管理员请求
 * @author swf19
 */
@Controller
public class AdminController {
	@Autowired
	AdminService adminService;
	
	/**
	 * 登录请求
	 * @param admin
	 * @param model
	 * @return
	 */
	
	@RequestMapping("/login")
	@ResponseBody
	public Msg login(Admin admin, HttpSession session) {
		System.out.println("用户登录："+admin.getUsername()+","+admin.getPassword());
		Admin a = adminService.checkLogin(admin.getUsername(), admin.getPassword());
		if(a != null){
			//登录成功
			session.setAttribute("admin", a);
			//mv.setViewName("home");
			return Msg.success().add("msg", "登录成功");
		}else{
			//登录失败
			//mv.addObject("msg","登录名和密码错误，请重新输入");
			//mv.setViewName("error");
			return Msg.fail().add("msg", "登录名和密码错误，请重新输入");
		}
		
	}
	@RequestMapping("/home")
	@ResponseBody
	public ModelAndView login(ModelAndView mv) {
		mv.setViewName("home");
		return mv;
		
	}
	
	
	
	/**
	 * 退出
	 * @param session
	 * @return
	 */
	@RequestMapping("/logout")
	public ModelAndView logout(ModelAndView mv,HttpSession session) {
		if(session.getAttribute("admin")!=null){
			session.removeAttribute("admin");
		}
		mv.setView(new RedirectView("./index.jsp"));
		return mv;
	}

	

}
