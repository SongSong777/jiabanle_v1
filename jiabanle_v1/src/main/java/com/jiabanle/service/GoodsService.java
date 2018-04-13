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

	public boolean checkGoods(String goodsName) {
		GoodsExample example = new GoodsExample();
		Criteria criteria = example.createCriteria();
		criteria.andNameEqualTo(goodsName);
		long count = goodsMapper.countByExample(example);
		return count==0 ;
	}

	public void insertGoods(@Valid Goods goods) {
		goodsMapper.insertSelective(goods);
		
	}
	
	

}
