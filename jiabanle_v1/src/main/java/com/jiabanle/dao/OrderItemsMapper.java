package com.jiabanle.dao;

import com.jiabanle.bean.OrderItems;
import com.jiabanle.bean.OrderItemsExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface OrderItemsMapper {
    long countByExample(OrderItemsExample example);

    int deleteByExample(OrderItemsExample example);

    int deleteByPrimaryKey(Long id);

    int insert(OrderItems record);

    int insertSelective(OrderItems record);

    List<OrderItems> selectByExample(OrderItemsExample example);

    OrderItems selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") OrderItems record, @Param("example") OrderItemsExample example);

    int updateByExample(@Param("record") OrderItems record, @Param("example") OrderItemsExample example);

    int updateByPrimaryKeySelective(OrderItems record);

    int updateByPrimaryKey(OrderItems record);
}