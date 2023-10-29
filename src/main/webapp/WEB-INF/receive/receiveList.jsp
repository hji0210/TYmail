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

    <title>받은 메일함</title>
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

    <style>
        .inactive {
            color: black;
            cursor: not-allowed;
        }

        .active {
            color: white;
            cursor: pointer;
        }

        #fixedDiv {
            position: fixed;
            top: 50px; /* 원하는 위치로 조절하세요 */
            left: 20px; /* 원하는 위치로 조절하세요 */
            background-color: lightgray;
            padding: 10px;
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

    </style>

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
                <c:choose>
                    <c:when test="${category eq 'search'}">
                        <ol>
                            <li>
                                <h2 style="font-weight: normal">검색결과</h2>
                            </li>
                        </ol>
                    </c:when>
                    <c:when test="${category eq 'receiveFolder'}">
                        <c:if test="${filter eq 'all'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">받은메일함(모든 메일)</h2>
                                </li>
                            </ol>
                        </c:if>
                        <c:if test="${filter eq 'unread'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">받은메일함(안읽은 메일)</h2>
                                </li>
                            </ol>
                        </c:if>
                        <c:if test="${filter eq 'mark'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">받은메일함(중요 메일)</h2>
                                </li>
                            </ol>
                        </c:if>
                        <c:if test="${filter eq 'attach'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">받은메일함(첨부 메일)</h2>
                                </li>
                            </ol>
                        </c:if>
                        <c:if test="${filter eq 'null'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">받은메일함</h2>
                                </li>
                            </ol>
                        </c:if>
                    </c:when>
                    <c:when test="${category eq 'receive'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">받은메일함</h2>
                                </li>
                            </ol>
                    </c:when>

                    <c:when test="${category eq 'promotionFolder'}">
                        <c:if test="${filter eq 'all'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">프로모션(모든 메일)</h2>
                                </li>
                            </ol>
                        </c:if>
                        <c:if test="${filter eq 'unread'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">프로모션(안읽은 메일)</h2>
                                </li>
                            </ol>
                        </c:if>
                        <c:if test="${filter eq 'mark'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">프로모션(중요 메일)</h2>
                                </li>
                            </ol>
                        </c:if>
                        <c:if test="${filter eq 'attach'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">프로모션(첨부 메일)</h2>
                                </li>
                            </ol>
                        </c:if>
                        <c:if test="${filter eq 'null'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">프로모션</h2>
                                </li>
                            </ol>
                        </c:if>
                    </c:when>
                    <c:when test="${category eq 'promotion'}">
                        <ol>
                            <li>
                                <h2 style="font-weight: normal">프로모션</h2>
                            </li>
                        </ol>
                    </c:when>

                    <c:when test="${category eq 'chargeFolder'}">
                        <c:if test="${filter eq 'all'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">청구 및 결제(모든 메일)</h2>
                                </li>
                            </ol>
                        </c:if>
                        <c:if test="${filter eq 'unread'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">청구 및 결제(안읽은 메일)</h2>
                                </li>
                            </ol>
                        </c:if>
                        <c:if test="${filter eq 'mark'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">청구 및 결제(중요 메일)</h2>
                                </li>
                            </ol>
                        </c:if>
                        <c:if test="${filter eq 'attach'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">청구 및 결제(첨부 메일)</h2>
                                </li>
                            </ol>
                        </c:if>
                        <c:if test="${filter eq 'null'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">청구 및 결제</h2>
                                </li>
                            </ol>
                        </c:if>
                    </c:when>
                    <c:when test="${category eq 'charge'}">
                        <ol>
                            <li>
                                <h2 style="font-weight: normal">청구 및 결제</h2>
                            </li>
                        </ol>
                    </c:when>

                    <c:when test="${category eq 'snsFolder'}">
                        <c:if test="${filter eq 'all'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">SNS(모든 메일)</h2>
                                </li>
                            </ol>
                        </c:if>
                        <c:if test="${filter eq 'unread'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">SNS(안읽은 메일)</h2>
                                </li>
                            </ol>
                        </c:if>
                        <c:if test="${filter eq 'mark'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">SNS(중요 메일)</h2>
                                </li>
                            </ol>
                        </c:if>
                        <c:if test="${filter eq 'attach'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">SNS(첨부 메일)</h2>
                                </li>
                            </ol>
                        </c:if>
                        <c:if test="${filter eq 'null'}">
                            <ol>
                                <li>
                                    <h2 style="font-weight: normal">SNS</h2>
                                </li>
                            </ol>
                        </c:if>
                    </c:when>
                    <c:when test="${category eq 'sns'}">
                        <ol>
                            <li>
                                <h2 style="font-weight: normal">SNS</h2>
                            </li>
                        </ol>
                    </c:when>
                </c:choose>
                <ol>
                    <li><a href="index.html">Home</a></li>
                    <li>받은 메일함</li>
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
                            <!-- ======= 필터 DropBox ======= -->

                            <table>
                                <tr>
                                    <td id="trash-box" class="inactive" page="${page}" onclick="sendToTrash(this)"><i class="bi bi-trash3" style="font-size: 1rem"></i></td>
                                    <td style="padding-left: 380px"><div class="dropdown">
                                        <div class="dropdown-toggle" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            필터
                                        </div>
                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                            <li><h6 class="dropdown-header">필터</h6></li>
                                            <li><a class="dropdown-item" onclick="applyFilter('all')">모든 메일</a></li>
                                            <li><a class="dropdown-item" onclick="applyFilter('unread')">안읽은 메일</a></li>
                                            <li><a class="dropdown-item" onclick="applyFilter('mark')">중요 메일</a></li>
                                            <li><a class="dropdown-item" onclick="applyFilter('attach')">첨부 메일</a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><h6 class="dropdown-header">정렬</h6></li>
                                            <li><a class="dropdown-item" onclick="applySort(0)">최신 순</a></li>
                                            <li><a class="dropdown-item" onclick="applySort(1)">오래된 순</a></li>
                                        </ul>
                                    </div></td>
                                </tr>
                            </table>
                            <!-- ======= END 필터 DropBox ======= -->
                        </div>
                    </div>
                    <c:forEach items="${receiveResponseDTOList}" var="receiveResponseDTO" varStatus="status">
                    
                    	<c:choose>
                            <c:when test="${category eq 'search'}">
                                <div class="entry" style="font-size: small">
                                    <div class="entry-content">
                                        <table>
                                            <tr>
                                                <td>${receiveResponseDTO.sendName}</td>
                                                <td>${receiveResponseDTO.sendEmail}</td>
                                                <td class="receive-mail-title" style="width: 580px"
                                                    no = "${receiveResponseDTO.no}"
                                                    filter = "${filter}"
                                                    sort = "${sort}"
                                                    page = "1"
                                                    onclick="getUrlForDetail(this)">${receiveResponseDTO.title}</td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </c:when>
                        <c:otherwise>
                    
                    
                        <div class="entry" style="font-size: small">
                            <div class="entry-content">
                                <table>
                                    <tr>
                                        <td class="items"><input type="checkbox" id="checkbox" value="${receiveResponseDTO.no}" style="padding-bottom: 0px; color: #58151c"></td>

                                        <!-- ======= 별표 (중요 메일) ======= -->
                                        <td class="items">
                                            <c:choose>
                                                <c:when test="${receiveResponseDTO.likeChecked == 'Y'}">
                                                    <i class="bi bi-star-fill"
                                                       style="font-size: 1rem; color: #58151c"
                                                       no = "${receiveResponseDTO.no}"
                                                       like-status = "${receiveResponseDTO.likeChecked}"
                                                       page = "${page}"
                                                       onclick="changeLikeChecked(this)"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-star"
                                                       style="font-size: 1rem; color: #58151c"
                                                       no = "${receiveResponseDTO.no}"
                                                       like-status = "${receiveResponseDTO.likeChecked}"
                                                       page = "${page}"
                                                       onclick="changeLikeChecked(this)"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <!-- ======= END 별표 (중요 메일) ======= -->

                                        <!-- ======= 봉투 (읽음, 안읽음) ======= -->
                                        <td class="items">
                                        <c:choose>
                                            <c:when test="${receiveResponseDTO.readStatus == 'Y'}">
                                                <i class="bi bi-envelope-open"
                                                   style="font-size: 1rem; color: #58151c"
                                                   no = "${receiveResponseDTO.no}"
                                                   read-status = "${receiveResponseDTO.readStatus}"
                                                   page = "${page}"
                                                   onclick="changeReadStatus(this)"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-envelope-fill"
                                                   style="font-size: 1rem; color: #58151c"
                                                   no = "${receiveResponseDTO.no}"
                                                   read-status = "${receiveResponseDTO.readStatus}"
                                                   page = "${page}"
                                                   onclick="changeReadStatus(this)"></i>
                                            </c:otherwise>
                                        </c:choose>
                                        </td>
                                        <!-- ======= END 봉투 (읽음, 안읽음) ======= -->

                                        <!-- ======= 첨부 파일 ======= --> 
                                        <c:if test="${not empty receiveResponseDTO.filePath}">
                                            <td class="items"><i class="bi bi-paperclip"
                                                   style="font-size: 1rem; color: #58151c"></i></td>
                                        </c:if>
                                        <c:if test="${empty receiveResponseDTO.filePath}">
                                            <td class="items"></td>
                                        </c:if>
                                        <!-- ======= END 첨부 파일  ======= -->

                                        <td style = "width: 180px"><a href="/send/replyForm?receive_email=${receiveResponseDTO.sendName}">${receiveResponseDTO.sendName}</a></td> 

                                        <!-- ======= END 메일 세부 사항 ======= -->
                                        <td class="receive-mail-title"
                                        	style = "width: 300px"
                                            no = "${receiveResponseDTO.no}"
                                            filter = "${filter}"
                                            sort = "${sort}"
                                            page = "${page}"
                                            onclick="getUrlForDetail(this)">${receiveResponseDTO.title}
                                        </td>
                                        <!-- ======= END 메일 세부 사항 ======= -->
                                        <td style = "width: 150px">
                                            <c:set var="rawDate" value="${receiveResponseDTO.createAt}" />
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
                                        <td><a href="/send/replyEmail?no=${receiveResponseDTO.no}">회신</a></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        
                      </c:otherwise>
                      </c:choose>
                        
                    </c:forEach>
                <!-- ======= END 받은메일 List ======= -->

                    <!-- ======= 페이징 ======= -->
                    <div class="blog-pagination">
                        <ul class="justify-content-center">
                            <c:choose>
                                <c:when test="${category eq 'receive'}">
                                    <c:if test="${prev}">
                                        <li>
                                            <a href="/receive/list?page=${pageStart - 1}"></a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="${pageStart}" end="${pageEnd}" var="pageNum">
                                        <li>
                                            <a href="/receive/list?page=${pageNum}">${pageNum}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${next}">
                                        <li>
                                            <a href="/receive/list?page=${pageEnd + 1}"></a>
                                        </li>
                                    </c:if>
                                </c:when>

                                <c:when test="${category eq 'receiveFolder'}">
                                    <c:if test="${prev}">
                                        <li>
                                            <a href="/receive/list/folder?filter=${filter}&sort=${sort}&page=${pageStart - 1}"></a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="${pageStart}" end="${pageEnd}" var="pageNum">
                                        <li>
                                            <a href="/receive/list/folder?filter=${filter}&sort=${sort}&page=${pageNum}">${pageNum}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${next}">
                                        <li>
                                            <a href="/receive/list/folder?filter=${filter}&sort=${sort}&page=${pageEnd + 1}"></a>
                                        </li>
                                    </c:if>
                                </c:when>

                                <c:when test="${category eq 'promotion'}">
                                    <c:if test="${prev}">
                                        <li>
                                            <a href="/smart/promotion?page=${pageStart - 1}"></a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="${pageStart}" end="${pageEnd}" var="pageNum">
                                        <li>
                                            <a href="/smart/promotion?page=${pageNum}">${pageNum}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${next}">
                                        <li>
                                            <a href="/smart/promotion?page=${pageEnd + 1}"></a>
                                        </li>
                                    </c:if>
                                </c:when>

                                <c:when test="${category eq 'charge'}">
                                    <c:if test="${prev}">
                                        <li>
                                            <a href="/smart/charge?page=${pageStart - 1}"></a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="${pageStart}" end="${pageEnd}" var="pageNum">
                                        <li>
                                            <a href="/smart/charge?page=${pageNum}">${pageNum}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${next}">
                                        <li>
                                            <a href="/smart/charge?page=${pageEnd + 1}"></a>
                                        </li>
                                    </c:if>
                                </c:when>

                                <c:when test="${category eq 'sns'}">
                                    <c:if test="${prev}">
                                        <li>
                                            <a href="/smart/sns?page=${pageStart - 1}"></a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="${pageStart}" end="${pageEnd}" var="pageNum">
                                        <li>
                                            <a href="/smart/sns?page=${pageNum}">${pageNum}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${next}">
                                        <li>
                                            <a href="/smart/sns?page=${pageEnd + 1}">></a>
                                        </li>
                                    </c:if>
                                </c:when>

                                <c:when test="${category eq 'promotionFolder'}">
                                    <c:if test="${prev}">
                                        <li>
                                            <a href="/smart/promotion/folder?filter=${filter}&sort=${sort}&page=${pageStart - 1}"></a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="${pageStart}" end="${pageEnd}" var="pageNum">
                                        <li>
                                            <a href="/smart/promotion/folder?filter=${filter}&sort=${sort}&page=${pageNum}">${pageNum}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${next}">
                                        <li>
                                            <a href="/smart/promotion/folder?filter=${filter}&sort=${sort}&page=${pageEnd + 1}"></a>
                                        </li>
                                    </c:if>
                                </c:when>

                                <c:when test="${category eq 'chargeFolder'}">
                                    <c:if test="${prev}">
                                        <li>
                                            <a href="/smart/charge/folder?filter=${filter}&sort=${sort}&page=${pageStart - 1}"></a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="${pageStart}" end="${pageEnd}" var="pageNum">
                                        <li>
                                            <a href="/smart/charge/folder?filter=${filter}&sort=${sort}&page=${pageNum}">${pageNum}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${next}">
                                        <li>
                                            <a href="/smart/charge/folder?filter=${filter}&sort=${sort}&page=${pageEnd + 1}"></a>
                                        </li>
                                    </c:if>
                                </c:when>

                                <c:when test="${category eq 'snsFolder'}">
                                    <c:if test="${prev}">
                                        <li>
                                            <a href="/smart/sns/folder?filter=${filter}&sort=${sort}&page=${pageStart - 1}"></a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="${pageStart}" end="${pageEnd}" var="pageNum">
                                        <li>
                                            <a href="/smart/sns/folder?filter=${filter}&sort=${sort}&page=${pageNum}">${pageNum}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${next}">
                                        <li>
                                            <a href="/smart/sns/folder?filter=${filter}&sort=${sort}&page=${pageEnd + 1}"></a>
                                        </li>
                                    </c:if>
                                </c:when>
                            </c:choose>
                        </ul>
                    </div>
                    <!-- ======= END 페이징 ======= -->

                </div><!-- End blog entries list -->
				<div class="col-lg-4">
                <div class="sidebar">

                        <h3 class="sidebar-title">Search</h3>
                         <form method="post">
			             <div class="sidebar-item search-form">
			                 
			                      <select name="search_option">
				                  	<option value="send_email">이메일 주소</option>
				                  	<option value="title">제목</option>
				                  	<option value="content">내용</option>
				                  </select>
				                  <br>
				                  <input type="text" name="search_content">
				                  <button type="submit" onclick= "javascript: form.action='/receive/receiveSearch'"><i class="bi bi-search"></i></button>
			                 
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

<%-- AXIOS --%>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

<!-- Template Main JS File -->
<script src="/assets/js/receive.js"></script>
<script src="/assets/js/main.js"></script>

</body>
</html>