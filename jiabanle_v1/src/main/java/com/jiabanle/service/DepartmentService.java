package com.jiabanle.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jiabanle.bean.Department;
import com.jiabanle.dao.DepartmentMapper;

@Service
public class DepartmentService {
	@Autowired
	private DepartmentMapper departmentMapper;

	public List<Department> getDepts() {
		List<Department> depts = departmentMapper.selectByExample(null);
		return depts;
	}

}
