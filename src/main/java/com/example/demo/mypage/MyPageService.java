package com.example.demo.mypage;

import java.util.HashMap;

public interface MyPageService {
	
	public HashMap<String, String> myPageIndex(String id);
	
	public int myPageUpdate(HashMap<String, String> paramMap);
	
	public void myPageDelete(HashMap<String, String> paramMap);
	
}
