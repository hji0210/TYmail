package com.example.demo.login;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	private LoginMapper loginMapper; 
	
	@Override
	public String loginCheck(HashMap<String, String> paramMap) {
		return loginMapper.loginCheck(paramMap);
	}
	
	@Override
	public String idSearch(
			@RequestParam HashMap<String, String> paramMap) {
		return loginMapper.idSearch(paramMap);
	}
	
	@Override
	public String pwSearch(
			@RequestParam HashMap<String, String> paramMap) {
		return loginMapper.pwSearch(paramMap);
	}
	
	@Override
	public int pwReset(HashMap<String, String> paramMap) {
		return loginMapper.pwReset(paramMap);
	}
	
}
