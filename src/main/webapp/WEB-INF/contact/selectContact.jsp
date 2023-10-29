<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.ContactDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="keywords">

<title>selectContact</title>

    <script type="text/javascript">
    
	    function closeSelectContact() {
	        var arr = [];
	        var checkboxes = document.querySelectorAll('input[type="checkbox"]');
	        for (var i = 0; i < checkboxes.length; i++) {
	            if (checkboxes[i].checked) {
	            	arr.push(checkboxes[i].value);
	            }
	        }
	        opener.document.getElementById("parent").value = arr;
        	//opener.document.getElementById("parent").value = document.getElementById("cInput").value;
            window.close()
	    }
    </script>
    
	<style>
	  body { text-align: center; }
	  table { width: 30%; border: 1px solid #444444; border-collapse: collapse; }
	  th, td { border: 1px solid #444444; } 
	  
	  input{
		BORDER-BOTTOM: teal 1px solid;
		BORDER-LEFT: medium none;
		BORDER-RIGHT: medium none;
		BORDER-TOP: medium none;
		FONT-SIZE: 9pt
	  }
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
    
    <section id="specials" class="specials">
      <div class="container" data-aos="fade-up">
      
         <div class="col-lg-4">
              <div class="sidebar-item search-form">
                <form method="post">
                <br>
                  <select name="search_option">
                  	<option value="name">이름</option>
                  	<option value="contact_email">이메일 주소</option>
                  </select>
                  <input type="text" name="search_content">
                  <button type="submit" onclick= "javascript: form.action='/contact/selectContact"><i class="bi bi-search"></i></button>
                </form>
              </div><!-- End sidebar search formn-->
          </div><!-- End blog sidebar -->

		<br>
		<div class="row" data-aos="fade-up" data-aos-delay="100">
          <div class="col-lg-3">
          	<div class="row">
               <table style="margin-left: auto; margin-right: auto;">
				  <tr>
					<th><a class="nav-link active2 show" data-bs-toggle="tab">name</a></th>
					<th><a class="nav-link active2 show" data-bs-toggle="tab">contact_email</a></th>
					<th><a class="nav-link active2 show" data-bs-toggle="tab">check</a></th>
				  </tr>
				  <c:forEach items="${addressList}" var="addressList">
				    <tr>
					      <td><a class="nav-link" data-bs-toggle="tab">${addressList.name}</a></td> 
					      <td><a class="nav-link" data-bs-toggle="tab">${addressList.contact_email}</a></td>
					      <td><a class="nav-link" data-bs-toggle="tab"><input type="checkbox" name="emailList" id="child" value="${addressList.contact_email}"></a></td>
				    </tr>
				  </c:forEach>
				</table>
				<br><br>
				<button type="button" onclick="closeSelectContact();">선택</button> 
          	</div>
          </div>
		</div>
      </div>
   
    </section><!-- End Contact Section -->

  </main><!-- End #main -->

</body>
</html>