<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.MailDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

<title>Send Mail List</title>

    <script type="text/javascript">	
	function deleteM() {
		 var obj = $("[name=del]");
	     var arr = new Array(); // 배열 선언	 
	     $('input:checkbox[name=del]:checked').each(function() { <!--:checked-->
	    	 arr.push(this.value);
	     });
	     $.ajax({
	    	    url: "/delete/deleteMail",
	    	    data: {arr:arr},
	    	    dataType : 'json',
	    	    type: "POST",
	    	    success : function(data){
	    	    	//window.location.reload()
	    	    },
	    	    error : function(){		
	    	    	window.location.reload()
	    	    }
	    });  
	}
	
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
	 
	    	
	// paging   
	function pagination(){
        var req_num_row=5; 
        var $tr=jQuery($('.entry'));
        var total_num_row=$tr.length;
        //alert(total_num_row);
        var num_pages=0;
        
        if(total_num_row % req_num_row == 0){
            num_pages=total_num_row / req_num_row;
        }
        
        if(total_num_row % req_num_row > 0){
            num_pages=total_num_row / req_num_row;
            num_pages=Math.ceil(num_pages++);
        }
        
    	//jQuery('.pagination').append("<li><a class=\"prev\">Previous</a></li>");
  
        for (var i = 1; i <= num_pages; i++) {
        if (i == 1) {
            jQuery('.pagination').append("&nbsp;<li><a href=\"#\" class=\"active\" id=\"currentpage\">" + i + "</a></li>&nbsp;");
        } else {
            jQuery('.pagination').append("&nbsp;<li><a href=\"#\" style=\"color:black\">" + i + "</a></li>&nbsp;");
        }
        jQuery('.pagination li:nth-child(2)').addClass("active");
        jQuery('.pagination a').addClass("pagination-link");   
    	}
  
    	//jQuery('.pagination').append("<li><a class=\"next\">Next</a></li>");
  
    	//초기 화면 표시
        $tr.each(function (i) {
            jQuery(this).hide();
            if (i+1 <= req_num_row) {
                $tr.eq(i).show();
            }
        });
    	
        jQuery('.pagination a').click('.pagination-link', function (e) {
            e.preventDefault();
            $tr.hide();
            var page = jQuery(this).text();
            var temp = page - 1;
            var start = temp * req_num_row;
            var current_link = temp;
            
            jQuery('.pagination li').removeClass("active");
            jQuery(this).parent().addClass("active");
            jQuery('.pagination-link').removeClass("active");
            jQuery(this).addClass("active");
            
            for (var i = 0; i < req_num_row; i++) {
                $tr.eq(start + i).show();
            }
            if (temp >= 1) {
                jQuery('.pagination li:first-child').removeClass("disabled");
            }
            else {
                jQuery('.pagination li:first-child').addClass("disabled");
            }
        }); 
	}
	 
	jQuery('document').ready(function(){
		pagination();  
		jQuery('.pagination li:first-child').addClass("disabled");  
	});
	
	
	
	

    </script>

	<style>
		body {
			text-align: center;
		}
		
		table {
			width: 800px;
			border: 0px;
			border-collapse: collapse;
			table-layout: fixed;
		}
		
		
		.items {
			width: 25px;
		}
		
		
		input {
			BORDER-BOTTOM: teal 1px solid;
			BORDER-LEFT: medium none;
			BORDER-RIGHT: medium none;
			BORDER-TOP: medium none;
			FONT-SIZE: 9pt
		}
		
		.pagination {
			justify-content : center;
		}
		
		#currentpage:hover {
		    background-color:red;
			color:white;
		    padding:15px;
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
          <h2>보낸 메일함</h2>
          <ol>
            <li><a href="/home/index">Home</a></li>
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
          
          <!-- 메일함 상단 -->
          <div class="entry1" style="background-color: #515d6a; color: white;">
	          <div class="entry-content">
				<table>
	            	<tr>
	                	<td id="trash-box" class="inactive" width="22.5" onclick="deleteM();"><i class="bi bi-trash3" style="font-size: 1rem"></i></td>
                        <td style="padding-left: 710px"></td>
	                </tr>
	            </table>  
	          </div>   
          </div>             	
			
		  <!-- 메일함 -->  
		  <c:forEach items="${mailList}" var="mailList" varStatus="status">
		  <div class="entry" style="font-size: small">
			<table class="t">
				<tr>
					<td class="items">
						<input type="checkbox" name="del" value="${mailList.no}" style="color: #58151c">
					</td>
					
					<td class="items">
						<c:choose>
						<c:when test="${mailList.like_checked eq 'Y'.charAt(0)}">
							<i class="bi bi-star-fill" style="font-size: 1rem; color: #58151c"
                               no = "${mailList.no}"
                               like-status = "${mailList.like_checked}"
                               onclick="changeLikeChecked(this);"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="bi bi-star" style="font-size: 1rem; color: #58151c"
                               no = "${mailList.no}"
                               like-status = "${mailList.like_checked}"
                               onclick="changeLikeChecked(this);"></i>
                        </c:otherwise>
						</c:choose>
					</td>
					
					<!-- ======= 첨부 파일 ======= --> 
                    <c:if test="${not empty mailList.file_path}">
                       <td class="items"><i class="bi bi-paperclip" style="font-size: 1rem; color: #58151c"></i></td>
                    </c:if>
                    <c:if test="${empty mailList.file_path}">
                       <td class="items" style="padding-left: 20px;"></td>
                    </c:if>
                    <!-- ======= END 첨부 파일  ======= -->
                    
                    <td class="items"></td>
                    
					<td style = "width: 180px">${mailList.receive_email}</td>
                    <td style = "width: 300px"><a href="/send/mailDetail?no=${mailList.no}">${mailList.title}</a></td>
                    <td style = "width: 150px">${mailList.send_date}</td>
                    <td><a href="/send/sendAgain?no=${mailList.no}">전달</a></td>
				</tr>

			</table>
			</div>
          </c:forEach>
         <br>
         <ul class="pagination" ></ul>
         </div>
        
  
      	  <div class="col-lg-4">
           <div class="sidebar">
         	 
          	 <h3 class="sidebar-title">Search</h3>
          	 <form method="post">
             <div class="sidebar-item search-form">
                 
                      <select name="search_option">
	                  	<option value="receive_email">이메일 주소</option>
	                  	<option value="title">제목</option>
	                  	<option value="content">내용</option>
	                  </select>
	                  <br>
	                  <input type="text" name="search_content">
	                  <button type="submit" onclick= "javascript: form.action='/send/sendList'"><i class="bi bi-search"></i></button>
                 
              </div><!-- End sidebar search form-->
              </form>
			 <br><br>
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
  
  </section>

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