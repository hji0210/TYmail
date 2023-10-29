package com.example.demo.home;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {
	
	@ResponseBody
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("userId");
		if(session.getAttribute("userId") == null) {
			System.out.println("로그아웃 성공");
			return "1";
		} else {
			System.out.println("로그아웃 실패");
			return "0";
		}
	}
	
}
