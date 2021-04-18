package org.zerock.service;

import org.springframework.stereotype.Service;
//문자열을 변환하여 더하기 연산을 하는 작업
@Service
public class SampleServiceImpl implements SampleService {

	@Override
	public Integer doAdd(String str1, String str2) throws Exception {
		
		return Integer.parseInt(str1) + Integer.parseInt(str2);
	}

}
