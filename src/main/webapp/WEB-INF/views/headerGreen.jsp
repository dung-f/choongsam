<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
        body{
            margin: 0;
            padding: 0;
        }

        .header__ {
        	position:relative;
		    display: flex;
		    align-items: center; /* 수직 중앙 정렬 */
		    width: 1920px;
		    background-color: #00664F;
		    height: 70px; /* 헤더 전체 높이 */
		    font-size: 20px;
		    color: white;
		    z-index: 3;
		}
		
		.header__color {
		    width: 100%;
		}
		
		.header__nav {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    padding: 0 50px;
		    font-weight: bold;
		    height: inherit; /* 부모 높이와 동일하게 설정 */
		}



        .header__navBar a {
            text-decoration: none;
            color: white;
            width: 100px;
            margin: 0 125px;
        }
        
        .header_login a, .header_join a, .header_logout a {
        	text-decoration: none;
            color: white;
        }
        
        .header__logo {
        	display: flex;            /* Flexbox 사용 */
	    	align-items: center;     /* 수직 중앙 정렬 */
	    	
        }
       
       #logo{
       	height: 50px;
       }
       

    </style>
</head>
<body>
    <div class="header__">
        <div class="header__color">
        <div class="header__nav">
        <div class="header__logo"><a href="/">
        	<img alt="로고" src="<%=request.getContextPath()%>/image/headerLogoGreen.png" id="logo">
        </a></div>
        <div class="header__navBar">
           <a href="/courseApplyList">수강신청</a>
			<c:choose>
			    <c:when test="${usertype == 1001}">
			        <a href="../Jhe/myLecture?user=${user}">마이페이지</a>
			    </c:when>
			    <c:when test="${usertype == 1002}">
			        <a href="/view_Hjh/gangyilistTeacher?user_seq=${user_seq}'">마이페이지</a>
			    </c:when>
			    <c:when test="${usertype == 1003}">
			        <a href="/view_Hjh/updateProfileAdmin?user=${user}">마이페이지</a>
			    </c:when>			    
			    <c:otherwise>
			        <a href="/view_Ljm/loginForm">마이페이지</a>
			    </c:otherwise>
			</c:choose>
			
            <a href="/api/notice">공지사항</a>
           <c:choose>
			    <c:when test="${usertype == 1001}">
			         <a href="/asks/new">문의사항</a>
			    </c:when>
			    <c:when test="${usertype == 1002}">
			         <a href="/asks/new">문의사항</a>
			    </c:when>
			    <c:when test="${usertype == 1003}">
			         <a href="/asks/new">문의사항</a>
			    </c:when>
			    <c:otherwise>
			        <a href="/view_Ljm/loginForm">문의사항</a>
			    </c:otherwise>
			</c:choose>
        </div>
        
            <!-- 로그인 여부에 따라 버튼 표시 -->
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <!-- 로그인된 경우: '로그인', '회원가입' 버튼을 숨기고 '로그아웃' 버튼을 표시 -->
                    <div class="header_logout"><a href="/view_Ljm/logout">로그아웃</a></div>
                </c:when>
                <c:otherwise>
                    <!-- 로그인되지 않은 경우: '로그인', '회원가입' 버튼 표시 -->
                    <div class="header_login"><a href="/view_Ljm/loginForm">로그인</a></div>
                    <div class="header_join"><a href="/view_Ljm/signup1">회원가입</a></div>
                </c:otherwise>
            </c:choose>
  
        </div>
        
        </div>
        
    </div>
</body>
</html>