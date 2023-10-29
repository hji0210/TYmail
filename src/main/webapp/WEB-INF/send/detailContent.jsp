<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.MailDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="keywords">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<%-- AXIOS --%>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

<title>Mail Detail</title>


	<script type="text/javascript">
		function changeLikeChecked(imgElement) {
			
		    const no = imgElement.getAttribute("no");
		    let likeChecked = imgElement.getAttribute("like-status");
	
		    if(likeChecked === 'Y') {
		    	likeChecked = 'N';
		    } else {
		    	likeChecked = 'Y';
		    }
		    	updateLikeStatus(no, likeChecked);
		}
	
		    	// no, likeChecked 서버로 전달
		function updateLikeStatus(no, likeChecked) {
		    		
		    	axios.post('/like/likeMail',null,
		    	   {params:{no: no, like_checked: likeChecked}}
		    	   )
		    	   .then(() => {window.location.reload()})
		    	   .catch(() => {alert('실패')})
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
                   <h2 onclick="location.href='/send/sendList'" style="font-weight: normal"><i class="bi bi-chevron-compact-left"></i>보낸 메일함</h2>
              </li>
          </ol>
          
          <ol>
            <li><a href="index.html">Home</a></li>
            <li>보낸 메일함</li>
          </ol>
        </div>

      </div>
    </section><!-- End Breadcrumbs -->  
    
  <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container" data-aos="fade-up">
        <div class="row">
          <div class="col-lg-8 entries">  
             <div class="entry" style="background-color: #515d6a; color: white;">
             <div class="entry-content">
             <!-- ======= 필터 DropBox ======= -->
                <table>
                    <tr>
                      <td>
                         <form action="/receive/update/trash" method="post">
                              <input type="hidden" name="no" value="${detailContent.no}"><input type="hidden" name="filter" value="${filter}"><input type="hidden" name="sort" value="${sort}"><input type="hidden" name="category" value="${category}">
                              <input type="submit" value="삭제" style="color: white; border: none; background: transparent;">
                              <a href="/send/sendAgain?no=${detailContent.no}" style="color:yellow">전달</a>
                         </form>
                      </td>
                    </tr>
                </table>
              <!-- ======= END 필터 DropBox ======= -->
              </div>
          </div>
          <div class="blog-author">
            <div>            
              <br>
              <h4>
                     <c:choose>
                     <c:when test="${detailContent.like_checked eq 'Y'.charAt(0)}">
                          <i class="bi bi-star-fill"
                             style="padding-left: 5px; padding-bottom: 3px; font-size: 1.3rem; color: #58151c"
                             no = "${detailContent.no}"
                             like-status = "${detailContent.like_checked}"
                             onclick="changeLikeChecked(this);"></i>
                     </c:when>
                     <c:otherwise>
                          <i class="bi bi-star"
                             style="padding-left: 5px; padding-bottom: 3px; font-size: 1.3rem; color: #58151c"
                             no = "${detailContent.no}"
                             like-status = "${detailContent.like_checked}"
                             onclick="changeLikeChecked(this);"></i>
                      </c:otherwise>
                      </c:choose>              
              ${detailContent.title} 
              </h4>
              <br>
              <div class="entry-meta">
                <ul>
					<li class="d-flex align-items-center"><i class="bi bi-person"></i>&nbsp;받는사람&nbsp;|&nbsp;${detailContent.receive_email}</li>
					<li class="d-flex align-items-center"><i class="bi bi-person"></i>&nbsp;보낸사람&nbsp;|&nbsp;${detailContent.send_id}&lt;${detailContent.send_id}&gt;</li>
					<li class="d-flex align-items-center"><i class="bi bi-clock"></i>&nbsp;
		            	<h6 style="font-size: small; color: #51585e;">${detailContent.send_date}</h6>
				</ul>
              </div>
			  <hr style="color:gray;"><br>
              <div style="white-space:pre;" class="entry-content"> ${detailContent.content} <br><br></div>
              		<article class="entry entry-single">
                        <!-- ======= 첨부 파일 ======= --> 
                        <div class="file">
                            <c:if test="${not empty detailContent.file_path}">
                                <h6>첨부파일<i class="bi bi-chevron-compact-down" style="font-size: 1rem; padding-left: 5px"></i></h6>
                                <table id="attach" style="border-collapse: collapse; width: 100%;">
                                    <c:set var="file_path" value="${fn:split(detailContent.file_path,',')}" />
                                    <c:forEach items="${file_path}" var="file">
                                        <tr id="attach-tr">
                                            <c:choose>
                                                <c:when test="${fn:contains(file, '.png')}">
                                                    <td id="attach-td" style="padding-right: 200px" onclick="window.open('/images/${file}')"><i class="bi bi-filetype-png" style="font-size: 1rem"></i><span style="padding-left: 10px">${file}</span></td>
                                                    <td id="attach-td" style="text-align: center"><i class="bi bi-download" style="font-size: 1rem"></i></td>
                                                </c:when>
                                                <c:when test="${fn:contains(file, '.jpg')}">
                                                    <td id="attach-td" style="padding-right: 200px" onclick="window.open('/images/${file}')"><i class="bi bi-filetype-jpg" style="font-size: 1rem"></i><span style="padding-left: 10px">${file}</span></td>
                                                    <td id="attach-td" style="text-align: center"><i class="bi bi-download" style="font-size: 1rem"></i></td>
                                                </c:when>
                                                <c:when test="${fn:contains(file, '.pdf')}">
                                                    <td id="attach-td" style="padding-right: 200px" onclick="window.open('/images/${file}')"><i class="bi bi-filetype-pdf" style="font-size: 1rem"></i><span style="padding-left: 10px">${file}</span></td>
                                                    <td id="attach-td" style="text-align: center"><i class="bi bi-download" style="font-size: 1rem"></i></td>
                                                </c:when>
                                                <c:otherwise>
                                                    <td id="attach-td" style="padding-right: 200px" onclick="window.open('/images/${file}')"><i class="bi bi-file-earmark" style="font-size: 1rem"></i><span style="padding-left: 10px">${file}</span></td>
                                                    <td id="attach-td" style="text-align: center"><i class="bi bi-download" style="font-size: 1rem"></i></td>
                                                </c:otherwise>
                                            </c:choose>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </c:if>
                        </div>
                        <!-- ======= END 첨부 파일 ======= --> 
                     </article>
              	</div>
            </div> 
            
            <!-- ======= 이전글, 다음글 ======= -->
                    <div class="blog-author d-flex align-items-center" style="font-size: small">
                        <table>
                            <c:choose>
                                <c:when test="${empty preContent}">
                                <tr>
                                    <td style="width: 40px"><i class="bi bi-caret-down-fill"></i></td>
                                    <td style="width: 150px">${nextContent.receive_email}</td>
                                    <td style="width: 500px"><a href="/send/mailDetail?no=${nextContent.no}" style="color:black">${nextContent.title}</a></td>
                                    <td>${nextContent.send_date}</td>
                                </tr>
                                </c:when>
                                <c:when test="${empty nextContent}">
                                    <tr>
                                        <td style="width: 40px"><i class="bi bi-caret-up-fill"></i></td>
                                        <td style="width: 150px">${preContent.receive_email}</td>
                                        <td style="width: 500px"><a href="/send/mailDetail?no=${preContent.no}" style="color:black">${preContent.title}</a></td>
                                        <td>${preContent.send_date}</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td style="width: 40px"><i class="bi bi-caret-up-fill"></i></td>
                                        <td style="width: 150px">${preContent.receive_email}</td>
                                        <td style="width: 500px">
                                            <a href="/send/mailDetail?no=${preContent.no}" style="color:black">${preContent.title}</a>
                                        </td>
                                        <td>${preContent.send_date}</td>
                                    </tr>
                                    <tr>
                                        <td style="width: 40px"><i class="bi bi-caret-down-fill"></i></td>
                                        <td style="width: 150px">${nextContent.receive_email}</td>
                                        <td style="width: 500px">
                                            <a href="/send/mailDetail?no=${nextContent.no}" style="color:black">${nextContent.title}</a>
                                        </td>
                                        <td>${nextContent.send_date}</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </table>
                    </div>
                    <!-- ======= END 이전글, 다음글 ======= -->
            
            
          </div>         
          
          <div class="col-lg-4">
               <div class="sidebar">
                   <h3 class="sidebar-title">Categories</h3>
                   <div class="sidebar-item categories">
                       <ul>
                          <li><a href="/receive/list?page=1"><i class="bi bi-inbox" style="font-size: 1rem;"></i> 받은메일함<span style="font-size: medium"></span></a></li>
                          <li><a href="/send/sendList"><i class="bi bi-send" style="font-size: 1rem;"></i> 보낸메일함 <span></span></a></li>
                          <li><a href="/storage/storageList"><i class="bi bi-file-earmark" style="font-size: 1rem;"></i> 임시보관함 <span></span></a></li>
                          <li><a href="/send/sendMyList"><i class="bi bi-file-text" style="font-size: 1rem;"></i> 내게쓴메일함 <span></span></a></li>
                       </ul>
                   </div><!-- End sidebar categories-->

                   <div class="sidebar-item categories">
			                   <ul>
			                      <li><a href="/like/list"><i class="bi bi-star" style="font-size: 1rem;"></i> 즐겨찾기<span style="font-size: medium"></span></a></li>
			                      <li><a href="/spam/list"><i class="bi bi-slash-circle" style="font-size: 1rem;"></i> 스팸 메일함 <span></span></a></li>
			                      <li><a href="/trash/list"><i class="bi bi-trash3" style="font-size: 1rem;"></i> 휴지통 <span></span></a></li>
			                   </ul>
			       </div><!-- End sidebar categories-->
                   
               </div><!-- End blog sidebar -->
           </div>              
        </div>
      </div>
    </section><!-- End Blog Section -->

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