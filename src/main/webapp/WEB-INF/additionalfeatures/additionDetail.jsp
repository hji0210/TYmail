<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>메일 세부 사항</title>
    <!-- Bootstrap CSS (Optional) -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
    <link href="/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
    <link href="/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="/assets/css/style.css" rel="stylesheet">


    <%-- AXIOS --%>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>

    <style>
        .inactive {
            color: black;
            cursor: not-allowed;
        }

        .active {
            color: white;
            cursor: pointer;
        }

        #attach {
            border-collapse: collapse;
            width: 100%;
        }

        #attach-tr #attach-td {
            font-size: small;
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        
        input {
			BORDER-BOTTOM: teal 1px solid;
			BORDER-LEFT: medium none;
			BORDER-RIGHT: medium none;
			BORDER-TOP: medium none;
			FONT-SIZE: 9pt
		}

    </style>

</head>

<script>

    // '별표' 이미지 선택시 likeChecked 변경
    function changeLikeCheckedFromAddition(imgElement) {
        const no = imgElement.getAttribute("no");
        let likeChecked = imgElement.getAttribute("like-status");
        const category = imgElement.getAttribute("category");

        if(likeChecked === 'Y') {
            likeChecked = 'N';
        } else {
            likeChecked = 'Y';
        }
        updateLikeStatusFromAddition(no, likeChecked, category);
    }

    // no, likeChecked 서버로 전달
    function updateLikeStatusFromAddition(no, likeChecked, category) {
        axios.post('/update/mark',
            {no: no, likeChecked: likeChecked},
            {params: { category: category },'Content-Type': 'application/json'})
            .then(() => {window.location.reload()})
            .catch(() => {alert('실패')})
    }

    // '봉투' 이미지 선택시 readStatus 변경
    function changeReadStatusFromAddition(imgElement) {
        const no = imgElement.getAttribute("no");
        let readStatus = imgElement.getAttribute("read-status");
        const category = imgElement.getAttribute("category");

        if(readStatus === 'Y') {
            readStatus = 'N';
        } else {
            readStatus = 'Y';
        }
        updateReadStatusFromAddition(no, readStatus, category);
    }

    // no, readStatus 서버로 전달
    function updateReadStatusFromAddition(no, readStatus, category) {
        axios.post('/update/readStatus',
            {no: no, readStatus: readStatus},
            {params: { category: category }, 'Content-Type': 'application/json'})
            .then(() => {window.location.reload()})
            .catch(() => {alert('실패')})
    }
    
 // 메일 영구 삭제 확인
    function deleteOneForever() {
        const form = document.querySelector('#trash-form');

        Swal.fire({
            title: "메일을 영구삭제하시겠습니까?",
            text: "영구 삭제한 메일은 복구할 수 없습니다.",
            icon: "warning",
            showConfirmButton: true,
            showDenyButton: true,
            confirmButtonText: '확인',
            denyButtonText: '취소',
        }).then(function (result) {
            if (result.isConfirmed) {
                Swal.fire({
                    title: '메일을 영구삭제 했습니다.',
                    confirmButtonText: '확인',
                    icon: 'success'
                }).then(function () {
                    form.action = '/trash/remove-one'; // <— submit form programmatically
                    form.submit();
                });
            } else if (result.isDenied) {
                window.location.reload();
            }
        });
    }

