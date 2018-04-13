package com.jiabanle.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 页面跳转
 * @author swf19
 *
 */

@Controller
public class FormController {
	@RequestMapping(value="/{forName}")
	public String loginForm(@PathVariable String forName) {
		return forName;
	}

}

