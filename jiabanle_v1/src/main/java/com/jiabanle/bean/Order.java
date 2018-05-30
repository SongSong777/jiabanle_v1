package com.jiabanle.bean;

import java.util.Date;
import java.util.List;

public class Order {
    private Integer id;

    private Date date;

    private Double sum;

    private Integer userId;
    
    private User user;
    
    private List<OrderItems> orderItems;
    
    

    @Override
	public String toString() {
		return "Order [id=" + id + ", date=" + date + ", sum=" + sum + ", userId=" + userId + ", user=" + user + "]";
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Double getSum() {
        return sum;
    }

    public void setSum(Double sum) {
        this.sum = sum;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<OrderItems> getOrderItems() {
		return orderItems;
	}

	public void setOrderItems(List<OrderItems> orderItems) {
		this.orderItems = orderItems;
	}
}