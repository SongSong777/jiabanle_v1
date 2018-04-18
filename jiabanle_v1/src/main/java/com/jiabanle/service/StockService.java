package com.jiabanle.service;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jiabanle.bean.Stock;
import com.jiabanle.dao.StockMapper;
@Service
public class StockService {
	@Autowired
	StockMapper stockMapper;
	
	/**
	 * 保存补货单
	 * @param stock
	 */
	public void saveStock(@Valid Stock stock) {
		stockMapper.insertSelective(stock);
		
	}
	

}
