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
		    position: relative; /* position 변경 */
		    width: 100%;
		    background-color: white;
		    height: 70px;
		    font-size: 20px;
		    color: white;
		    z-index: 1000; /* 다른 요소 위로 올라오게 함 */
		    padding-bottom: 30px; /* 헤더 아래에 여백 추가 */
		}


        .header__color{
            margin: 0;
            padding: 0;
            background-color: #00664F;
            width: 1920px;
            height: 28px;
        }
        
        .header__nav{
            display: flex;
            justify-content: space-between;;
            align-items: center;
            padding: 0 50px;
            font-weight: bold;
            height: 70px;
            border-bottom: 0.1px solid rgb(186, 186, 186);
        }


        .header__navBar a {
            text-decoration: none;
            color: black;
            width: 100px;
            margin: 0 125px;
        }
        
        .header_login a, .header_join a, .header_logout a {
        	text-decoration: none;
            color: black;
        }
        
        .header__logo {
        	display: flex;            /* Flexbox 사용 */
	    	align-items: center;     /* 수직 중앙 정렬 */
	    	
        }
       
       #mainLogo{
       		height: 50px;
       }
       


        .header_adminLogin a {
       		text-decoration: none;
            color: white;
            width: 80px;
	       	height: 18px;
	       	color: white;
	       	background-color: #00664F;
	       	border: 1px solid #00664F;
	       	font-size: 9px;
	       	margin-right: 15px;
	       	border-radius: 2px;
	       	text-align: right;
       }

       
       

    </style>
</head>
<body>
   <div class="header__">
        <div class="header__color" style="text-align: right;">
          <c:choose>
          	<c:when test="${empty sessionScope.user}">
		  			<div class="header_adminLogin"><a href="/view_Ljm/adminLoginForm">관리자 로그인</a></div>
          	</c:when>
          	<c:otherwise>
                    
            </c:otherwise>
          </c:choose>

        	
        </div>
        <div class="header__nav">
        <div class="header__logo">
        	<a href="/">
        		<img alt="로고" src="../image/headerLogoWhite.png" id="mainLogo">
        	</a>
        </div>
        <div class="header__navBar">
            <a href="/courseApplyList">수강신청</a>
		<c:choose>
		    <c:when test="${usertype == 1001}">
		        <a href="../Jhe/myLecture?user=${user}&user_seq=${user_seq}">마이페이지</a>
		    </c:when>
		    <c:when test="${usertype == 1002}">
		        <a href="/view_Hjh/gangyilistTeacher?user_seq=${user_seq}'">마이페이지</a>
		    </c:when>
		    <c:when test="${usertype == 1003}">
		        <a href="/view_Hjh/updateProfileAdmin?user=${user}&user_seq=${user_seq}">관리자페이지</a>
		    </c:when>
		    <c:otherwise>
		        <a href="/view_Ljm/loginForm?user_seq=${user_seq}">마이페이지</a>
		    </c:otherwise>
		</c:choose>
]
			
            <a href="/api/notice">공지사항</a>
            <c:choose>
			    <c:when test="${usertype == 1001}">
			         <a href="/asks/new">문의사항</a>문의사항</a>
			    </c:when>
			    <c:when test="${usertype == 1002}">
			         <a href="/asks/new">문의사항</a>문의사항</a>
			    </c:when>
			    <c:when test="${usertype == 1003}">
			         <a href="/asks/new">문의사항</a>문의사항</a>
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
</body>
</html>