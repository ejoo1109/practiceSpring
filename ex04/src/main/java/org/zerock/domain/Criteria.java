package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//검색의 기준
//페이징 처리를 위해서는 페이지번호, 한 페이지당 몇개의 데이터를 보여줄 것인가가 결정되어야함

@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum;
	private int amount;
	
	//검색을 위한 변수
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1,15); 
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	//검색 조건이 T,W,C로 구성되어있어 배열로 만들어 한꺼번에 처리
	//배열이 null이라면 빈 배열 생성
	public String[] getTypeArr() {
		return type == null? new String[] {} : type.split("");
	}
}
