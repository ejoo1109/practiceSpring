package org.zerock.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class SampleTxServiceTests {

	@Autowired
	private SampleTxService service;
	
	@Test
	// tbl_sample1(500byte) 에는 82byte 였으므로 insert가 추가 되지만 tbl_sample2(50byte)에는 추가 되지 않음
	// 트랜잭션 어노테이션 추가 이후에는 두개의 테이블 모두 추가 되지 않음 => rollback 처리
	public void testLong() {
	String str = "Starry\r\n" + "Starry night\r\n" + "Paint your palette blue and grey\r\n" + "Look out on a summer's day";
	
	log.info(""+str.getBytes().length);
	service.addData(str);
	
	}
}
