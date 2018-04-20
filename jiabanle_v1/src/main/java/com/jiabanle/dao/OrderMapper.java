package com.jiabanle.dao;

import com.jiabanle.bean.Order;
import com.jiabanle.bean.OrderExample;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface OrderMapper {
    long countByExample(OrderExample example);

    int deleteByExample(OrderExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Order record);

    int insertSelective(Order record);

    List<Order> selectByExample(OrderExample example);

    Order selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Order record, @Param("example") OrderExample example);

    int updateByExample(@Param("record") Order record, @Param("example") OrderExample example);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);
    
    //根据条件查询带User的Order
    List<Order> selectByExampleWithUser(OrderExample example);
    //根据id查询带User的Order
    Order selectByPrimaryKeyWithUser(Integer id);
    
   
}