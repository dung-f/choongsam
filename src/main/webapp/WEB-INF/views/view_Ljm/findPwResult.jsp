<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    	margin-top: 243px;
	}

    .main_container {
        margin-top: 140px;
        margin-bottom: 60px;
        margin-left: 100px;
        margin-right: 100px;
        padding: 20px;
        text-align: center;
    }
    
    button {
        width: 250px;
        height: 36px;
        padding: 5px 10px 5px 10px;
        background-color: #00664F;
        color: white;
        border: 1px solid #00664F;
        text-align: center;
    }

    #btnBack {
        width: 250px;
        height: 36px;
        padding: 5px 10px 5px 10px;
        background-color: #999;
        color: white;
        border: 1px solid #999;
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
            <form action="findPwResult" method="post">
                <h2 style="color: #00664F;">비밀번호 찾기</h2>
                <hr style="width: 400px; margin: 0 auto;">
                <br>

                <!-- 비밀번호 찾기 결과 -->
                <div class="result_message">
                    <p style="font-size: 18px; font-weight: bold; color: #00664F;">
                        ${userCheckMessage}
                    </p>

                    <c:if test="${not empty user_id}">
						<br>
                        <div class="button_section">
                            <a href="/view_Ljm/loginForm">
								<button type="button">로그인 화면으로</button>
							</a>
                        </div>
                    </c:if>

                    <c:if test="${empty user_id}">
                    <br>
                        <div class="button_section">
                            <a href="/view_Ljm/findPw">
								<button type="button">다시 비밀번호 찾기</button>
							</a>
                        </div>
                    </c:if>
                </div>  
            </form>
        </div>
    </main>
</body>
<footer>
        <%@ include file="../footer.jsp" %>
    </footer>
</html>
