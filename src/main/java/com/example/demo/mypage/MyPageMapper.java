package com.example.demo.mypage;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MyPageMapper {
	
	public HashMap<String, String> myPageIndex(String id);
	
	public int myPageUpdate(HashMap<String, String> hashMap);
	
	public void myPageDelete(HashMap<String, String> hashMap);
	
}
