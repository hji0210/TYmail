<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Contact - Sailor Bootstrap Template</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="/assets/img/favicon.png" rel="icon">
  <link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="/assets/vendor/animate.css/animate.min.css" rel="stylesheet">
  <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="/assets/css/style.css" rel="stylesheet">
  <!-- Custom CSS File -->
  <link href="/member/css/memberStyle.css" rel="stylesheet">
  <!-- =======================================================
  * Template Name: Sailor
  * Updated: Jul 27 2023 with Bootstrap v5.3.1
  * Template URL: https://bootstrapmade.com/sailor-free-bootstrap-theme/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>

  <!-- ======= Header ======= -->
  <header id="header" class="fixed-top d-flex align-items-center">
    <div class="container d-flex align-items-center">

      <h1 class="logo me-auto"><a href="/home/index">TY Mail</a></h1>
      
      <c:choose> 
		<c:when test="${empty send_id}">
			<a href="/login">로그인</a>
		</c:when> 
		<c:otherwise>
			<a href="/login" onclick="return logout();">로그아웃</a>
		</c:otherwise> 
	  </c:choose> 

      <nav id="navbar" class="navbar">
        <ul>
          <li><a href="/home/index">Home</a></li>
		  <li class="dropdown"><a href="/receive/list?page=1"><span>받은 메일함</span> <i class="bi bi-chevron-down"></i></a>
            <ul>
              <li><a href="/smart/promotion?page=1">프로모션</a></li>
              <li><a href="/smart/charge?page=1">청구/결제</a></li>
              <li><a href="/smart/sns?page=1">SNS</a></li>
            </ul>
          </li> 
          <li><a href="/send/sendList">보낸 메일함</a></li>  
          <li><a href="/storage/storageList">임시 보관함</a></li>
          <li><a href="/like/list">즐겨찾기</a></li>
          <li><a href="/spam/list">스팸 메일함</a></li>
          <li><a href="/trash/list">휴지통</a></li>
          <li><a href="/mypage">마이페이지</a></li>
          <li><a href="/send/sendForm" class="getstarted">Send E-mail</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav><!-- .navbar -->

    </div>
  </header><!-- End Header -->

  <main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs">
      <div class="container">

        <div class="d-flex justify-content-between align-items-center">
          <h2>아이디 • 비밀번호 찾기</h2>
          <ol>
            <li><a href="#">Home</a></li>
            <li><a href="/login">로그인</a></li>
            <li>아이디·비밀번호 찾기</li>
          </ol>
        </div>

      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Id / Pw Search Section ======= -->
    <section id="idPwSearch" class="idPwSearch member" style="padding-top: 30px;">
      <div class="container">
        <div class="row row-cols-2 justify-content-center">
          <div class="col-4">
            <button type="button" id="idSearchButton" class="btn btn-lg btn-block unselect">아이디 찾기</button>
          </div>
          <div class="col-4">
            <button type="button" id="pwSearchButton" class="btn btn-lg btn-block unselect">비밀번호 찾기</button>
          </div>
        </div>
      <!-- id 찾기 -->
        <div id="idSearch" class="row g-3 justify-content-center" style="display: none;">
          <form name="idSearchForm" method="post" onsubmit="return idSearchSubmit();" class="idPwSearch member-form row g-3 justify-content-center">
            <div class="col-7">
              <label for="idSearchName" class="form-label">성명</label>
              <input type="text" name="name" class="form-control" id="idSearchName" placeholder="성명" required>
            </div>
            <div class="col-7">
              <label for="idSearchTel" class="form-label">전화번호</label>
              <input type="tel" name="tel" class="form-control" id="idSearchTel" placeholder="010xxxxxxxx" required>
              <span id="wrongIdSearchInputMessage"></span><!-- 입력값이 틀렸을 때 메시지 -->
            </div>
            <div class="col-7">
              <button type="submit">찾기</button>
            </div>
          </form>
          <!-- id 찾기 결과 -->
          <div id="idSearchResult" class="col-6" style="display: none;">
            <table class="table">
              <tr>
                <th scope="row">성명</th>
                <td id="idResultName" class="text-end"></td>
              </tr>
              <tr>
                <th>아이디</th>
                <td id="idResultId" class="text-end"></td>
              </tr>
            </table>
          </div>
          <div class="col-7 text-end">
            <div class="member-button row row-cols-2">
              <div class="col">
                <a href="/login"><button type="button" class="btn btn-block">로그인</button></a>
              </div>
              <div class="col">
                <a href="/register"><button type="button" class="btn btn-block">회원가입</button></a>
              </div>
            </div>
          </div>
        </div>
      <!-- pw 찾기 -->
        <div id="pwSearch" class="row g-3 justify-content-center" style="display: none;">
          <form name="pwSearchForm" action="<%--/login/idPwSearchResult--%>" method="post" onsubmit="return pwSearchSubmit();" class="idPwSearch member-form row g-3 justify-content-center">
            <div class="col-7">
              <label for="pwSearchId" class="form-label">아이디</label>
              <input type="text" name="id" class="form-control" id="pwSearchId" placeholder="이메일 주소" required>
            </div>
            <div class="col-7">
              <label for="pwSearchName" class="form-label">성명</label>
              <input type="text" name="name" class="form-control" id="pwSearchName" placeholder="성명" required>
            </div>
            <div class="col-7">
              <label for="pwSearchTel" class="form-label">전화번호</label>
              <input type="tel" name="tel" class="form-control" id="pwSearchTel" placeholder="010xxxxxxxx" required>
              <span id="wrongPwSearchInputMessage"></span><!-- 입력값이 틀렸을 때 메시지 -->
            </div>
            <div class="col-7">
              <button type="submit">찾기</button>
            </div>
          </form>
          <!-- pw 찾기 결과 -->
          <div id="pwResult" class="col-6" style="display: none;">
            <table class="table">
              <tr>
                <th>아이디</th>
                <td id="pwResultId" class="text-end"></td>
              </tr>
              <tr>
                <th>성명</th>
                <td id="pwResultName" class="text-end"></td>
              </tr>
            </table>
          </div>
          <div class="col-7 text-end">
            <div class="member-button row row-cols-2">
              <div class="col">
                <a href="/login"><button type="button" class="btn btn-block">로그인</button></a>
              </div>
              <div class="col">
                <a href="/register"><button type="button" class="btn btn-block">회원가입</button></a>
              </div>
            </div>
          </div>
        <!-- 비밀번호 재설정 -->
          <div id="pwReset" class="col-7" style="display: none;">
            <br>
            <h3 style="margin-bottom: 15px;">비밀번호 재설정</h3>
            <form name="pwResetForm" method="post" onsubmit="return pwResetSubmit();" class="member-form row g-3 justify-content-center">
              <!-- <input type="hidden" id="pwResetId"> -->
              <div class="col-12">
                <label for="inputPassword" class="form-label">비밀번호</label>
                <div class="inputPassword">
                <input type="password" class="form-control inputPassword" id="inputPassword" name="password" placeholder="알파벳, 숫자, 특수문자 포함 8~20자" maxlength="20" required>
                <i class="passwordShowButton bi bi-eye-fill" title="비밀번호 보이기"></i>
              </div>
			    <span class="pwMessage" id="pwMessage"></span>
			    <input type="hidden" name="pwCheck" value="N">
              </div>
              <div class="col-12">
                <label for="inputPasswordRepeat" class="form-label">비밀번호 확인</label>
                <div class="inputPassword">
                <input type="password" class="form-control inputPassword" id="inputPasswordRepeat" name="passwordRepeat" placeholder="알파벳, 숫자, 특수문자 포함 8~20자" maxlength="20" required>
                <i class="passwordShowButton bi bi-eye-fill" title="비밀번호 보이기"></i>
              </div>
                <span class="pwMessage" id="pwRepeatMessage"></span>
                <input type="hidden" name="pwRepeatCheck" value="N">
              </div>
              <div class="col text-end">
                <span id="pwResetMessage"></span><!-- 재설정 메시지 -->
                <button type="submit" id="pwResetButton">재설정</button>
              </div>
            </form>
          </div>
        </div>
        <br>
        <div class="row justify-content-center">
        </div>
        <div class="row justify-content-center">
        </div>
      </div>
    </section><!-- End Id / Pw Search Section -->
  	
  </main><!-- End #main -->

