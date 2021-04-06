package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO vo);
	public ReplyVO read(int bno);
	public int delete(int rno);
	public int update(ReplyVO vo);
	
	//댓글 페이징처리
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") int bno);
	
	//댓글 갯수
	public int getCountByBno(int bno);
}
