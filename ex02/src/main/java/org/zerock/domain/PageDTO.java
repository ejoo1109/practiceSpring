package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

//페이징 처리를 위한 vo
@Getter
@ToString
public class PageDTO {

	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total; //전체 게시물수
	private Criteria cri; // 현재 페이지번호, 페이지당 갯수
	
	public PageDTO(Criteria cri, int total) {
		
		this.cri = cri;
		this.total = total;
		
		//만약 3페이지를 조회할 경우 0.3-> 1 * 10 -> 10 개의 목록이 나와야함
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		this.startPage = this.endPage - 9;
		
		//끝페이지 = 770*1.0-> 770.0/15=51.333333 ->52 페이지 
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		
		this.next = this.endPage < realEnd;
	}
}
