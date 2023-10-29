package com.example.demo.register;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class RegisterController {
	
	private static final Logger logger = LoggerFactory.getLogger(RegisterController.class);
	
	@Autowired
	private RegisterService registerService;
	
	   // 회원가입 페이지 진입
	   @RequestMapping(value="/register")
	   public String registerForm(
	         HttpSession session,
	         HttpServletRequest request,
	         Model model) {
//	      session.removeAttribute("userId");
	      // 이미 로그인한 상태인 경우 돌려보내기
	      String userId = (String) session.getAttribute("userId");
	      String referer = request.getHeader("Referer");
	      if(userId != null && referer != null) {
//	         System.out.println("로그인 상태");
	         request.setAttribute("message", "이미 로그인한 상태입니다.");
	         request.setAttribute("url", referer);
	         return "/login/alert";
	      } else if(userId != null && referer == null) {   // url 직접 쳐서 진입한 경우
//	         System.out.println("로그인 상태(url)");
	         request.setAttribute("message", "이미 로그인한 상태입니다.(url)");
	         request.setAttribute("url", "/mypage");
	         model.addAttribute("send_id", userId);
	         return "/login/alert";
	      }
	      return "/register/registerForm";
	   }
	
	// id 중복 검사
	@ResponseBody	// 이거 써줘야 jsp ajax로 리턴 가능
	@RequestMapping(value="/register/idCheck")
	public String idCheck(@RequestParam("idInput") String idInput) {
		// 입력한 값으로 DB에 요청
		String idCheckResult = registerService.idCheck(idInput);
		if(idCheckResult == null) {	// 중복 없음 -> 사용 가능한 id
			logger.info("RegisterController :: idCheck :: result = 1");
			return "1";
		} else {	// 중복 존재
			logger.info("RegisterController :: idCheck :: result = 0");
			return "0";
		}
	}
	
	// 전화번호 중복 검사
	@ResponseBody
	@RequestMapping(value="/register/telCheck")
	public String telCheck(@RequestParam("telInput") String telInput) {
		// 입력한 값으로 DB에 요청
		String telCheckResult = registerService.telCheck(telInput);
		if(telCheckResult == null) {	// 중복 없음 -> 사용 가능한 tel
			logger.info("RegisterController :: telCheck :: result = 1");
			return "1";
		} else {	// 중복 존재
			logger.info("RegisterController :: telCheck :: result = 0");
			return "0";
		}
	}
	
	// 가입 요청
	   @ResponseBody
	   @RequestMapping(value="/register/registerInsert")
	   public String registerInsert(
	         @RequestParam HashMap<String, String> paramMap) {
	      // 이메일 주소로 id 값 설정
	      String inputId = paramMap.get("id");
	      paramMap.put("id", inputId + "@tymail.com");
	      logger.info("RegisterController :: memberInsert() :: paramMap= " + paramMap);
	      // 입력한 값으로 DB에 insert 요청
	      int insertResult = registerService.memberInsert(paramMap);
	      return insertResult + "";
	   }
	   
	   // 가입 결과 페이지
	   @RequestMapping(value="/register/registerResult")
	   public String registerResult(@RequestParam("id") String id,
			   						@RequestParam("insertResult") String insertResult,
	                                HttpSession session,
	                                Model model) {
	      logger.info("RegisterController :: registerResult() :: insertResult= " + insertResult);
	      model.addAttribute("insertResult", insertResult);
	      model.addAttribute("send_id", id);
	      if(insertResult.equals("1")) {
	         // 가입 후 로그인 상태 유지
	         session.setAttribute("userId", id + "@tymail.com");
	         logger.info("RegisterController :: registerResult() :: id= " + session.getAttribute("userId"));
	      }
	      return "/register/registerResult";
	   }
	
}
