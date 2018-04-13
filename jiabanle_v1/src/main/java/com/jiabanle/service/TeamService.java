package com.jiabanle.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.jiabanle.bean.Team;
import com.jiabanle.dao.TeamMapper;

@Service
public class TeamService {
	@Autowired
	TeamMapper teamMapper;

	public List<Team> getTeams() {
		List<Team> teams = teamMapper.selectByExample(null);
		return teams;
	}

}
