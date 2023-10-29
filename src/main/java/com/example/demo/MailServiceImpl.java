package com.example.demo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service //요 어노테이션 중요 ***
public class MailServiceImpl implements MailService{
	
	@Autowired
	private MailMapper mailMapper;
	
	
	public MailDTO selectContent(String no) {
		return mailMapper.selectContent(no);
	}
	
}
