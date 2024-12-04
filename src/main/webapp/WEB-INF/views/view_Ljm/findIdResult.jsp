<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<style type="text/css">
	 body {
        margin: 0;
        padding: 0;
        font-family: 'Noto Sans KR', sans-serif;
    }

    header {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        background-color: white; /* 배경색을 추가하여 가려지지 않게 함 */
        z-index: 1000; /* 다른 요소보다 위에 위치하도록 */
        border-bottom: 1px solid #ccc; /* 헤더 아래쪽 경계선 */
    }

    footer {	  
    	margin-top: 30px;
	}

    .main_container {
        margin-top: 110px; /* 헤더 높이에 맞게 마진 설정 */
        margin-bottom: 60px; /* 푸터 높이에 맞게 마진 설정 */
        margin-left: 100px;
        margin-right: 100px;
        padding: 20px; /* 콘텐츠 여백 */
        text-align: center; /* 가운데 정렬 */
    }
    
    #btnLogin {
		width: 250px;
        height: 36px;
        padding: 5px 10px 5px 10px;
        background-color: #00664F;
        color: white;
        border: 1px solid #00664F;
        text-align: center;
	}
</style>
</head>
<body>
	<header>
        <%@ include file="../header.jsp" %>
    </header>
    
    <main>
      <div class="main_container">
    	<form action="findIdResult" method="post">
		  
	        <h2 style="color: #00664F;">아이디 찾기</h2>
	        <hr style="width: 400px; margin: 0 auto;">
	        <br>
	
	        <!-- 사용자 입력 정보 다시 보여주기 -->
	        <div class="result_section">
			    <h3>입력하신 정보</h3>
			    <p><strong>이름:</strong> ${user_name}</p>
			    <p><strong>이메일:</strong> ${email.substring(0, 3)}***@${email.split('@')[1]}</p>
			</div>
	
	        <br>
	
	        <!-- 아이디 찾기 결과 -->
	        <div class="result_message">
	            <p style="font-size: 18px; font-weight: bold; color: #00664F;">
	                ${userCheckMessage}
	            </p>
	
	            <c:if test="${not empty find_id}">
	                <p style="font-size: 16px; color: #00664F;">
	                    <strong>아이디: </strong>${find_id}
	                </p>
	            </c:if>
	        </div>	
	        <br>		              	      
	    </form>
	    	<form action="loginForm" method="post">
		    	<div class="button_section">
			        <input id="btnLogin" type=submit value="로그인 화면으로">
			    </div>  	
		    </form>
	      </div>
    </main>
</body>
<footer>
        <%@ include file="../footer.jsp" %>
    </footer>
</html>