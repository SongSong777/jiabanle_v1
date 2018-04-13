package com.jiabanle.bean;

public class Team {
    private Short tId;

    private String tName;

    private Short dId;

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
}