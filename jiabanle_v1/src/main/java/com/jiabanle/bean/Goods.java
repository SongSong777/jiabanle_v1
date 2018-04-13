package com.jiabanle.bean;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

public class Goods {
    private Integer id;
    
    @Pattern(regexp="^[\u2E80-\u9FFF]{2,20}$",message="商品名称必须是2-20位中文")
    private String name;

    private String description;
    
    @NotNull(message="价格不能为空")
    private Double price;

    private String image;

    private Short number;

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image == null ? null : image.trim();
    }

    public Short getNumber() {
        return number;
    }

    public void setNumber(Short number) {
        this.number = number;
    }
}