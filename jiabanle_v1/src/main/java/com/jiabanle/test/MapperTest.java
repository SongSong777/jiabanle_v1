package com.jiabanle.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.jiabanle.bean.Goods;
import com.jiabanle.bean.User;
import com.jiabanle.dao.GoodsMapper;
import com.jiabanle.dao.UserMapper;



/**
 * 测试dao层工作
 * @author swf19
 * 推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
 * 1.导入SpringTest模块
 * 2.@ContextConfiguration指定Spring配置文件的位置
 * 3.直接autowired要使用的组件
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	UserMapper userMapper;
	@Autowired
	GoodsMapper goodsMapper;
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testCRUD() {
		/*    原生   
         * //1.创建SpringIOC容器
              ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
              //2.从容器中获取mapper
              UserMapper bean = ioc.getBean(UserMapper.class);
        */

		System.out.println(userMapper);	
		//插入用户		
/*		userMapper.insertSelective(new User(null,"宋宋","111111","研发部","产品组"));
		userMapper.insertSelective(new User(null,"蒋小奕","222222","研发部","经理"));
		userMapper.insertSelective(new User(null,"付小强","333333","研发部","平台组"));*/
		//插入商品
		//goodsMapper.insertSelective(new Goods(null,"胶囊咖啡", 4.00, "/jiabanle_v1/src/main/webapp/WEB-INF/img/coffee.jpg",null,null));
		//批量插入多个用户；批量，使用可以执行批量操作的sqlSession
/*		for(){
			userMapper.insertSelective(new User(null,"宋宋","111111","研发部","产品组"));
		}*/
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		for(int i=0; i<60; i++){
			String uid = UUID.randomUUID().toString().substring(0, 5) + i;
			mapper.insertSelective(new User(null,uid,null,"研发部","产品组"));
		}
	}
	

}
