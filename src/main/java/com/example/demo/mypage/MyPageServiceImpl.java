package com.example.demo.mypage;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MyPageServiceImpl implements MyPageService {
	
	@Autowired
	MyPageMapper myPageMapper;
	
	@Override
	public HashMap<String, String> myPageIndex(String id) {
		return myPageMapper.myPageIndex(id);
	}

	@Override
	public int myPageUpdate(HashMap<String, String> paramMap) {
		return myPageMapper.myPageUpdate(paramMap);
	}

	@Override
	public void myPageDelete(HashMap<String, String> paramMap) {
		myPageMapper.myPageDelete(paramMap);
	}

}
