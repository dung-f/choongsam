<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
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

    .main_container {
        margin-top: 140px; /* 헤더 높이에 맞게 마진 설정 */
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
     
     #btnLogin {
		width: 250px;
        height: 36px;
        padding: 5px 10px 5px 10px;
        background-color: #00664F;
        color: white;
        border: 1px solid #00664F;
	}
	
	#btnAdminLogin {
		width: 250px;
        height: 36px;
        padding: 5px 10px 5px 10px;
        background-color: #FFFFFF;
        color: white;
        border: 1px solid #FFFFFF;
	}
	
	.errMessage{
		color: red;
		font-size: 12px;
		margin: 5px 0;
	}
	.container{
	margin: 200px 0;
	}
        
</style>

<script type="text/javascript">

</script>
</head>
<body>
        <header>
        	<%@ include file="../header.jsp" %>
        </header>
        
        <main>
		
		<div class="container">	
		<form action="login" method="post" id="myForm">
		  <div class="main_container">
		    <h2 style="color: #00664F ">로그인</h2>
		    <hr style="width: 400px; margin: 0 auto;">
		    <br>
		    <p>
		      <div class="login_section">
		        <c:if test="${not empty loginError}">
		          <p class="errMessage">${loginError}</p>
		        </c:if>
		        
		        <c:if test="${not empty loginError2}">
		          <p class="errMessage">${loginError2}</p>
		        </c:if>
		        <p>
		          <select name="user_status" class="select" id="user_status">
		            <option disabled selected>로그인 할 회원 유형을 선택하세요</option>
		            <option value="1001">학생</option>
		            <option value="1002">강사</option>
		          </select>
		        </p>
		        <p>
		          <input type="text" name="user_id" value="${user_id }" placeholder="아이디">
		        </p>		        
		        <p>
		        <input type="hidden" id="hashed_password" name="hashed_password" />
		          <input type="password" id="password" name="password" placeholder="비밀번호">
		        </p>
		        <p>
		          <input id="btnLogin" type="submit" value="로그인">
		        </p>
		
		        <div class="find">
		          <a href="findId">아이디 찾기 | </a>
		          <a href="findPw">비밀번호 찾기 | </a>
		          <a href="signup1">회원가입</a>
		        </div>
		      </div>
		    </div>
		  </form>		  		  
		  <br>
		  <br>
		  <br>		  
		  </div>
	</main>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/core.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/sha256.js"></script>
<script> 
    document.addEventListener('DOMContentLoaded', function() {
        var form = document.getElementById('myForm');
        var selectElement = document.getElementById('user_status');

        // 폼 제출 시 처리
        form.addEventListener('submit', function(event) {
            // 비밀번호 입력값 가져오기
            var passwordField = document.getElementById("password");
            var password = passwordField.value;

            // 비밀번호를 SHA-256으로 암호화
            const passhash = CryptoJS.SHA256(password).toString(CryptoJS.enc.Hex);
            console.log("암호화된 비밀번호 해시값:", passhash);

            // 해시값을 hidden 필드에 설정
            var hashedPasswordField = document.getElementById('hashed_password');
            hashedPasswordField.value = passhash;

            // 사용자가 회원 유형을 선택하지 않았다면
            if (selectElement.selectedIndex === 0) {  // 첫 번째 option은 disabled로 선택 불가
                event.preventDefault();  // 폼 제출 막기
                alert('회원 유형을 선택해주세요');  // 경고 메시지 띄우기
            }
        });
    });
</script>
</body>
		<footer>
			<div class="adminLoginSection" style="text-align: right; margin-top: 47px;">
		  
		  </div>
            <%@ include file="../footer.jsp" %>
        </footer>
</html>
