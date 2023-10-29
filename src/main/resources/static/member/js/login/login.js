// ===== login 입력값 검사 =====
function formSubmit() {
	// input 입력값
	let inputId = $("#inputId").val();
	let inputPw = $("#inputPassword").val();
	// 에러 메시지 부분
	let wrongInputMessage = $("#wrongInputMessage");
	// ajax 요청 리턴값
	let returnResult = false;
	// Controller에 요청
	$.ajax({
		url: "/login/loginCheck",
		type: "post",
		async: false,	// 비동기 처리를 위해
		data: {
			idInput: inputId,
			pwInput: inputPw
		},
		success: function(result) {
			// result = 틀렸으면 0, 맞으면 1
			//console.log("formSubmit() :: loginCheck result = ", result);
			if (result === '1') {
				console.log("formSubmit() :: input = ok");
				returnResult = true;
			} else if (result === "0") {
				console.log("formSubmit() :: input = wrong");
				showErrorMsg(wrongInputMessage, "아이디나 비밀번호가 틀렸습니다.");
			}
		},
		error: function() {
			alert("서버 요청 실패");
		}
	});
	return returnResult;
};
