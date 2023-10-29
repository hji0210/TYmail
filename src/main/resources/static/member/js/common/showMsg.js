// ===== 유효성 검사 후 메시지 출력 =====
const showErrorMsg = (selected, message) => {
	//console.log(selected);
	selected.text(message);
	//selected[0].style.color = 'red';
	selected.css("color", "red");
}
const showSuccessMsg = (selected, message) => {
	//console.log(selected);
	//selected[0].innerText = message;
	selected.text(message);
	//selected[0].style.color = 'green';
	selected.css("color", "green");
}
