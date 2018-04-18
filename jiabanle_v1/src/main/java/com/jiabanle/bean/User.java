package com.jiabanle.bean;

import java.util.List;

import javax.validation.constraints.Pattern;

public class User {
    private Integer id;

    @Pattern(regexp="^[\u2E80-\u9FFF]{2,5}$",message="用户名必须是2-5位中文")
    private String name;

    private String password;

    private String department;

    private String team; 
    
    private List<Order> orders;
    
    
    public User() {
		super();
		// TODO Auto-generated constructor stub
	}
    
    

	public User(Integer id, String name, String password, String department, String team) {
		super();
		this.id = id;
		this.name = name;
		this.password = password;
		this.department = department;
		this.team = team;
	}



	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department == null ? null : department.trim();
    }

    public String getTeam() {
        return team;
    }

    public void setTeam(String team) {
        this.team = team == null ? null : team.trim();
    }


	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", password=" + password + ", department=" + department + ", team="
				+ team + "]";
	}



	public List<Order> getOrders() {
		return orders;
	}



	public void setOrders(List<Order> orders) {
		this.orders = orders;
	}
}