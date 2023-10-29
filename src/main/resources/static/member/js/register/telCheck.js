// ===== tel 중복 검사 =====
// tel 검사 플래그
let telFlag = false;
// tel regex
const telRegex = /^010[\d]{8}$/;

// tel 검사 함수
const checkTel = () => {
	// 이미 검사 끝났으면 바로 리턴
	if (telFlag) return true;
	
	// tel input 입력값 가져오기
	let telInputValue = $("input[name=tel]").val();
	// 메시지 출력 부분
	let telMessage = $("#telMessage");
	//console.log(telMessage);
	
	// 입력값 없을 때
	if (telInputValue == "") {
		console.log("tel input = ''")
		showErrorMsg(telMessage, "필수 정보입니다.");
		return false;
	}
	
	// 입력값 형식 충족하지 못했을 때
	if(!telInputValue.match(telRegex)) {
		showErrorMsg(telMessage, "알맞은 형식으로 입력해주세요.");
		return false;
	}
	
	// Controller에 입력값 전달
	$.ajax({
		url: "/register/telCheck",
		type: "post",
		data: {
			telInput: telInputValue
		},
		success: function(result) {
			// result = 중복 있으면 0, 없으면 1
			//console.log('telCheck result = ', result);
			if (result === '1') {
				console.log("tel input = not duplicate")
				showSuccessMsg(telMessage, "사용 가능한 전화번호입니다.");
				// hidden input value 설정
				$("input[name=telDuplication]").attr("value", "Y");
				//console.log("telDuplication value= ", $("input[name=telDuplication]").val());
				// 플래그 값 수정
				telFlag = true;
				return true;
			} else {
				console.log("tel input = duplicate")
				showErrorMsg(telMessage, "중복된 전화번호입니다.");
				// hidden input value 설정
				$("input[name=telDuplication]").attr("value", "N");
				//console.log("telDuplication value= ", $("input[name=telDuplication]").val());
				return false;
			}
		},
		error: function() {
			alert("서버 요청 실패");
		}
	});
}

// tel input 입력 시 중복 검사 실행
$("input[name=tel]").keyup(function() {
	telFlag = false;
	checkTel();
});
