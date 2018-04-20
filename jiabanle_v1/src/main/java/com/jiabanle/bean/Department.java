package com.jiabanle.bean;

import java.util.List;

public class Department {
    private Short dId;

    private String dName;
    
    private List<User> users ;

    public Short getdId() {
        return dId;
    }


    public void setdId(Short dId) {
        this.dId = dId;
    }

    public String getdName() {
        return dName;
    }

    public void setdName(String dName) {
        this.dName = dName == null ? null : dName.trim();
    }


	public List<User> getUsers() {
		return users;
	}


	public void setUsers(List<User> users) {
		this.users = users;
	}
}