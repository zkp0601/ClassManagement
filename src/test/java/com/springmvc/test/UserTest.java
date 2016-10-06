package com.springmvc.test;

import java.io.ByteArrayInputStream;
import java.io.ObjectInputStream;
import java.io.Serializable;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;

import com.springmvc.common.SpringTestCase;
import com.springmvc.model.User;
import com.springmvc.model.User_infos;
import com.springmvc.service.IUserService;
import com.springmvc.service.IUser_infosService;

public class UserTest extends SpringTestCase{
	
	@Resource
	private IUserService userService;
	
	@Resource
	private IUser_infosService user_infosService;
	
	@Autowired
	private RedisTemplate<Serializable, Serializable> redisTemplate;
	
	@Test
	public void addUser(){
		User user = new User();
		user.setUsername("kalperaa");
		user.setPassword("kalper");
		userService.insertUser(user);
	}
	
	@Test
	public void addUser_infos(){
		User_infos info = new User_infos("彭康政", "12330417", "", "男", "8989", "753494474@qq.com", "");
		
		System.out.println( user_infosService.insertUser_infos(info) );
	}
	
	@Test 
	public void getUserInfoFromRedisTest(){
		
		Object obj = redisTemplate.execute(new RedisCallback<User_infos>() {
			@Override
			public User_infos doInRedis(RedisConnection connection) throws DataAccessException{
				long beforeExcuteTime = System.currentTimeMillis();
				String keyPrefix = "USER_INFOS_OF_USER_ID_";
				int user_id = 243;
				byte[] key = redisTemplate.getStringSerializer().serialize( keyPrefix + user_id );
				User_infos user_info = null;
				// redis中存在则直接从redis中获取
				if(connection.exists(key)){
					byte[] obj = connection.get(key);
					Object userInfoObj = null;
					try{
						ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(obj);
						ObjectInputStream objectInputStream = new ObjectInputStream(byteArrayInputStream);
						userInfoObj = objectInputStream.readObject();
						objectInputStream.close();
						byteArrayInputStream.close();
					}catch(Exception e){ }
					
					user_info = (User_infos) userInfoObj;
					System.out.println("redis中存在key为"+key.toString()+"的缓存");
					System.out.println("程序执行时间："+(System.currentTimeMillis() - beforeExcuteTime));
					return user_info;
				}else{
					// 不存在则从数据库中获取
					System.out.println("redis中不存在key为"+key.toString()+"的缓存");
					user_info =  user_infosService.selectUser_infosByID(user_id);
					System.out.println("程序执行时间："+(System.currentTimeMillis() - beforeExcuteTime));
					if( user_info != null ){
						connection.set(key, redisTemplate.getStringSerializer().serialize(user_info.toString()));
					}
					return user_info;
				}
			}
		});
		
		
	}
}