</script>

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
                <c:choose>
                    <c:when test="${category eq 'trash'}">
                            <ol>
                                <li>
                                    <h2 onclick="location.href='/trash/list'" style="font-weight: normal"><i class="bi bi-chevron-compact-left"></i>휴지통</h2>
                                </li>
                            </ol>
                    </c:when>

                    <c:when test="${category eq 'like'}">
                            <ol>
                                <li>
                                    <h2 onclick="location.href='/like/list'" style="font-weight: normal"><i class="bi bi-chevron-compact-left"></i>즐겨찾기</h2>
                                </li>
                            </ol>
                    </c:when>

                    <c:when test="${category eq 'spam'}">
                            <ol>
                                <li>
                                    <h2 onclick="location.href='/spam/list'" style="font-weight: normal"><i class="bi bi-chevron-compact-left"></i>스팸 메일함</h2>
                                </li>
                            </ol>
                    </c:when>
                </c:choose> 
                <ol>
                    <li><a href="index.html">Home</a></li>
                    <li>메일 상세</li>
                </ol>
            </div>

        </div>
    </section><!-- End Breadcrumbs -->


    <section id="blog" class="blog">
        <div class="container" data-aos="fade-up">
            <div class="row">

                <!-- ======= 받은메일 List ======= -->
                <div class="col-lg-8 entries">
                    <div class="entry" style="background-color: #515d6a; color: white;">
                        <div class="entry-content">
                            <!-- ======= 삭제, 영구삭제, 회신하기 테이블 ======= -->
                            <c:choose>
                                <c:when test="${category eq 'trash'}">
                                    <table>
                                        <tr>
                                            <td>
                                                <form method="post" id="trash-form">
                                                    <input type="hidden" name="no" value="${receiveResponseDTO.no}">
                                                    <input type="button" value="영구삭제" style="color: white; border: none; background: transparent;" onclick="deleteOneForever()">
                                                    <input type="submit" value="이동" style="color: white; border: none; background: transparent;" onclick="javascript: form.action='/trash/move-one'">
                                                </form>
                                            </td>
                                        </tr>
                                    </table>
                                </c:when>
                                <c:when test="${category eq 'like'}">
                                    <table>
                                        <tr>
                                            <td>
                                                <form method="post">
                                                    <input type="hidden" name="no" value="${receiveResponseDTO.no}">
                                                    <input type="submit" value="삭제" style="color: white; border: none; background: transparent;" onclick="javascript: form.action='/like/move-one'">
                                                </form>
                                            </td>
                                        </tr>
                                    </table>
                                </c:when>
                                <c:when test="${category eq 'spam'}">
                                    <table>
                                        <tr>
                                            <td>
                                                <form method="post">
                                                    <input type="hidden" name="no" value="${receiveResponseDTO.no}">
                                                    <input type="submit" value="삭제" style="color: white; border: none; background: transparent;" onclick="javascript: form.action='/spam/move-one'">
                                                </form>
                                            </td>
                                        </tr>
                                    </table>
                                </c:when>
                            </c:choose>
                            <!-- ======= END 필터 DropBox ======= -->
                        </div>
                    </div>
                    <div class="blog-author">
                        <div>
                            <!-- ======= 별표 (중요 메일) ======= -->
                            <br><h4>
                            <c:choose>
                                <c:when test="${receiveResponseDTO.likeChecked == 'Y'}">
                                    <i class="bi bi-star-fill"
                                       style="font-size: 1rem; color: #58151c"
                                       no = "${receiveResponseDTO.no}"
                                       like-status = "${receiveResponseDTO.likeChecked}"
                                       category = "${category}"
                                       onclick="changeLikeCheckedFromAddition(this)"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-star"
                                       style="font-size: 1rem; color: #58151c"
                                       no = "${receiveResponseDTO.no}"
                                       like-status = "${receiveResponseDTO.likeChecked}"
                                       category = "${category}"
                                       onclick="changeLikeCheckedFromAddition(this)"></i>
                                </c:otherwise>
                            </c:choose>
                            ${receiveResponseDTO.title}
                            </h4>
                            <!-- ======= END 별표 (중요 메일) ======= -->
							<br>
				            <div class="entry-meta">
					            <ul>
					                <li class="d-flex align-items-center"><i class="bi bi-person"></i>&nbsp;보낸사람&nbsp;|&nbsp;<a href="/send/replyForm?receive_email=${receiveResponseDTO.sendName}">${receiveResponseDTO.sendName}&lt;${receiveResponseDTO.sendEmail}&gt;</a></li>
					                <li class="d-flex align-items-center"><i class="bi bi-person"></i>&nbsp;받는사람&nbsp;|&nbsp;${receiveResponseDTO.id}&lt;${receiveResponseDTO.id}&gt;</li>
					            	<li class="d-flex align-items-center"><i class="bi bi-clock"></i>&nbsp;
		                            <h6 style="font-size: small; color: #51585e;">
		                                <c:set var="rawDate" value="${receiveResponseDTO.createAt}" />
		                                <c:set var="replacedDate" value="${fn:replace(rawDate, '.', '')}" />
		                                <fmt:parseDate var="parsedDate" value="${replacedDate}" pattern="yyyy-MM-ddHH:mm:ss" />
		                                <fmt:formatDate value="${parsedDate}" pattern="yyyy년MM월dd일 (E) a HH시mm분" />
		                            </h6>
					            </ul> 
                            </div>
                            <hr style="color:gray"><br>
                            <h5>${receiveResponseDTO.content}</h5><br><br>
                        </div>
                        
                        <article class="entry entry-single">
                        <!-- ======= 첨부 파일 ======= --> 
                        <div class="file">
                            <c:if test="${not empty receiveResponseDTO.filePath}">
                                <h6>첨부파일<i class="bi bi-chevron-compact-down" style="font-size: 1rem; padding-left: 5px"></i></h6>
                                <table id="attach" style="border-collapse: collapse; width: 100%;">
                                    <c:set var="file_path" value="${fn:split(receiveResponseDTO.filePath,',')}" />
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

                    <!-- ======= 이전글, 다음글 ======= -->
                    <div class="blog-author d-flex align-items-center" style="font-size: small">
                        <table>
                            <c:choose>
                                <c:when test="${empty preReceiveResponseDTO}">
                                <tr>
                                    <td><i class="bi bi-caret-down-fill"></i></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${nextReceiveResponseDTO.readStatus == 'Y'}">
                                                <i class="bi bi-envelope-open"
                                                   style="padding-left: 5px; padding-bottom: 3px; font-size: 1rem; color: #58151c"
                                                   no = "${nextReceiveResponseDTO.no}"
                                                   read-status = "${nextReceiveResponseDTO.readStatus}"
                                                   category = "${category}"
                                                   onclick="changeReadStatusFromAddition(this)"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-envelope-fill"
                                                   style="padding-left: 5px; padding-bottom: 3px; font-size: 1rem; color: #58151c"
                                                   no = "${nextReceiveResponseDTO.no}"
                                                   read-status = "${nextReceiveResponseDTO.readStatus}"
                                                   category = "${category}"
                                                   onclick="changeReadStatusFromAddition(this)"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="width: 100px; padding-left: 20px">${nextReceiveResponseDTO.sendName}</td>
                                    <td style="width: 600px"
                                        onclick="location.href='/addition/detail?no=${nextReceiveResponseDTO.no}&category=${category}'">${nextReceiveResponseDTO.title}</td>
                                    <td>
                                        <c:set var="rawDate" value="${nextReceiveResponseDTO.createAt}" />
                                        <c:set var="replacedDate" value="${fn:replace(rawDate, '.', '')}" />
                                        <fmt:parseDate var="parsedDate" value="${replacedDate}" pattern="yyyy-MM-ddHH:mm:ss" />
                                        <fmt:formatDate var="date" value="${parsedDate}" pattern="yyyy-MM-ddHH:mm:ss" />
                                        <c:set var="originalCurrentDate" value="<%= new java.util.Date() %>" />
                                        <fmt:formatDate var="formattedCurrentDate" value="${originalCurrentDate}" pattern="yyyy-MM-ddHH:mm:ss" />
                                        <fmt:parseDate var="parsedCurrentDate" value="${formattedCurrentDate}" pattern="yyyy-MM-ddHH:mm:ss" />
                                        <fmt:formatDate var="currentDate" value="${parsedCurrentDate}" pattern="yyyy-MM-ddHH:mm:ss" />

                                        <c:choose>
                                            <c:when test="${fn:substring(date, 0, 4) == fn:substring(currentDate, 0, 4)}">
                                                <c:choose>
                                                    <c:when test="${fn:substring(date, 0, 10) == fn:substring(currentDate, 0, 10)}">
                                                        <fmt:parseDate var="dateValue" value="${date}" pattern="yyyy-MM-ddHH:mm:ss" />
                                                        <fmt:formatDate value="${dateValue}" pattern="HH:mm" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:parseDate var="dateValue" value="${date}" pattern="yyyy-MM-ddHH:mm:ss" />
                                                        <fmt:formatDate value="${dateValue}" pattern="MM.dd HH:mm" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:parseDate var="dateValue" value="${date}" pattern="yyyy-MM-ddHH:mm:ss" />
                                                <fmt:formatDate value="${dateValue}" pattern="yyyy.MM.dd HH:mm" />
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                </c:when>
                                <c:when test="${empty nextReceiveResponseDTO}">
                                    <tr>
                                        <td><i class="bi bi-caret-up-fill"></i></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${preReceiveResponseDTO.readStatus == 'Y'}">
                                                    <i class="bi bi-envelope-open"
                                                       style="padding-left: 5px; padding-bottom: 3px; font-size: 1rem; color: #58151c"
                                                       no = "${preReceiveResponseDTO.no}"
                                                       read-status = "${preReceiveResponseDTO.readStatus}"
                                                       category = "${category}"
                                                       onclick="changeReadStatusFromAddition(this)"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-envelope-fill"
                                                       style="padding-left: 5px; padding-bottom: 3px; font-size: 1rem; color: #58151c"
                                                       no = "${preReceiveResponseDTO.no}"
                                                       read-status = "${preReceiveResponseDTO.readStatus}"
                                                       category = "${category}"
                                                       onclick="changeReadStatusFromAddition(this)"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="width: 100px; padding-left: 20px">${preReceiveResponseDTO.sendName}</td>
                                        <td style="width: 600px"
                                            onclick="location.href='/addition/detail?no=${preReceiveResponseDTO.no}&category=${category}'">${preReceiveResponseDTO.title}</td>
                                        <td>
                                            <c:set var="rawDate" value="${preReceiveResponseDTO.createAt}" />
                                            <c:set var="replacedDate" value="${fn:replace(rawDate, '.', '')}" />
                                            <fmt:parseDate var="parsedDate" value="${replacedDate}" pattern="yyyy-MM-ddHH:mm:ss" />
                                            <fmt:formatDate var="date" value="${parsedDate}" pattern="yyyy-MM-ddHH:mm:ss" />
                                            <c:set var="originalCurrentDate" value="<%= new java.util.Date() %>" />
                                            <fmt:formatDate var="formattedCurrentDate" value="${originalCurrentDate}" pattern="yyyy-MM-ddHH:mm:ss" />
                                            <fmt:parseDate var="parsedCurrentDate" value="${formattedCurrentDate}" pattern="yyyy-MM-ddHH:mm:ss" />
                                            <fmt:formatDate var="currentDate" value="${parsedCurrentDate}" pattern="yyyy-MM-ddHH:mm:ss" />

                                            <c:choose>
                                                <c:when test="${fn:substring(date, 0, 4) == fn:substring(currentDate, 0, 4)}">
                                                    <c:choose>
                                                        <c:when test="${fn:substring(date, 0, 10) == fn:substring(currentDate, 0, 10)}">
                                                            <fmt:parseDate var="dateValue" value="${date}" pattern="yyyy-MM-ddHH:mm:ss" />
                                                            <fmt:formatDate value="${dateValue}" pattern="HH:mm" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:parseDate var="dateValue" value="${date}" pattern="yyyy-MM-ddHH:mm:ss" />
                                                            <fmt:formatDate value="${dateValue}" pattern="MM.dd HH:mm" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <fmt:parseDate var="dateValue" value="${date}" pattern="yyyy-MM-ddHH:mm:ss" />
                                                    <fmt:formatDate value="${dateValue}" pattern="yyyy.MM.dd HH:mm" />
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td><i class="bi bi-caret-up-fill"></i></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${preReceiveResponseDTO.readStatus == 'Y'}">
                                                    <i class="bi bi-envelope-open"
                                                       style="padding-left: 5px; padding-bottom: 3px; font-size: 1rem; color: #58151c"
                                                       no = "${preReceiveResponseDTO.no}"
                                                       read-status = "${preReceiveResponseDTO.readStatus}"
                                                       category = "${category}"
                                                       onclick="changeReadStatusFromAddition(this)"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-envelope-fill"
                                                       style="padding-left: 5px; padding-bottom: 3px; font-size: 1rem; color: #58151c"
                                                       no = "${preReceiveResponseDTO.no}"
                                                       read-status = "${preReceiveResponseDTO.readStatus}"
                                                       category = "${category}"
                                                       onclick="changeReadStatusFromAddition(this)"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="width: 100px; padding-left: 20px">${preReceiveResponseDTO.sendName}</td>
                                        <td style="width: 600px"
                                            onclick="location.href='/addition/detail?no=${preReceiveResponseDTO.no}&category=${category}'">${preReceiveResponseDTO.title}</td>
                                        <td>
                                            <c:set var="rawDate" value="${preReceiveResponseDTO.createAt}" />
                                            <c:set var="replacedDate" value="${fn:replace(rawDate, '.', '')}" />
                                            <fmt:parseDate var="parsedDate" value="${replacedDate}" pattern="yyyy-MM-ddHH:mm:ss" />
                                            <fmt:formatDate var="date" value="${parsedDate}" pattern="yyyy-MM-ddHH:mm:ss" />
                                            <c:set var="originalCurrentDate" value="<%= new java.util.Date() %>" />
                                            <fmt:formatDate var="formattedCurrentDate" value="${originalCurrentDate}" pattern="yyyy-MM-ddHH:mm:ss" />
                                            <fmt:parseDate var="parsedCurrentDate" value="${formattedCurrentDate}" pattern="yyyy-MM-ddHH:mm:ss" />
                                            <fmt:formatDate var="currentDate" value="${parsedCurrentDate}" pattern="yyyy-MM-ddHH:mm:ss" />

                                            <c:choose>
                                                <c:when test="${fn:substring(date, 0, 4) == fn:substring(currentDate, 0, 4)}">
                                                    <c:choose>
                                                        <c:when test="${fn:substring(date, 0, 10) == fn:substring(currentDate, 0, 10)}">
                                                            <fmt:parseDate var="dateValue" value="${date}" pattern="yyyy-MM-ddHH:mm:ss" />
                                                            <fmt:formatDate value="${dateValue}" pattern="HH:mm" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:parseDate var="dateValue" value="${date}" pattern="yyyy-MM-ddHH:mm:ss" />
                                                            <fmt:formatDate value="${dateValue}" pattern="MM.dd HH:mm" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <fmt:parseDate var="dateValue" value="${date}" pattern="yyyy-MM-ddHH:mm:ss" />
                                                    <fmt:formatDate value="${dateValue}" pattern="yyyy.MM.dd HH:mm" />
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><i class="bi bi-caret-down-fill"></i></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${nextReceiveResponseDTO.readStatus == 'Y'}">
                                                    <i class="bi bi-envelope-open"
                                                       style="padding-left: 5px; padding-bottom: 3px; font-size: 1rem; color: #58151c"
                                                       no = "${nextReceiveResponseDTO.no}"
                                                       read-status = "${nextReceiveResponseDTO.readStatus}"
                                                       category = "${category}"
                                                       onclick="changeReadStatusFromAddition(this)"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-envelope-fill"
                                                       style="padding-left: 5px; padding-bottom: 3px; font-size: 1rem; color: #58151c"
                                                       no = "${nextReceiveResponseDTO.no}"
                                                       read-status = "${nextReceiveResponseDTO.readStatus}"
                                                       category = "${category}"
                                                       onclick="changeReadStatusFromAddition(this)"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="width: 100px; padding-left: 20px">${nextReceiveResponseDTO.sendName}</td>
                                        <td style="width: 600px"
                                            onclick="location.href='/addition/detail?no=${nextReceiveResponseDTO.no}&category=${category}'">${nextReceiveResponseDTO.title}</td>
                                        <td>
                                            <c:set var="rawDate" value="${nextReceiveResponseDTO.createAt}" />
                                            <c:set var="replacedDate" value="${fn:replace(rawDate, '.', '')}" />
                                            <fmt:parseDate var="parsedDate" value="${replacedDate}" pattern="yyyy-MM-ddHH:mm:ss" />
                                            <fmt:formatDate var="date" value="${parsedDate}" pattern="yyyy-MM-ddHH:mm:ss" />
                                            <c:set var="originalCurrentDate" value="<%= new java.util.Date() %>" />
                                            <fmt:formatDate var="formattedCurrentDate" value="${originalCurrentDate}" pattern="yyyy-MM-ddHH:mm:ss" />
                                            <fmt:parseDate var="parsedCurrentDate" value="${formattedCurrentDate}" pattern="yyyy-MM-ddHH:mm:ss" />
                                            <fmt:formatDate var="currentDate" value="${parsedCurrentDate}" pattern="yyyy-MM-ddHH:mm:ss" />

                                            <c:choose>
                                                <c:when test="${fn:substring(date, 0, 4) == fn:substring(currentDate, 0, 4)}">
                                                    <c:choose>
                                                        <c:when test="${fn:substring(date, 0, 10) == fn:substring(currentDate, 0, 10)}">
                                                            <fmt:parseDate var="dateValue" value="${date}" pattern="yyyy-MM-ddHH:mm:ss" />
                                                            <fmt:formatDate value="${dateValue}" pattern="HH:mm" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:parseDate var="dateValue" value="${date}" pattern="yyyy-MM-ddHH:mm:ss" />
                                                            <fmt:formatDate value="${dateValue}" pattern="MM.dd HH:mm" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <fmt:parseDate var="dateValue" value="${date}" pattern="yyyy-MM-ddHH:mm:ss" />
                                                    <fmt:formatDate value="${dateValue}" pattern="yyyy.MM.dd HH:mm" />
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </table>
                    </div>
                    <!-- ======= END 이전글, 다음글 ======= -->
                    </div><!-- End blog author bio -->


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
                        <div class="sidebar-title" id="categories-box" style="font-size: medium;"><i class="bi bi-stack"></i> 스마트메일함<i class="bi bi-caret-down" style="padding-left: 210px"></i></div>
                        <div class="sidebar-item categories" id="category-list">
                            <ul id="category-items">
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

<!-- Bootstrap JS (Optional, requires jQuery and Popper.js) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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
<script src="/assets/js/receive.js"></script>
<script src="/assets/js/main.js"></script>

</body>
</html>