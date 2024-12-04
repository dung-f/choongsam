<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
    	margin-top: 184px; 
	}

    .main_container {
        margin-top: 140px; /* 헤더 높이에 맞게 마진 설정 */
        margin-bottom: 60px; /* 푸터 높이에 맞게 마진 설정 */
        margin-left: 100px;
        margin-right: 100px;
        padding: 20px; /* 콘텐츠 여백 */
        text-align: center; /* 가운데 정렬 */
    }
    
    hr {
	    width: 400px; /* 원하는 너비 */
	    margin: 0 auto; /* 자동 마진으로 가운데 정렬 */
	}

    .login_section {
        /* 추가 스타일을 원하면 여기에 작성 */
    }

    .select {
        width: 250px;
        height: 33px;
        padding: 5px 10px 5px 10px;
        outline: 0 none;
    }

    .select option {
        background: white;
        color: black;
        padding: 3px 0;
    }
    
    input[type="text"], input[type="password"] {
    	width: 205px;
        height: 22px;
        padding: 5px 30px 5px 10px;
    }
    
    .find a {
        text-decoration: none;
        color: #BCBCBC;
        font-size: 15px

     }
     
     #btnfindId {
		width: 250px;
        height: 36px;
        padding: 5px 10px 5px 10px;
        background-color: #00664F;
        color: white;
        border: 1px solid #00664F;
	}
        
</style>

</head>
<body>
        <header>
        	<%@ include file="../header.jsp" %>
        </header>
        
        <main>
			
		  <form action="findIdResult" method="post">
	        <div class="main_container" >
			<h2 style="color: #00664F ">아이디 찾기</h2>
			<hr style="width: 400px; margin: 0 auto;">
			<br>
			<p>
	            <div class="login_section">
					<input type="text" name="user_name" placeholder="이름" required="required">
					<p>
					<input type="text" name="email" placeholder="이메일 주소" required="required">			
				<br>
				<br>				
				<input id="btnfindId" type="submit" value="아이디 찾기">				
	            </div>
	            
	        </div>
	      </form>
		</main>
    </body>
    <footer>
        <%@ include file="../footer.jsp" %>
    </footer>
</html>
