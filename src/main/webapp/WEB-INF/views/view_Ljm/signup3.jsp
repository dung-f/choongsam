<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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
    	margin-top: 97px;
	}

    .main_container {
        margin-top: 120px; /* 헤더 높이에 맞게 마진 설정 */
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

    .signup_section {
	    display: flex;          
	    justify-content: center; /* 자식 요소를 가운데 정렬 */
	    width: 100%;           /* 전체 너비 사용 */   
    }
	
	.signup_step {
	    display: flex;          
	    align-items: center;   
	    height: 100px;    
	    
	}
	
	.step1, .step2, .step3 {
	    width: 270px;          
	    height: 35px;         
	    background-color: #00664F; /* step1의 배경색 */
	    color: white;
	    text-align: center;    
	    line-height: 35px;     
	    border: 1px solid #00664F;
	    margin: 0; /* 마진 제거 */
	}
	
	.step1, .step2 {
	    background-color: #FFFFFF;
	    color: #BCBCBC;
	    border: 1px solid #BCBCBC;
	}
	
	.select {
        width: 250px;
        height: 33px;
        padding: 5px 10px 5px 10px;
        outline: 0 none;
        margin-left: 20px;
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
        
        margin-left: 20px;
    }
    
    .join_write {
    	 display: flex;           /* Flexbox 사용 */
	    flex-direction: column;  /* 세로 방향으로 정렬 */
	    align-items: center;     /* 자식 요소를 가운데 정렬 */
	    text-align: left;        /* 테이블 셀 안의 텍스트는 왼쪽 정렬 */
	}
	
	tr {
		margin-bottom: 20px;
	}
	
     
     #btnNext {
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
			
		  <form>
	        <div class="main_container">
			<h2 style="color: #00664F ">회원가입</h2>
			<hr style="width: 400px; margin: 0 auto;">
			<br>
			<p>
	           <div class="signup_section">
	            	<div class="signup_step">
	            		<div class="step1">이용약관</div>
	            		<div class="step2">정보입력</div>
	            		<div class="step3">가입완료</div>
	           		</div>			
	           </div>	
          	
          		<h4 style="margin-top: 30px;">회원가입이 완료되었습니다</h4>
	       </div>
	        	
	        	<div class="btnSection" align="center" style="margin-bottom: 20px;">
					<input id="btnNext" type="button" onclick="location.href='loginForm'"value="로그인 화면으로">
	            </div>
	      </form>
		</main>
    </body>
    
    <footer>
        <%@ include file="../footer.jsp" %>
    </footer>
</html>