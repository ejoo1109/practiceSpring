package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {

	public void register(BoardVO board);
	//개별조회
	public BoardVO get(Long bno);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	//전체조회-게시물 15개
	//public List<BoardVO> getList();
	public List<BoardVO> getList(Criteria cri);
	//전체 게시물 수
	public int getTotal(Criteria cri);
	//첨부파일 조회
	public List<BoardAttachVO> getAttachList(Long bno);
}
