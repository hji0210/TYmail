// ===== 비밀번호 검사 =====
function passwordCheck() {
	// 비밀번호 입력값
	let inputPasswordValue = $("input[name=password]").val();
	
	// Controller에 요청
	$.ajax({
		url: "/mypage/passwordCheck",
		type: "post",
		data: {
			inputPassword: inputPasswordValue
		},
		success: function(result) {
			// result = 맞으면 1, 틀리면 0
			//console.log('passwordCheck result = ', result);
			if (result === '1') {
				console.log("passwordCheck() = ok")
				$(".passwordCheck").slideToggle();
				$(".mypageElement").slideToggle();
				return true;
			} else {
				console.log("passwordCheck() = X");
				//console.log(document.querySelector("#pwCheckMessage"));
				showErrorMsg($("#pwCheckMessage"), "틀린 비밀번호입니다.");
				return false;
			}
		},
		error: function() {
			alert("서버 요청 실패");
		}
	})
	return false;
}

// ========== 회원정보 수정 ==========
// ----- submit 버튼 클릭 -----
function updateSubmit() {
	// pw 검사 여부
	let pwCheck = $("input[name=pwCheck]").val();
	if (pwCheck === 'N') {
		console.log("updateSubmit :: pw uncheck");
		$("input[name=password]").focus();
		return false;
	}
	// tel 중복 검사 여부
	let telDuplication = $("input[name=telDuplication]").val();
	if (telDuplication === 'N') {
		console.log("updateSubmit :: tel uncheck");
		$("input[name=tel]").focus();
		return false;
	}
	return true;
}

$("input[type=hidden][name=pwCheck]").keypress(function() {
   $(this).val("N");
})

// ========== 탈퇴 ==========
function deleteSubmit() {
   $.ajax({
      url: "/mypage/leaveDelete",
      method: 'post',
      async: false,
      success: function(deleteResult) {
         $("input[type=hidden][name=deleteResult]").val(deleteResult);
         return true;
      },
      error: function() {
         alert("서버 요청 실패!");
      return false;
      }
   });
}
