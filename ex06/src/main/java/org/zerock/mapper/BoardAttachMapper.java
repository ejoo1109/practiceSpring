package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardAttachVO;

public interface BoardAttachMapper {
//첨부파일은 수정개념이 없기 때문에 추가/삭제만 작성한다.
	public void insert(BoardAttachVO vo);
	public void delete(String uuid);
	public List<BoardAttachVO> findByBno(Long bno);
	public void deleteAll(Long bno);
	//데이터베이스와 맞지 않는 파일 지우기
	public List<BoardAttachVO> getOldFiles();
}
