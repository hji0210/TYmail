<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<script>
	window.location.reload();
	let msg = "${message}";
	let url = "${url}";
	window.alert(msg);
	location.href = url;
</script>
</body>
</html>