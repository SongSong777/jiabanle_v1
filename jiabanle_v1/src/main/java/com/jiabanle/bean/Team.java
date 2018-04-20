package com.jiabanle.bean;

import java.util.List;

public class Team {
    private Short tId;

    private String tName;

    private Short dId;
    
    private List<User> users;

    public Short gettId() {
        return tId;
    }

    public void settId(Short tId) {
        this.tId = tId;
    }

    public String gettName() {
        return tName;
    }

    public void settName(String tName) {
        this.tName = tName == null ? null : tName.trim();
    }

    public Short getdId() {
        return dId;
    }

    public void setdId(Short dId) {
        this.dId = dId;
    }

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}
}