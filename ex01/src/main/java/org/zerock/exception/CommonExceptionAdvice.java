package org.zerock.exception;

import org.springframework.http.HttpStatus;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.slf4j.Slf4j;
//공통적인 예외 처리를 하는 AOP 
@ControllerAdvice
@Slf4j
public class CommonExceptionAdvice {
	//모든 예외 클래스로 지정
	@ExceptionHandler(Exception.class) 
	public String except(Exception ex, Model model) {
		
		log.error("Exception ....." + ex.getMessage());
		model.addAttribute("exception", ex);
		log.error(""+model);
		return "error_page";
	}
	
	//404에러
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404(NoHandlerFoundException ex) {
		
		return "custom404";
	}
}
