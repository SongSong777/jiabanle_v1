package com.jiabanle.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jiabanle.bean.User;
import com.jiabanle.bean.UserExample;
import com.jiabanle.bean.UserExample.Criteria;
import com.jiabanle.dao.UserMapper;

@Service
public class UserService {
	@Autowired
	UserMapper userMapper;
	/**
	 * 查询所有用户
	 */
	public List<User> getAll() {				
		return userMapper.selectByExample(null);
	}
	/**
	 * 保存用户
	 * @param user
	 */
	public void saveUser(User user) {
		userMapper.insertSelective(user);		
	}
	
	/**
	 * 检验用户名是否可用
	 * @param userName
	 * @return true：当前姓名可用；false：不可用
	 */
	public boolean checkUser(String userName) {
		UserExample example = new UserExample();
		Criteria criteria = example.createCriteria();
		criteria.andNameEqualTo(userName);
		long count = userMapper.countByExample(example);
		return count==0 ;
	}

	
	/**
	 * 按照员工id查询员工
	 * @param id
	 * @return
	 */		
	public User getUser(Integer id) {
		User user = userMapper.selectByPrimaryKey(id);		
		return user;
	}
	
	/**
	 * 员工更新
	 * @param user
	 */
	public void updateUser(User user) {
		userMapper.updateByPrimaryKeySelective(user);
		
	}

	/**
	 * 员工删除
	 * @param id
	 */	
	public void deleteUser(Integer id) {		
		userMapper.deleteByPrimaryKey(id);
	}
	
	public void deleteBatch(List<Integer> ids) {
		UserExample example = new UserExample();
		Criteria criteria = example.createCriteria();
		criteria.andIdIn(ids);		
		userMapper.deleteByExample(example);
		
	}
	


}
