package com.jiabanle.bean;

import java.util.Date;

import javax.validation.constraints.NotNull;

public class Stock {
    private Integer id;

    private Date date;
    
    private Integer goodsId;
    
    @NotNull(message="价格不能为空")
    private Double stockPrice;
    
    @NotNull(message="数量不能为空")
    private Integer stockNum;

    private Double sum;

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

    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
    }

    public Double getStockPrice() {
        return stockPrice;
    }

    public void setStockPrice(Double stockPrice) {
        this.stockPrice = stockPrice;
    }

    public Integer getStockNum() {
        return stockNum;
    }

    public void setStockNum(Integer stockNum) {
        this.stockNum = stockNum;
    }

    public Double getSum() {
        return sum;
    }

    public void setSum(Double sum) {
        this.sum = sum;
    }
}