// ===== password 검사 =====
// pw 검사 플래그
let pwFlag = false;
// pw 형태 regex
const pwRegex = /^.*(?=.{8,20})(?=.*[\d])(?=.*[a-zA-Z])(?=.*[`~!@#$%^&*()\-_=+]).*$/;

// pw 검사 함수
const checkPw = () => {
	// 이미 검사 끝났으면 바로 리턴
	if (pwFlag) return true;

	// pw input 입력값 가져오기
	let pwInputValue = document.querySelector("#inputPassword").value;
	//console.log(pwInputValue);
	// 메시지 출력 부분
	let pwMessage = $("#pwMessage");
	//console.log(pwMessage);

	// 입력값 없을 때
	if (pwInputValue == "") {
		console.log("password input = ''")
		showErrorMsg(pwMessage, "필수 정보입니다.");
		return false;
	}
	
	// regex와 같은지 검사
	if (pwInputValue.match(pwRegex)) {	// 같으면
		console.log("pw input = appropriate")
		showSuccessMsg(pwMessage, "");	// 뭐라고 띄우지?????????????
		// hidden input value 설정
		$("input[name=pwCheck]").attr("value", "Y");
		console.log("pwCheck = ", $("input[name=pwCheck]").val());
		// 플래그 값 수정
		pwFlag = true;
		return true;
	} else {	// 다르면
		console.log("pw input = not appropriate")
		showErrorMsg(pwMessage, "비밀번호 형식에 맞게 입력해주세요.");
		// hidden input value 설정
		$("input[name=pwCheck]").attr("value", "N");
		console.log("pwCheck = ", $("input[name=pwCheck]").val());
		return false;
	}
}

// ===== password repeat 검사 =====
// pw repeat 검사 플래그
let pwRepeatFlag = false;

// pw repeat 검사 함수
const checkPwRepeat = () => {
	// pw input 입력값 가져오기
	let pwInputValue = $("input[name=password]").val();
	// pw repeat input 입력값 가져오기
	let pwRepeatValue = $("input[name=passwordRepeat]").val();
	// 메시지 출력 부분
	let pwRepeatMessage = $("#pwRepeatMessage");

	// 입력값 없을 때
	if (pwRepeatValue == "") {
		console.log("password repeat input = ''")
		showErrorMsg(pwRepeatMessage, "필수 정보입니다.");
		return false;
	}
	
	// pw와 같은지 검사
	if (pwRepeatValue === pwInputValue) {	// 같으면
		console.log("pw repeat = ok")
		showSuccessMsg(pwRepeatMessage, "");	// 뭐라고 띄우지?????????????
		// hidden input value 설정
		$("input[name=pwRepeatCheck]").attr("value", "Y");
		//console.log("pwRepeatCheck = ", $("input[name=pwRepeatCheck]").val());
		// 플래그 값 수정
		pwRepeatFlag = true;
		return true;
	} else {	// 다르면
		console.log("pw repeat = different")
		showErrorMsg(pwRepeatMessage, "비밀번호를 똑같이 입력해주세요.");
		// hidden input value 설정
		$("input[name=pwRepeatCheck]").attr("value", "N");
		//console.log("pwRepeatCheck = ", $("input[name=pwRepeatCheck]").val());
		return false;
	}
}

// ===== event 연결 =====
// pw input 입력 시 중복 검사 실행
$("#inputPassword").keyup(function() {
	pwFlag = false;
	checkPw();
	
	let pwRepeatMessage = document.querySelector("#pwRepeatMessage");
	//console.log(pwRepeatMessage);
	if(pwRepeatMessage == null) {
		return;
	}
	// pw repeat 성공 후 pw input 재입력 시 재검사
	if(pwRepeatFlag) {
		pwRepeatFlag = false;
		checkPwRepeat();
	} else {
		checkPwRepeat();
	}
});

// pw repeat 입력 시 중복 검사 실행
$("#inputPasswordRepeat").keyup(function() {
	pwRepeatFlagFlag = false;
	checkPwRepeat();
});
