package com.jiabanle.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jiabanle.bean.Admin;
import com.jiabanle.dao.AdminMapper;

@Service
public class AdminService {
	
	@Autowired
	AdminMapper adminMapper;
	
	public Admin checkLogin(String username, String password) {
		Admin admin = adminMapper.findByUsername(username);
		if(admin != null && admin.getPassword().equals(password)){
			return admin;
		}
		return null;
	}
	

}
