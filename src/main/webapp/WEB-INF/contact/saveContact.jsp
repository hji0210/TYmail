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

<title>saveContact</title>

	<script type="text/javascript">
	    function closeSaveContact() {
            window.close()
	    }
    </script>
    
	<style>
	  body { text-align: center; }
	  table { width: 30%; border: 1px solid #444444; border-collapse: collapse; }
	  th, td { border: 1px solid #444444; } 
	</style>
	
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
	
  <!-- ======= Contact Section ======= -->
    <section id="contact" class="contact">
      <div class="container">
        <div class="row mt-5">
          <div class="col-lg-8 mt-3 mt-lg-0">

              <div class="row">
                <div class="col-md-6 form-group">
                <form action="/contact/saveContactAct" method="post" class="php-email-form">
                  이름
				  <input type="text" name="name" class="form-control" placeholder="name" required>
				  이메일 주소
				  <input type="text" name="contact_email" class="form-control" placeholder="E-mail address" required>
				  <br><input type="submit" value="주소록 저장하기">
				  <button type="button" onclick="closeSaveContact()">주소록 닫기</button>
				</form>
                </div>
               </div>
	  
          </div>
        </div>
      </div>
    </section><!-- End Contact Section -->
	
  </main><!-- End #main -->

</body>
</html>