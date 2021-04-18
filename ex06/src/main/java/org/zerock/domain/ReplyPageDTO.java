package org.zerock.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
//댓글 페이징 처리를 위해서는 댓글 목록과 전체 개수를 같이 넘겨준다.
@Data
@Getter
@AllArgsConstructor
public class ReplyPageDTO {

	private int replyCnt; //댓글개수
	private List<ReplyVO> list; //댓글목록
}
