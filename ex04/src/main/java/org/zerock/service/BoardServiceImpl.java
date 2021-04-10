package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO board) {
		
		log.info("register....." + board);
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get....." + bno);
		
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify....." + board);
		
		return mapper.update(board)==1; 
		//성공이면 1이 반환되어 ==사용하여 true, false로 사용한다.
		// 또는 mapper.update(board)>0?true:false; 
	}

	@Override
	public boolean remove(Long bno) {
		log.info("remove....." + bno);
		
		return mapper.delete(bno)==1;
	}

//	@Override
//	public List<BoardVO> getList() {
//		log.info("getList ......");
//		
//		return mapper.getList();
//	}
	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("get List with criteria " + cri);
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count ");
		return mapper.getTotalCount(cri);
	}

}
