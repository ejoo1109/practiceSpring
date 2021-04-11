package org.zerock.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.zerock.service.SampleService;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class SampleServiceTests {

	@Autowired
	private SampleService service;

	@Test
	public void testClass() {
		log.info(""+service);
		log.info(service.getClass().getName());
	}
	
	@Test
	public void testAdd() throws Exception {
		
		log.info(""+service.doAdd("123", "456"));
	}
	
	@Test
	public void testAddError() throws Exception {
		log.info(""+service.doAdd("123", "ABC"));
	}
}
