package com.example.demo.login;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.bind.annotation.RequestParam;

@Mapper
public interface LoginMapper {
	
	public String loginCheck(HashMap<String, String> hashMap);
	
	public String idSearch(HashMap<String, String> hashMap);
	
	public String pwSearch(HashMap<String, String> hashMap);
	
	public int pwReset(HashMap<String, String> hashMap);
	
}
