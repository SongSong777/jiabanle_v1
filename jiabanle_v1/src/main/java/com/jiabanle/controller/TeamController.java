package com.jiabanle.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jiabanle.bean.Msg;
import com.jiabanle.bean.Team;
import com.jiabanle.service.TeamService;


/**
 * 处理和小组有关的请求
 * @author swf19
 *
 */
@Controller
public class TeamController {
	@Autowired
	private TeamService teamService;
	
	/**
	 * 返回所有小组信息
	 */
	
	@RequestMapping("/teams")
	@ResponseBody
	public Msg getDepts() {
		List<Team> teams = teamService.getTeams();
		return Msg.success().add("teams", teams);
		
	}
}
