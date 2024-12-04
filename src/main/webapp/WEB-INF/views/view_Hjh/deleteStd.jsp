<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../headerGreen.jsp" %>
<%@ include file="../myPageNav.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경</title>
    <style>
        /* 기본 폰트와 배경 설정 */
        body {
            font-family: 'Arial', sans-serif;
            background-color: white;
            margin: 0;
            padding: 0;
        }

        /* 컨테이너 스타일 */
        .container {
            max-width: 500px;
            margin: 150px auto 100px auto;  /* 상단에 더 많은 여백 추가 */
            padding: 100px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 1);
        }

        .form-container h2 {
            text-align: center;
            color: #333;
            font-size: 26px;
            margin-bottom: 20px;
        }

        /* 라벨 스타일 */
        .form-container label {
            font-size: 16px;
            color: #555;
            margin-bottom: 8px;
            display: block;
        }

        /* 입력창 스타일 */
        .form-container input {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }

        /* 입력창 포커스 효과 */
        .form-container input:focus {
            border-color: #4CAF50;
            outline: none;
        }

        /* 버튼 스타일 */
        .form-container button {
            width: 100%;
            padding: 14px;
            background-color: #f28a8c;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-container button:hover {
            background-color: #45a049;
        }

        /* 비밀번호 변경 메시지 */
        .form-container .msg {
            color: #ff4d4d;
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        /* 사용자 아이디 표시 */
        .form-container .user-id {
            margin-bottom: 20px;
            font-size: 16px;
            color: #666;
        }

        .form-container .user-id p {
            margin: 0;
        }

        /* 반응형 디자인 */
        @media (max-width: 600px) {
            .container {
                width: 90%;
                padding: 20px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="form-container">
            <h2>회원 탈퇴</h2>

            <form action="deleteStd1" method="post">
                
                <div class="user-id">
                    <input type="hidden" id="user" name="user_id" value="${user_id}" readonly />
                    
                </div>

                <!-- 비밀번호 입력 필드 -->
                <div style="padding-top: 30px;">
                    <label for="password">비밀번호:</label>
                    <input type="password" id="password" name="password" required />
                </div>

                <!-- 제출 버튼 -->
                <div>
                    <button type="submit">탈퇴하기</button>
                </div>
            </form>

            <!-- 탈퇴 실패 메시지 출력 -->
            <p class="msg">${msg}</p>
        </div>
    </div>

</body>
</html>
