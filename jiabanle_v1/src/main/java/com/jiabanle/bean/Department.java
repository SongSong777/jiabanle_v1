package com.jiabanle.bean;

public class Department {
    private Short dId;

    private String dName;

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
}