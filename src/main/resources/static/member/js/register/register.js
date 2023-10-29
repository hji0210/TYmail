// ===== 가입 버튼 클릭 시 유효성 검사 함수 =====
function formSubmit() {
	// id 중복 검사 여부
	let idDuplication = $("input[name=idDuplication]").val();
	if (idDuplication === 'N') {
		console.log("formSubmit :: id uncheck");
		$("input[name=id]").focus();
		return false;
	}
	// pw 검사 여부
	let pwCheck = $("input[name=pwCheck]").val();
	if (pwCheck === 'N') {
		console.log("formSubmit :: pw uncheck");
		$("input[name=password]").focus();
		return false;
	}
	// pw repeat 검사 여부
	let pwRepeatCheck = $("input[name=pwRepeatCheck]").val();
	if (pwRepeatCheck === 'N') {
		console.log("formSubmit :: pw repeat uncheck");
		$("input[name=passwordRepeat]").focus();
		return false;
	}
	// tel 중복 검사 여부
	let telDuplication = $("input[name=telDuplication]").val();
	if (telDuplication === 'N') {
		console.log("formSubmit :: tel uncheck");
		$("input[name=tel]").focus();
		return false;
	}
	
	$.ajax({
      url: "/register/registerInsert",
      method: 'post',
      async: false,
      data: {
         id: $("input[name=id]").val(),
         password: $("input[name=password]").val(),
         name: $("input[name=name]").val(),
         tel: $("input[name=tel]").val()
      },
      success: function(insertResult) {
         $("input[type=hidden][name=insertResult]").val(insertResult);
         return true;
      },
      error: function() {
         alert("서버 요청 실패!");
           return false;
      }
   });
	
}