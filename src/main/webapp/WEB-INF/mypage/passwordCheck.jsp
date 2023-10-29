<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form class="passwordCheck member-form row g-3 justify-content-center" onsubmit="return passwordCheck();">
  <div class="col-7">
    <label for="inputPassword" class="form-label">비밀번호를 입력하세요</label>
    <div class="inputPassword">
      <input type="password" name="password" class="form-control" id="inputPasswordCheck" placeholder="알파벳, 숫자, 특수문자 포함 8~20자" maxlength="20" required>
      <i class="passwordShowButton bi bi-eye-fill" title="비밀번호 보이기"></i>
      <span id="pwCheckMessage"></span>
    </div>
  </div>
  <div class="col-7">
    <button type="submit">확인</button>
  </div>
</form>