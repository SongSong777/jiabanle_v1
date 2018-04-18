package com.jiabanle.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiabanle.bean.Goods;
import com.jiabanle.bean.Msg;
import com.jiabanle.bean.Stock;
import com.jiabanle.service.GoodsService;
import com.jiabanle.service.StockService;

/**
 * 处理商品请求
 * @author swf19
 *
 */

@Controller
public class GoodsController {
	@Autowired
	GoodsService goodsService;
	
	@Autowired
	StockService stockService;
		
	/**
	 * 查询商品列表
	 * @param pn
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/allgoods")
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
	 * 保存商品
	 * @param user
	 * @param result
	 * @return
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	@RequestMapping(value="/goods", method=RequestMethod.POST)
	@ResponseBody
	public Msg saveGoods(@Valid Goods goods,BindingResult result,HttpServletRequest request) throws Exception {
		System.out.println(goods);
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
						
			goodsService.insertGoods(saveImage(goods));
			return Msg.success();
		}
		
	}
	
	private Goods saveImage(Goods goods) throws Exception {
		
		//保存数据库路径
		String sqlPath = null;
		//文件保存的本地路径
		//String localPath = request.getSession().getServletContext().getRealPath("/images");
		String localPath = "D:\\jiabanle\\";
		System.out.println(localPath);						
		//定义文件名
		String filename = null;

		if(!goods.getFile().isEmpty()){
			//生成uuid作为文件名
			String uuid = UUID.randomUUID().toString().replaceAll("-", "");
			//获取文件类型（判断不是图片禁止上传）
			String contentType = goods.getFile().getContentType();
			//获取文件后缀名
			String suffixName = contentType.substring(contentType.indexOf("/")+1);
			//得到文件名
			filename = uuid+"."+suffixName;
			System.out.println(filename);
			File dir = new File(localPath,filename);
			if(!dir.exists()){
				dir.mkdirs();
			}
			goods.getFile().transferTo(dir);
		}
		//把图片相对路径保存至数据库
		sqlPath = "/images/"+filename;
		System.out.println(sqlPath);			
		goods.setImage(sqlPath);
		return goods;
		
	}
	
	/**
	 * 按照id查询商品
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/goods/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getGoodsById(@PathVariable("id")Integer id){ 
		Goods goods = goodsService.getGoods(id);
		return Msg.success().add("goods", goods);
		
	}
	/**
	 * 更新商品
	 * @param goods
	 * @param result
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goods/{id}", method=RequestMethod.POST)
	@ResponseBody
	public Msg updateGoods(@Valid Goods goods,BindingResult result) throws Exception {
		//value="/goods/{id}"中的{}里传的值必须对应Goods属性名
		System.out.println(goods);
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
			goodsService.updateGoods(saveImage(goods));		
			return Msg.success();
		}	
			
	}
	
	/**
	 * 删除商品
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/goods/{id}", method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteGoods(@PathVariable Integer id) {
		System.out.println(id);
		goodsService.deleteGoods(id);
		return Msg.success();
		
	}
	
	/**
	 * 获取所有商品名称
	 * @return
	 */
	@RequestMapping("/goodsnames")
	@ResponseBody
	public Msg getGoodsNames() {
		List<Goods> allGoods = goodsService.getAll();
		return Msg.success().add("allgoods",allGoods);
		
		
	}
	
	/**
	 * 保存补货单
	 * @return
	 */
	@RequestMapping(value="/stock", method=RequestMethod.POST)
	@ResponseBody
	public Msg saveStock(@Valid Stock stock,BindingResult result) {
		Goods goods = goodsService.getGoods(stock.getGoodsId());
		System.out.println(goods);
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
			stockService.saveStock(stock);
			
			goods.setNumber(goods.getNumber()+stock.getStockNum());
			System.out.println(goods);
			goodsService.updateGoods(goods);
			
			return Msg.success();
		}
		

		
	}

		
}
		

