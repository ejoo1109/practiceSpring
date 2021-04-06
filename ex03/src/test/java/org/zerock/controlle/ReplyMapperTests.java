package org.zerock.controlle;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class ReplyMapperTests {

	@Autowired
	private ReplyMapper mapper;
	
	//db에 실존하는 게시글 번호
	private Integer[] bnoArr = {776,772,769,767,766};
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i -> {
			ReplyVO vo = new ReplyVO();
			
			//게시물의 번호
			vo.setBno(bnoArr[i % 5]);
			vo.setReply("댓글테스트" +i );
			vo.setReplyer("replyer" + i);
			
			mapper.insert(vo);
		});
	}
	@Test
	public void testMapper() {
		log.info(""+mapper);
	}
	
	@Test
	public void testRead() {
		
		int targetRno = 5;
		ReplyVO vo = mapper.read(targetRno);
		
		log.info(""+vo);
	}
	
	@Test
	public void testDelete() {
		int targetRno = 1;
		mapper.delete(targetRno);
	}
	
	@Test
	public void testUpdate() {
		int targetRno = 10;
		ReplyVO vo = mapper.read(targetRno);
		vo.setReply("Update Reply");
		
		int count = mapper.update(vo);
		
		log.info("UPDATE COUNT: " + count);
	}
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		
		replies.forEach(reply -> log.info(""+reply));
	}
	
	@Test
	public void testList2() {
		Criteria cri = new Criteria(2, 10);
		
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 772);
		
		replies.forEach(reply -> log.info(""+reply));
	}
}
