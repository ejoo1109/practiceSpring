package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);
	public ReplyVO get(int rno);
	public int modify(ReplyVO vo);
	public int remove(int rno);
	public List<ReplyVO> getList(Criteria cri, int bno);
	//댓글 페이징을 위한 댓글 개수, 목록 가져오기
	public ReplyPageDTO getListPage(Criteria cri, int bno);
}
