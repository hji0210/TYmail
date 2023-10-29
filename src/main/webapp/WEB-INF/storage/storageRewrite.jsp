<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="keywords">

<title>Send Storage Mail</title>

	<script type="text/javascript">
	        function openSelectContact() {
	        	let openWin;
	            window.name = "parentForm";
	            openWin = window.open("/contact/selectContact", "openSelectContact", "width=570, height=350, resizable = no, scrollbars = no");    
	        }
	        function openSaveContact() {
	        	let openWin;
	            window.name = "parentForm";
	            openWin = window.open("/contact/saveContact", "openSaveContact", "width=570, height=350, resizable = no, scrollbars = no");    
	        }
	        function openFile() {
	        	let openWin;
	            window.name = "parentForm";
	            openWin = window.open("/send/openFile", "openFile", "width=570, height=350, resizable = no, scrollbars = no");    
	        }
	</script>
	    
	<!-- Favicons -->
	<link href="/assets/img/favicon.png" rel="icon">
	<link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
	<!-- Google Fonts -->
	<link
		href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
		rel="stylesheet">
	
	<!-- Vendor CSS Files -->
	<link href="/assets/vendor/animate.css/animate.min.css" rel="stylesheet">
	<link href="/assets/vendor/bootstrap/css/bootstrap.min.css"
		rel="stylesheet">
	<link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css"
		rel="stylesheet">
	<link href="/assets/vendor/boxicons/css/boxicons.min.css"
		rel="stylesheet">
	<link href="/assets/vendor/glightbox/css/glightbox.min.css"
		rel="stylesheet">
	<link href="/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
	<link href="/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
	
	<!-- Template Main CSS File -->
	<link href="/assets/css/style.css" rel="stylesheet">
	
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
          
          <ol>
              <li>
                   <h2 onclick="location.href='/storage/storageList'" style="font-weight: normal"><i class="bi bi-chevron-compact-left"></i>임시 보관함</h2>
              </li>
          </ol>
          
          <ol>
            <li><a href="index.html">Home</a></li>
            <li>메일 작성</li>
          </ol>
        </div>

      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Contact Section ======= -->
    <section id="contact" class="contact">
      <div class="container">

        <div class="row mt-5">

          <div class="col-lg-8 mt-5 mt-lg-0">

            <form method="post">
              <div class="row">
                <div class="col-md-6 form-group">
                  받는 사람
                  <input type="text" name="receive_email" value="${storage.receive_email}" class="form-control" id="parent" placeholder="email address" required>
                </div>
                <div class="col-md-6 form-group mt-3 mt-md-0">
                  주소록
                  <br>
                  <button type="submit" onclick="openSelectContact()" >주소록 불러오기</button>
                  <button type="submit" onclick="openSaveContact()" >주소록 저장하기</button>
                </div>
              </div>
              
              <div class="row">
              <div class="col-md-6 form-group">
                첨부파일
                <input type="text" class="form-control" name="file_path" id="file" value="${storage.file_path}" placeholder="File" readonly>
              </div>
              </div>
              <div class="col-md-6 form-group mt-3 mt-md-0">
                <button type="button" onclick="openFile();">파일 첨부</button>
              </div>
              
              <div class="form-group mt-3">
                제목
                <input type="text" class="form-control" name="title" value="${storage.title}" id="subject" placeholder="Title" required>
              </div>
              <div class="form-group mt-3">
                내용
                <textarea class="form-control" name="content" rows="20" placeholder="Content" required>${storage.content}</textarea>
              </div>
              <div class="text-center">
	              <button type="submit" onclick="javascript: form.action='/send/sendStorageMail?storage_no=${storage.storage_no}'">메일 보내기</button>
	              <button type="submit" onclick="javascript: form.action='/storage/storageAgain?storage_no=${storage.storage_no}'" style="background-color:gray">저장하기</button>
              </div>
            </form>
	  
          </div>
        </div>
      </div>
    </section><!-- End Contact Section -->

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
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
  <script src="/home/index.js"></script>

  <!-- Template Main JS File -->
  <script src="/assets/js/main.js"></script>

</body>
</html>