package com.example.demo.register;

import java.util.HashMap;

public interface RegisterService {
	
	public String idCheck(String idInput);
	
	public String telCheck(String telInput);
	
	public int memberInsert(HashMap<String, String> paramMap);
	
}
