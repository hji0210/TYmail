package com.example.demo.login;

import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginService loginService;
	
	// ========== login ==========
	// login 페이지 진입
	@RequestMapping(value="/login")
	public String loginForm(
	      Model model,
	      HttpSession session,
	      HttpServletRequest request,
	      @CookieValue(value="savedId", required=false) Cookie idSaveCookie) {
	   // 이미 로그인한 상태인 경우 돌려보내기
	   String userId = (String) session.getAttribute("userId");
	   String referer = request.getHeader("Referer");
	   if(userId != null && referer != null) {
	      request.setAttribute("message", "이미 로그인한 상태입니다.");
	      request.setAttribute("url", referer);
	      return "/login/alert";
	   } else if(userId != null && referer == null) {
	      request.setAttribute("message", "이미 로그인한 상태입니다.(url)");
	      request.setAttribute("url", "/mypage");
	      return "/login/alert";
	   }
	   // id 저장 cookie 있는지 검사
	   if(idSaveCookie != null) {
	      model.addAttribute("savedId", idSaveCookie.getValue());
	      model.addAttribute("checked", "checked");
	   }
	   return "/login/loginForm";
	}

	
	// login 입력값 검사
	@ResponseBody
	@RequestMapping(value="/login/loginCheck")
	public String loginCheck(
			@RequestParam HashMap<String, String> paramMap) {
		logger.info("LoginController :: loginCheck() :: paramMap = " + paramMap);
		// 입력 계정정보에 해당하는 id가 있는지 DB에 요청
		String returnId = loginService.loginCheck(paramMap);
		if(paramMap.get("idInput").equals(returnId)) {	// 입력id와 리턴id가 같으면
			logger.info("LoginController :: loginCheck() :: result = " + returnId);
			return "1";
		} else {	// 다르면
			logger.info("LoginController :: loginCheck() :: result = ''");
			return "0";
		}
	}
	
	// login 결과
	@RequestMapping(value="/login/loginResult")
	public String loginResult(
			@RequestParam("id") String id,
			@RequestParam(value="idSave", required=false) String idSave,
			HttpSession session,
			HttpServletResponse response) {
		logger.info("LoginController :: loginResult() :: id = " + id);
		logger.info("LoginController :: loginResult() :: idSave = " + idSave);
		// id 저장
		if(idSave == null) {
			// cookie 삭제
			Cookie idSaveCookie = new Cookie("savedId", "");
			idSaveCookie.setPath("/");
			idSaveCookie.setMaxAge(0);
			response.addCookie(idSaveCookie);
		} else if(idSave.equals("Y")) {
			// cookie 추가
			Cookie idSaveCookie = new Cookie("savedId", id);
			idSaveCookie.setPath("/");
			idSaveCookie.setMaxAge(60*60*24);
			response.addCookie(idSaveCookie);
		}
		// session에 로그인한 사용자 id 저장
		session.setAttribute("userId", id);	// 변수명 합의 필요 <------------------------
		return "redirect:/home/index";	// index 페이지 연결 필요 <--------------------
	}
	
	// ========== id / pw 찾기 ==========
	   // 페이지 진입
	   @RequestMapping(value="/login/idPwSearch")
	   public String idPwSearch(
	         HttpSession session,
	         HttpServletRequest request) {
	      // 이미 로그인한 상태인 경우 돌려보내기
	      String userId = (String) session.getAttribute("userId");
	      String referer = request.getHeader("Referer");
	      if(userId != null && referer != null) {
	         request.setAttribute("message", "이미 로그인한 상태입니다.");
	         request.setAttribute("url", referer);
	         return "/login/alert";
	      } else if(userId != null && referer == null) {   // url 직접 쳐서 진입한 경우
	         request.setAttribute("message", "이미 로그인한 상태입니다.(url)");
	         request.setAttribute("url", "/mypage");
	         return "/login/alert";
	      }
	      return "/login/idPwSearch";
	   }

	
	// ----- id 찾기 -----
	// 이름, 전화번호를 받아서 id 리턴
	@ResponseBody
	@RequestMapping(value="/login/idSearch")
	public HashMap<String, String> idSearch(
			@RequestParam HashMap<String, String> paramMap) {
		logger.info("LoginController :: idSearch() :: paramMap = " + paramMap);
		// DB query 결과를 담을 hashmap
		HashMap<String, String> resultMap = new HashMap<String, String>();
		// 입력값으로 DB에 요청
		String returnId = loginService.idSearch(paramMap);
		if(returnId == null) {	// 해당하는 계정 id가 없으면
			logger.info("LoginController :: idSearch() :: result Id = ''");
			resultMap.put("result", "0");
		} else {	// 있으면
			logger.info("LoginController :: idSearch() :: result Id = " + returnId);
			resultMap.put("result", "1");
			resultMap.put("resultName", paramMap.get("nameInput"));
			resultMap.put("resultId", returnId);
		}
		return resultMap;
	}
	
	// ----- pw 찾기 -----
	// id, 이름, 전화번호를 받아서 찾기 결과값 리턴
	@ResponseBody
	@RequestMapping(value="/login/pwSearch")
	public String pwSearch(
			@RequestParam HashMap<String, String> paramMap) {
		logger.info("LoginController :: pwSearch() :: paramMap = " + paramMap);
		// 입력값으로 DB에 요청 
		String returnId = loginService.pwSearch(paramMap);
		if(returnId == null) {	// 해당하는 계정 id가 없으면
			logger.info("LoginController :: pwSearch() :: result = '0'");
			return "0";
		} else {	// 있으면
			logger.info("LoginController :: pwSearch() :: result = '1'");
			return "1";
		}
	}
	
	// ----- pw 재설정 -----
	// id, pw를 받아서 update 결과값 리턴
	@ResponseBody
	@RequestMapping(value="/login/pwReset")
	public String pwReset(
			@RequestParam HashMap<String, String> paramMap) {
		logger.info("LoginController :: pwReset() :: paramMap = " + paramMap);
		// 입력값으로 DB에 update 요청
		int resetResult = loginService.pwReset(paramMap);
		logger.info("LoginController :: pwReset() :: result = " + resetResult);
		return resetResult + "";
	}
	
}
