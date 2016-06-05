package com.springmvc.common;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * <b>类说明：</b>继承此类即可在JUnit Test类中注入相关Service
 * 
 * @author kalper
 * @since 2016年06月06日
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration( locations = {"classpath:conf/spring.xml", "classpath:conf/spring-redis.xml", "classpath:conf/spring-mybatis.xml"})
public class SpringTestCase {
	
	
}
