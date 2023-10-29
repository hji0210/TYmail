package com.example.demo.mypage;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.login.LoginService;

@Controller
public class MyPageController {
	
	private static final Logger logger = LoggerFactory.getLogger(MyPageController.class);
	// 로그인한 사용자 id
	private String userId;
	
	@Autowired
	MyPageService myPageService;
	
	@Autowired
	LoginService loginService;
	
	   // 마이페이지 진입
	   @RequestMapping(value="/mypage")
	   public String myPageIndex(HttpSession session, Model model) {
	      this.userId = (String) session.getAttribute("userId");
	      logger.info("MyPageController :: myPageIndex :: userId = " + userId);
	      // 로그인하지 않은 경우 로그인 창으로
	      if(userId == null) {
	         System.out.println("로그아웃 상태");
	         model.addAttribute("message", "로그인이 필요합니다.");
	         model.addAttribute("url", "/login");
	         return "/login/alert";
	      }
	      // 로그인 상태인 경우 회원정보 query
	      HashMap<String, String> resultMap = myPageService.myPageIndex(userId);
	      String tel = resultMap.get("TEL");
	      resultMap.put("TEL", tel.replaceAll("(\\d{3})(\\d{4})(\\d{4})", "$1-$2-$3"));
	      logger.info("MyPageController :: myPageIndex :: resultMap = " + resultMap);
	      model.addAttribute("userInfo", resultMap);
	      model.addAttribute("send_id", this.userId);
	      return "/mypage/mypage";
	   }
	
	// ---------- 비밀번호 검사 ----------
	@ResponseBody
	@RequestMapping(value="/mypage/passwordCheck")
	public String passwordCheck(
			@RequestParam("inputPassword") String inputPassword) {
		HashMap<String, String> inputMap = new HashMap<>();
		inputMap.put("idInput", userId);
		inputMap.put("pwInput", inputPassword);
		String resultId = loginService.loginCheck(inputMap);
		logger.info("MyPageController :: passwordCheck() :: resultId = " + resultId);
		if(resultId == null) {	// 없으면
			return "0";
		} else if(resultId.equals(userId)) {	// 같으면
			return "1";
		} else {	// 다르면
			return "0";
		}
	}
	
	// ========== 회원정보 수정 ==========
	// 수정 페이지 진입
	@RequestMapping(value="/mypage/modify")
	public String myPageUpdate(Model model) {
		logger.info("MyPageController :: myPageUpdate :: userId = " + userId);
		HashMap<String, String> resultMap = myPageService.myPageIndex(userId);
		logger.info("MyPageController :: myPageUpdate :: resultMap = " + resultMap);
		model.addAttribute("userInfo", resultMap);
		model.addAttribute("send_id", this.userId);
		return "/mypage/update";
	}
	
	// 수정 결과
	@RequestMapping(value="/mypage/modifyResult")
	public String myPageUpdateResult(
			Model model,
			@RequestParam HashMap<String, String> paramMap) {
		logger.info("MyPageController :: myPageUpdate :: paramMap = " + paramMap);
		int updateResult = myPageService.myPageUpdate(paramMap);
		model.addAttribute("updateResult", updateResult);
		model.addAttribute("send_id", this.userId);
		return "/mypage/updateResult";
	}
	
	// ========== 탈퇴 ==========
	// 탈퇴 페이지 진입
	@RequestMapping(value="/mypage/leave")
	public String myPageDelete() {
		return "/mypage/delete";
	}
	
	   // 탈퇴 요청
	   @ResponseBody
	   @RequestMapping(value="/mypage/leaveDelete")
	   public String myPageLeaveDelete(
	               HttpSession session) {
	      HashMap<String, String> deleteMap = new HashMap<>();
	      deleteMap.put("id", (String) session.getAttribute("userId"));
	      deleteMap.put("deleteResult", null);   // 실행 결과를 받을 변수
	      myPageService.myPageDelete(deleteMap);   // query 실행
	      String deleteResult = deleteMap.get("deleteResult");   // 실행 결과
	      logger.info("MyPageController :: myPageLeaveDelete() :: deleteResult = " + deleteResult);
	      return deleteResult + "";
	   }
	   /*
	     결과 페이지에서 새로고침 시 query가 중복 수행되지 않도록
	     요청과 페이지 이동 메소드 분리
	   */
	   // 탈퇴 결과 페이지
	   @RequestMapping(value="/mypage/leaveResult")
	   public String myPageLeaveResult(
	         @RequestParam("deleteResult") String deleteResult,
	                              HttpSession session,
	                                    Model model) {
	      logger.info("MyPageController :: myPageLeaveResult() :: deleteResult = " + deleteResult);
	      if(Integer.parseInt(deleteResult) >= 1) {   // 실행 성공 시
	         // 세션, 필드 변수 삭제
	         session.removeAttribute("userId");
	         this.userId = null;
	      }
	      model.addAttribute("deleteResult", Integer.parseInt(deleteResult));
	      return "/mypage/deleteResult";
	   }

	
}
