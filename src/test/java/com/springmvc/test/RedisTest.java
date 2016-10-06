package com.springmvc.test;

import java.util.HashMap;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;

import com.alibaba.fastjson.JSON;
import com.springmvc.common.SpringTestCase;
import com.springmvc.redis.service.RedisCache;
import com.springmvc.service.IUser_infosService;

public class RedisTest extends SpringTestCase{
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private RedisTemplate<String, HashMap<String, String>> redisTemplate;
	
	@Resource
	private IUser_infosService user_infosService;
	
	@Resource
	private RedisCache redisCache;
	
	@Test
	public void redisTest(){
		logger.info("开始设置name属性redis值");
		String key = "redis2";
		HashMap<String, String> value = new HashMap<String, String>();
		value.put("name", "zhengkaipei");
		redisTemplate.opsForValue().set(key, value);
		
		Object obj = redisTemplate.opsForValue().get(key);
		logger.debug(obj.toString());
		System.out.println( JSON.toJSON(obj) );
	}
	
	@Test
	public void getRedisValue(){
		String key = "redis2";
		
		Object obj = redisTemplate.opsForValue().get(key);
		System.out.println(obj.toString());
	}
	
	@Test
	public void test(){
//		int user_id = 1;
//		System.out.println(JSON.toJSON(user_infosService.selectUser_infosByID(user_id)));
		redisCache.put("testKey", new Object());
	}
}
