package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SampleVO;
import org.zerock.domain.Ticket;

import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;


@RestController //리턴타입이 jsp가 아닌 데이터 형태
@RequestMapping("/sample")
@Slf4j
public class SampleController {

	//텍스트형태 반환
	@GetMapping(value="/getText", produces="text/plain; charset=UTF-8")
	public String getText() {
		
		log.info("MIME TYPE: " + MediaType.TEXT_PLAIN_VALUE);
		
		return "안녕하세요";
	}
	
	//객체 반환
	//getSample -> xml형태
	//getSample.json -> {"mno":112,"firstName":"스타","lastName":"로드"}
	@GetMapping(value="/getSample", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, 
			MediaType.APPLICATION_XML_VALUE})
		public SampleVO getSample() {
		return new SampleVO(112, "스타", "로드");
	}
	
	// GetMapping 이나 @RequestMapping의 produes 속성은 필수사항은 아님
	@GetMapping(value="/getSample2")
		public SampleVO getSample2() {
		return new SampleVO(113, "로켓", "라쿤");
	}

	//컬렉션 타입의 객체반환
	//1~10까지 1first 1Last형태로 반환
	///getList.json -> [{"mno":1,"firstName":"1first","lastName":"1Last"},{"mno":2,"firstName":"2first","lastName":"2Last"}
	@GetMapping(value="/getList")
	public List<SampleVO> getList() {
	return IntStream.range(1, 10).mapToObj(i-> new SampleVO(i, i+
			"first", i+"Last")).collect(Collectors.toList());
}
	
	//Map(키.밸류) 타입 객체 반환
	//getMap.json -> {"First":{"mno":111,"firstName":"그루트","lastName":"주니어"}}
	@GetMapping(value="/getMap")
	public Map<String, SampleVO> getMap(){
		
		Map<String, SampleVO> map = new HashMap<>();
		map.put("First", new SampleVO(111, "그루트", "주니어"));
		
		return map;		
	}
	
	//ResponseEntity - 데이터+http 상태코드 : 정상적인 데이터인지 제공해야함
	//만약 height가 150 보다 작다면 BAD_GATEWAY :502 + VO
	//height가 150보다 크다면 OK: 200+ vo
	//http://localhost:8080/sample/check.json?height=140&weight=60 -> 502 + {"mno":0,"firstName":"160.0","lastName":"60.0"}
	//http://localhost:8080/sample/check.json?height=160&weight=60 -> 200 + {"mno":0,"firstName":"160.0","lastName":"60.0"}
	@GetMapping(value="/check", params = {"height", "weight"})
	public ResponseEntity<SampleVO> check(Double height, Double weight) {
		
		SampleVO vo= new SampleVO(0, "" + height, ""+ weight);
		ResponseEntity<SampleVO> result = null;

		if(height < 150) { 
			result =ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		}else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		return result;
	}
	
	//@RestController 에서 파라미터
	//@PathVariable - url상에서 경로의 일부를 파라메터로 사용
	//@RequestBody - body를 이용해 JSON 데이터를 파라메터 타입의 객체로 변환하여 리턴
	
	///product/bags/1234 -> category: bags , productid: 1234
	@GetMapping("/product/{cat}/{pid}")
	public String[] getPath(
		@PathVariable("cat") String cat,
		@PathVariable("pid") Integer pid) {
		
		return new String[] {"category: "+ cat, "productid: " + pid};
	}	
	
	//@RequestBody 는 body에 전송되므로 @PostMapping 을 사용해야한다.
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		
		log.info("convert ............... ticket"+ticket);
		
		return ticket;
	}
	
	// REST 방식 
	//1. 조회 - GET -> /members/{id}
	//2. 등록 - POST -> /members/new
	//3. 수정 - PUT -> /members/{id}+body(josn데이터 등)
	//4. 삭제 - DELETE -> /member/{id}
}