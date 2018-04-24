package com.jiabanle.service;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jiabanle.bean.Goods;
import com.jiabanle.bean.GoodsExample;
import com.jiabanle.bean.GoodsExample.Criteria;
import com.jiabanle.dao.GoodsMapper;

@Service
public class GoodsService {
	@Autowired
	GoodsMapper goodsMapper;
	
	/**
	 * 获取所有商品
	 * @return
	 */
	public List<Goods> getAll() {						
		return goodsMapper.selectByExample(null);
	}
	
	/**
	 * 检验商品名
	 * @param goodsName
	 * @return
	 */
	public boolean checkGoods(String goodsName) {
		GoodsExample example = new GoodsExample();
		Criteria criteria = example.createCriteria();
		criteria.andNameEqualTo(goodsName);
		long count = goodsMapper.countByExample(example);
		return count==0 ;
	}
	/**
	 * 保存新增商品
	 * @param goods
	 */
	public void insertGoods(@Valid Goods goods) {
		goodsMapper.insertSelective(goods);
		
	}
	/**
	 * 根据id获取商品
	 * @param id
	 * @return
	 */
	public Goods getGoods(Integer id) {
		Goods goods = goodsMapper.selectByPrimaryKey(id);
		return goods;
	}

	
	public void updateGoods(Goods goods) {
		goodsMapper.updateByPrimaryKey(goods);
		
	}

	public void deleteGoods(Integer id) {
		goodsMapper.deleteByPrimaryKey(id);
		
	}
	
	

}
