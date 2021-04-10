package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {

	public List<BoardVO> getList();

	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVO board);
	
	//Criteria 타입을 파라메터로 사용하는 메서드
	public List<BoardVO> getListWithPaging(Criteria cri);
	//전체 게시물 수
	public int getTotalCount(Criteria cri);
	
	//댓글 개수- 2개이상 변수 받으려면 @Param 사용
	public void updateReplyCnt(@Param("bno") int bno, @Param("amount") int amount);
	
}
