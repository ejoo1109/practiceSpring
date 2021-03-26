package org.zerock.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.SampleDTO;
import org.zerock.domain.SampleDTOList;
import org.zerock.domain.TodoDTO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/sample/*")
@Slf4j
public class SampleController {

	@RequestMapping(value = "/basic", method = {RequestMethod.GET, RequestMethod.POST})
	public void basic() {
	log.info("basic get.........");
	}

	@GetMapping("/basicOnlyGet")
		public void basicGet2() {
			log.info("basic get only get....................");
		}
	
	//dto 객체에 담아서 가져오는 방법 /sample/ex01?name=hong&age=11 -> SampleDTO(name=hong, age=11)
	@GetMapping("/ex01") 
	public String ex01(SampleDTO dto) {
		log.info("" + dto); //
		
		return "ex01";
	}
	
	//localhost:8080/sample/ex02?name=park&age=9
	//@RequestParam - 파라미터로 사용된 변수 이름과 전달되는 파라미터의 이름이 다른경우 -> name : park ,age : 9
	@GetMapping("/ex02") 
	public String ex02(@RequestParam("name") String name, @RequestParam("age") int age) {
		log.info("name : " + name); 
		log.info("age : " + age); 
		
		return "ex02";
	}
	
	///sample/ex02List?ids=111&ids=222&ids=333
	//@RequestParam - 동일한 이름의 파라미터가 여러개 전달되는경우 -> ids : [111, 222, 333]
	@GetMapping("/ex02List") 
	public String ex02List(@RequestParam("ids") ArrayList<String> ids) {
		log.info("ids : " + ids); 
		
		return "ex02List"; 
	}
	///sample/ex02List?ids=111&ids=222&ids=333 -> array ids : [111, 222, 333]
	//@RequestParam - 동일한 이름의 파라미터가 여러개 전달되는경우 배열
	@GetMapping("/ex02Array") 
	public String ex02Array(@RequestParam("ids") String[] ids) {
		log.info("array ids : " + Arrays.toString(ids)); 
		
		return "ex02Array"; 
	}
	
	// DTO 객체를 여러개 받을때 
	///sample/ex02Bean?list%5B0%5D.name=aaa&list%5B1%5D.name=bbb&%5B2%5D.name=ccc
	//list dtos: SampleDTOList(list=[SampleDTO(name=aaa, age=0), SampleDTO(name=bbb, age=0)])
	@GetMapping("/ex02Bean") 
	public String ex02Bean(SampleDTOList list) {
		log.info("list dtos: " + list); 
		
		return "ex02Bean"; 
	}
	
	//날짜를 받아와서 변환해야 할때 -@InitBinder 사용
//	@InitBinder
//	public void initBinder(WebDataBinder binder) {
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//		binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, false));
//	}
	
	///sample/ex03?title=test&dueDate=2021-03-25 -> todo: TodoDTO(title=test, dueDate=Thu Mar 25 00:00:00 KST 2021)
	// 또는 DTO 변수위에 @DateTimeFormat(pattern = "yyyy/MM/dd") 사용시 /sample/ex03?title=test&dueDate=2021/03/25 @InitBinder사용안해도됨
	@GetMapping("/ex03") 
	public String ex03(TodoDTO todo) {
		log.info("todo: " + todo); 
		
		return "ex03"; 
	}
	
	//Model - 컨트롤러에서 뷰로 데이터 전달
	//http://localhost:8080/sample/ex04?name=aaa&age=11&page=9 
	//파라미터에 @ModelAttribute("page") 사용시 page라는 value가 강제로 전달
	@GetMapping("/ex04") 
	public String ex04(SampleDTO dto, @ModelAttribute("page") int page) {
		log.info("dto: " + dto); 
		log.info("page: " + page); 
		
		return "/sample/ex04"; 
	}
	
	//리턴타입
	//void: 호출하는 url과 동일한 이름의 jsp
	//sample/ex05 -> [/WEB-INF/views/sample/ex05.jsp]을(를) 찾을 수 없습니다.
	@GetMapping("/ex05")
	public void ex05() {
		log.info("/ex05......");
	}
	//String: 상황에 따라 다른jsp 페이지로 이동할때 (if~else) 
	//retrun 문자열.jsp(servlet-context의 뷰리졸버가자동으로 jsp붙여줌)
	
	//객체타입 : VO나 DTO 를 반환, 주로 JSON 데이터 만드는 용도로 사용됨
	// /sample/ex06
	@GetMapping("/ex06")
	public @ResponseBody SampleDTO ex06() {
		log.info("/ex06......");
		
		SampleDTO dto = new SampleDTO();
		dto.setAge(10);
		dto.setName("홍길동");
		
		return dto;
	}
	
	// ResponseEntity 타입 : http 헤더 + 상태코드
	///sample/ex07 -> F12 network respose 영역에 정보 전달
	@GetMapping("/ex07")
	public ResponseEntity<String> ex07() {
		log.info("/ex07......");
		
		String msg = "{\"name\": \"홍길동\"}";
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json;charset=UTF-8");
		
		return new ResponseEntity<>(msg, header, HttpStatus.OK);
	}
	
	//파일 업로드 : pom.xml라이브러리 추가 + servlet-context에 멀티파트리졸버 빈 객체 생성
	//http://localhost:8080/sample/exUpload
	
	@GetMapping("/exUpload")
	public void exUpload() {
		log.info("/exUpload.......");
	}
	
	@PostMapping("/exUploadPost")
	public void exUploadPost(ArrayList<MultipartFile> files) {
		
		files.forEach(file -> {
			log.info("------------------");
			log.info("name: " + file.getOriginalFilename());
			log.info("size: " + file.getSize());
		});

	}
}
