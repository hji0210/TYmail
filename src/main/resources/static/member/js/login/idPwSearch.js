// id 찾기 버튼 눌렀을 때
$("#idSearchButton").click(function() {
	// id 찾기 버튼 액티브 상태 추가
	$(this).removeClass("unselect");
	$(this).addClass("selected");
	// pw 찾기 버튼 액티브 상태 제거
	$("#pwSearchButton").removeClass("selected");
	$("#pwSearchButton").addClass("unselect");
	// id 찾기 부분 출력
	$("#idSearch")[0].style.display = null;
	// pw 찾기 부분 숨기기
	$("#pwSearch")[0].style.display = "none";
	//$("#pwReset")[0].style.display = "none";
});

// 비밀번호 찾기 버튼 눌렀을 때
$("#pwSearchButton").click(function() {
	// pw 찾기 버튼 액티브 상태 추가
	$(this).removeClass("unselect");
	$(this).addClass("selected");
	// id 찾기 버튼 액티브 상태 제거
	$("#idSearchButton").removeClass("selected");
	$("#idSearchButton").addClass("unselect");
	// pw 찾기 부분 출력
	$("#pwSearch")[0].style.display = null;
	// id 찾기 부분 숨기기
	$("#idSearch")[0].style.display = "none";
});

// id 찾기 함수
function idSearchSubmit() {
	// 입력값
	let inputName = $("#idSearchName").val();
	let inputTel = $("#idSearchTel").val();
	// 에러 메시지 부분
	let wrongIdSearchInputMessage = $("#wrongIdSearchInputMessage");
	// Controller에 요청
	$.ajax({
		url: "/login/idSearch",
		type: "post",
		async: false,	// 비동기 처리를 위해
		data: {
			nameInput: inputName,
			telInput: inputTel
		},
		dataType:'json',
		success: function(resultMap) {
			// result = 틀렸으면 "", 맞으면 id
			//console.log("idSearchSubmit() :: idSearch result = ", resultMap.result);
			if (resultMap.result === "1") {
				console.log("idSearchSubmit() :: input = ok");
				// 이미 존재하는 에러메시지 지우기
				showSuccessMsg(wrongIdSearchInputMessage, "");
				// 찾기 결과 출력
				$("#idSearchResult")[0].style.display = null;
				$("#idResultName")[0].innerText = resultMap.resultName;
				$("#idResultId")[0].innerText = resultMap.resultId;
			} else if (resultMap.result === "0") {
				console.log("idSearchSubmit() :: input = wrong");
				// 이미 존재하는 찾기 결과 지우기
				$("#idSearchResult")[0].style.display = "none";
				$("#idResultName")[0].innerText = "";
				$("#idResultId")[0].innerText = "";
				// 에러 메시지 출력
				showErrorMsg(wrongIdSearchInputMessage, "존재하지 않는 회원입니다.");
			}
		},
		error: function() {
			alert("서버 요청 실패");
		}
	});
	// 현재 페이지 유지
	return false;
}

// pw 찾기 함수
function pwSearchSubmit() {
	// 입력값
	let inputId = $("#pwSearchId").val();
	let inputName = $("#pwSearchName").val();
	let inputTel = $("#pwSearchTel").val();
	// 에러 메시지 부분
	let wrongPwSearchInputMessage = $("#wrongPwSearchInputMessage");
	// pw 재설정 form 초기화
	pwResetInitialize();
	// Controller에 요청
	$.ajax({
		url: "/login/pwSearch",
		type: "post",
		async: false,	// 비동기 처리를 위해
		data: {
			idInput: inputId,
			nameInput: inputName,
			telInput: inputTel
		},
		success: function(result) {
			// result = 틀렸으면 0, 맞으면 1
			//console.log("pwSearchSubmit() :: pwSearch result = ", result);
			if (result === '1') {
				// 이미 존재하는 에러메시지 지우기
				showSuccessMsg(wrongPwSearchInputMessage, "");
				// 찾기 결과 출력
				console.log("pwSearchSubmit() :: input = ok");
				$("#pwResult")[0].style.display = null;
				$("#pwResultId")[0].innerText = inputId;
				$("#pwResultName")[0].innerText = inputName;
				// pw 재설정 부분 출력
				$("#pwReset")[0].style.display = null;
			} else if (result === '0') {
				console.log("pwSearchSubmit() :: input = wrong");
				// 이미 존재하는 찾기 결과 지우기
				$("#pwResult")[0].style.display = "none";
				$("#pwResultId")[0].innerText = "";
				$("#pwResultName")[0].innerText = "";
				// 에러 메시지 출력
				showErrorMsg(wrongPwSearchInputMessage, "존재하지 않는 회원입니다.");
				// pw 재설정 부분 숨기기
				$("#pwReset")[0].style.display = "none";
			}
		},
		error: function() {
			alert("서버 요청 실패");
		}
	});
	// 현재 페이지 유지
	return false;
}

// pw 재설정 함수
function pwResetSubmit() {
	// pw 검사 여부
	let pwCheck = $("input[name=pwCheck]").val();
	if (pwCheck === 'N') {
		console.log("pwResetSubmit :: pw uncheck");
		$("input[name=password]").focus();
		return false;
	}
	// pw repeat 검사 여부
	let pwRepeatCheck = $("input[name=pwRepeatCheck]").val();
	if (pwRepeatCheck === 'N') {
		console.log("pwResetSubmit :: pw repeat uncheck");
		$("input[name=passwordRepeat]").focus();
		return false;
	}
	// 검색한 id 값 가져오기
	let inputId = $("#pwResultId").text();
	//console.log(inputId);
	// 입력값 가져오기
	let inputPassword = $("#inputPassword").val();
	// 에러 메시지 부분
	let pwResetMessage = $("#pwResetMessage");
	// Controller에 요청
	$.ajax({
		url: "/login/pwReset",
		type: "post",
		async: false,	// 비동기 처리를 위해
		data: {
			idInput: inputId,
			pwInput: inputPassword
		},
		success: function(result) {
			// result = 성공했으면 1, 실패했으면 0
			console.log("pwResetSubmit() :: pwReset result = ", result);
			if (result === '1') {
				// 성공 메시지 출력
				showSuccessMsg(pwResetMessage, "비밀번호를 재설정하였습니다!");
				$("#pwResetButton")[0].style.display = "none";
			} else if (result === '0') {
				console.log("pwSearchSubmit() :: input = wrong");
				// 에러 메시지 출력
				showErrorMsg(pwResetMessage, "비밀번호 재설정 실패...");
			}
		},
		error: function() {
			alert("서버 요청 실패");
		}
	});
	// 현재 페이지 유지
	return false;
}

// pw 재설정 form 초기화 함수
function pwResetInitialize() {
	console.log("pw reset form init.")
	$(".inputPassword").val('');
	$("#pwMessage")[0].innerText = '';
	$("#pwRepeatMessage")[0].innerText = '';
	$("input[name=pwCheck]").attr("value", "N");
	$("input[name=pwRepeatCheck]").attr("value", "N");
	$(".passwordShowButton")
			.attr("class", "passwordShowButton bi bi-eye-fill")
			.attr("title", "비밀번호 보이기")
		.prev("input")
			.attr("type", "password")
			.removeClass("active");
	$("#pwResetMessage")[0].innerText = '';
	$("#pwResetButton")[0].style.display = null;
}