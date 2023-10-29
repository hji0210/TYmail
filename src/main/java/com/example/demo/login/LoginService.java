package com.example.demo.login;

import java.util.HashMap;

public interface LoginService {
	
	public String loginCheck(HashMap<String, String> paramMap);
	
	public String idSearch(HashMap<String, String> paramMap);
	
	public String pwSearch(HashMap<String, String> paramMap);
	
	public int pwReset(HashMap<String, String> paramMap);
	
}
