package com.example.demo.register;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RegisterServiceImpl implements RegisterService {
	
	private static final Logger logger = LoggerFactory.getLogger(RegisterServiceImpl.class);
	
	@Autowired
	private RegisterMapper registerMapper;
	
	@Override
	public String idCheck(String idInput) {
		String idCheckResult = registerMapper.idCheck(idInput);
		logger.info("RegisterServiceImpl :: idCheck :: result = " + idCheckResult);
		return idCheckResult;
	}
	
	@Override
	public String telCheck(String telInput) {
		String telCheckResult = registerMapper.telCheck(telInput);
		logger.info("RegisterServiceImpl :: telCheck :: result = " + telCheckResult);
		return telCheckResult;
	}
	
	@Override
	public int memberInsert(HashMap<String, String> paramMap) {
		logger.info("RegisterServiceImpl :: memberInsert() :: paramMap= " + paramMap);
		return registerMapper.memberInsert(paramMap);
	}

}
