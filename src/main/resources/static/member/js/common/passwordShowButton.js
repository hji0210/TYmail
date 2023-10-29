// 비밀번호 보이기 버튼 클릭 시
$(".passwordShowButton").click(function() {
	$(this).prev("input").toggleClass("active");
	if($(this).prev("input").hasClass("active")) {
		$(this).attr("class", "passwordShowButton bi bi-eye-slash-fill")
		.attr("title", "비밀번호 숨기기")
		.prev("input").attr("type", "text");
	} else {
		$(this).attr("class", "passwordShowButton bi bi-eye-fill")
		.attr("title", "비밀번호 보이기")
		.prev("input").attr("type", "password");
	}
});