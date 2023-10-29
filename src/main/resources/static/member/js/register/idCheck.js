// ===== id 중복 검사 =====
// id 검사 플래그
let idFlag = false;

// id 검사 함수
const checkId = () => {
	// 이미 검사 끝났으면 바로 리턴
	if (idFlag) return true;

	// id input 입력값 가져오기
	let idInputValue = $("input[name=id]").val() + '@tymail.com';
	// 메시지 출력 부분
	let idMessage = $("#idMessage");
	//console.log(idMessage);
	// 입력값 없을 때
	if (idInputValue == "") {
		console.log("id input = ''")
		showErrorMsg(idMessage, "필수 정보입니다.");
		return false;
	}
	
	// Controller에 입력값 전달
	$.ajax({
		url: "/register/idCheck",
		type: "post",
		data: {
			idInput: idInputValue
		},
		success: function(result) {
			// result = 중복 있으면 0, 없으면 1
			//console.log('idCheck result = ', result);
			if (result === '1') {
				console.log("formSubmit() :: id input = not duplicate")
				showSuccessMsg(idMessage, "사용 가능한 아이디입니다.");
				// hidden input value 설정
				$("input[name=idDuplication]").attr("value", "Y");
				// console.log("idDuplication value= ", $("input[name=idDuplication]").val());
				// 플래그 값 수정
				idFlag = true;
				return true;
			} else {
				console.log("formSubmit() :: id input = duplicate")
				showErrorMsg(idMessage, "중복된 아이디입니다.");
				// hidden input value 설정
				$("input[name=idDuplication]").attr("value", "N");
				// console.log("idDuplication value= ", $("input[name=idDuplication]").val());
				return false;
			}
		},
		error: function() {
			alert("서버 요청 실패");
		}
	});
}

// id input 입력 시 중복 검사 실행
$("input[name=id]").keyup(function() {
	idFlag = false;
	checkId();
});