<!-- ======= Footer ======= -->
  <footer id="footer">
    <div class="footer-top">
      <div class="container">
        <div class="row">

          <div class="col-lg-3 col-md-6">
            <div class="footer-info">
              <h3>TY Mail</h3>
              <p>
                대한민국 서울특별시 <br>
                성동구 아차산로 113, 2층<br><br>
                <strong>Phone:</strong> 070-4281-6688 <br>
                <strong>Email:</strong> ty@TYmail.com<br>
              </p>
              <div class="social-links mt-3">
                <a href="#" class="twitter"><i class="bx bxl-twitter"></i></a>
                <a href="#" class="facebook"><i class="bx bxl-facebook"></i></a>
                <a href="#" class="instagram"><i class="bx bxl-instagram"></i></a>
              </div>
            </div>
          </div>

          <div class="col-lg-2 col-md-6 footer-links">
            <h4>바로가기</h4>
            <ul>
              <li><i class="bx bx-chevron-right"></i> <a href="/home/index">Home</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="/receive/list?page=1">받은 메일함</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="/storage/storageList">임시 보관함</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="/mypage">마이페이지</a></li>
            </ul>
          </div>

          <div class="col-lg-6 col-md-6 footer-newsletter">
            <h4>Complaints or Compliments</h4>
            <p>TY Mail을 이용하며 발생한 불편사항 또는 좋았던 점을 보내주세요.</p>
            <form action="/send/sendCC" method="post">
              <input type="text" name="content">
              <input type="submit" value="Send">
            </form>

          </div>
        </div>
      </div>
    </div>

    <div class="container">
      <div class="copyright">
        &copy; Copyright <strong><span>Sailor</span></strong>. All Rights Reserved
      </div>
      <div class="credits">
        <!-- All the links in the footer should remain intact. -->
        <!-- You can delete the links only if you purchased the pro version. -->
        <!-- Licensing information: https://bootstrapmade.com/license/ -->
        <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/sailor-free-bootstrap-theme/ -->
        Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
      </div>
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="/assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="/assets/vendor/waypoints/noframework.waypoints.js"></script>
  <script src="/assets/vendor/php-email-form/validate.js"></script>
  <!-- Template Main JS File -->
  <script src="/assets/js/main.js"></script>
  <!-- Custom JS File -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
  <script src="/member/js/common/showMsg.js"></script>
  <script src="/member/js/login/idPwSearch.js"></script>
  <script src="/member/js/common/passwordCheck.js"></script>
  <script src="/member/js/common/passwordShowButton.js"></script>
</body>

</html>