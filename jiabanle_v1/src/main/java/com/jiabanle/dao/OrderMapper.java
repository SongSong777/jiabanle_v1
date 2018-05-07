package com.jiabanle.dao;

import com.jiabanle.bean.Bill;
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
    
    //根据user的部门和小组查询Order
    List<Order> selectByDTWithUser(Map<String,String> map);
    //根据日期查询月账单总额
    List<Bill> getSumByDateWithUser(String date);
    //根据uid查询带user的订单
    List<Order> selectWithUserByUid(@Param("date")String date, @Param("uid")Integer uid);
    
    //根据日期和时间段查询订单总数
	Integer getOrderCount(Map<String,String> map);	
	//根据日期查询消费员工数
	Integer getUserCount(Map<String,String> map);
	//根据日期查询消费总额
	double getTotalSum(Map<String,String> map);
	//根据日期查询商品销售数量
	Integer getGoodsCount(Map<String,String> map);
	
}