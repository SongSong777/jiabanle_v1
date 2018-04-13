package com.jiabanle.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiabanle.bean.Goods;
import com.jiabanle.bean.Msg;
import com.jiabanle.service.GoodsService;

/**
 * 处理商品请求
 * @author swf19
 *
 */

@Controller
public class GoodsController {
	@Autowired
	GoodsService goodsService;
		
	/**
	 * 查询商品列表
	 * @param pn
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/goods")
	public Msg getGoods(@RequestParam(value="pn", defaultValue="1")Integer pn) {
		PageHelper.startPage(pn, 5);
		List<Goods> goods = goodsService.getAll();
		PageInfo page = new PageInfo(goods,5);
		return Msg.success().add("pageInfo",page);		
		
	}
	
	
	@ResponseBody
	@RequestMapping("/checkgoods")
	public Msg checkGoods(@RequestParam("goodsName")String goodsName) {
		String regex = "^[\u2E80-\u9FFF]{2,20}$";
		if(!goodsName.matches(regex)){
			return Msg.fail().add("va_msg", "商品名称必须是2-20位中文");
		}
		boolean b = goodsService.checkGoods(goodsName);
		if(b){
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "商品名称不可用");
		}		
		
	}
	
	
	/**
	 * 
	 * @param user
	 * @param result
	 * @return
	 */
	@RequestMapping(value="/savegoods", method=RequestMethod.POST)
	@ResponseBody
	public Msg saveGoods(@Valid Goods goods,BindingResult result) {
		
		if(result.hasErrors()){
			//校验失败，应该返回失败，在模态框中显示校验失败的错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError :errors){
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());			
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			//保存数据库路径
			
			goodsService.insertGoods(goods);
			return Msg.success();
		}
		
	}
	
	

}
