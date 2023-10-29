function logout() {
	$.ajax({
		url: "/logout",
		method: "get",
		success: function(result) {
			if(result === '1') {
				return false;
			} else if(result === '0') {
				return false;
			}
		},
		error: function() {
			alert("서버 요청 실패!");
			return false;
		}
	});
}