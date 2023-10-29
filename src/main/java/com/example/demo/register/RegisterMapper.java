package com.example.demo.register;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RegisterMapper {
	
	public String idCheck(String idInput);
	
	public String telCheck(String telInput);
	
	public int memberInsert(HashMap<String, String> hashMap);
	
}
