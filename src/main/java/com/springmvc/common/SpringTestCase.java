package com.springmvc.common;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration( locations = {"classpath:conf/spring.xml", "classpath:conf/spring-redis.xml", "classpath:conf/spring-mybatis.xml"})
public class SpringTestCase {
	
}
