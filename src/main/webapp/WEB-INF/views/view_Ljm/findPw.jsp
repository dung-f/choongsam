<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<style type="text/css">
        body {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif;
            overflow: hidden; /* 스크롤 없애기 */
        }

        header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background-color: white;
            z-index: 1000;
            border-bottom: 1px solid #ccc;
        }

        footer {	  
    	margin-top: 184px; 
	    padding: 10px 0; /* 푸터 내 패딩 추가 (옵션) */
	}

        .main_container {
            margin-top: 140px;
            margin-bottom: 60px;
            margin-left: auto;
            margin-right: auto;
            padding: 20px;
            width: 600px; /* 최대 너비 설정 */
            text-align: center;
        }

        hr {
            width: 400px;
            margin: 0 auto;
        }

        .login_section {
            flex-direction: column; /* 세로로 나열 */
            align-items: center; /* 가로로 중앙 정렬 */
            width: 100%;
        }

        .input-wrapper {
            margin: 10px 0; /* 각 입력 필드 간의 여백 */
            display: flex;
            align-items: center; /* 수직 정렬 */
            justify-content: center; /* 수평 정렬 */
        }

        input[type="text"], input[type="password"] {
            width: 205px;
            height: 22px;
            padding: 5px 30px 5px 10px;
            margin-right: 10px; /* 버튼과의 간격 */
        }

        #btnfindPw {
            width: 250px;
            height: 36px;
            padding: 5px 10px;
            background-color: #00664F;
            color: white;
            border: 1px solid #00664F;
            position: relative;
            top: -30px; /* 30px로 더 위로 올려보세요 */
        }

        #btnfindPw:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

</script>
</head>
<body>
    <header>
        <%@ include file="../header.jsp" %>
    </header>

    <main>
        <form action="findPwResult" method="post" id="formId">
            <div class="main_container">
                <h2 style="color: #00664F">비밀번호 찾기</h2>
                <hr style="width: 400px; margin: 0 auto;">
                <br>
                <div class="login_section">
                    <!-- 아이디 입력 -->
                    <div class="input-wrapper">
                        <input type="text" id="user_id" name="user_id" placeholder="아이디" required="required">
                    </div>
                    <!-- 이메일 입력과 임시 비밀번호 발급 버튼 -->
                    <div class="input-wrapper">
                        <input type="text" id="email" name="email" placeholder="이메일 주소" required="required">
                    </div>

                    <br><br>
                    <!-- 임시 비밀번호 발급 버튼 -->
                    <input id="btnfindPw" type="submit" value="임시 비밀번호 발급"  style="margin-right: 10px;">
                </div>
            </div>
        </form>
    </main>
</body>
<footer>
        <%@ include file="../footer.jsp" %>
    </footer>
</html>
