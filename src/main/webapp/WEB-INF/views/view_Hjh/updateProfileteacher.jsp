<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../headerGreen.jsp" %>
<%@ include file="../myPageNav.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>사용자 정보 수정</title>
    <style type="text/css">
        #profileUpdatePage {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            font-family: Arial, sans-serif;
        }

        #profileUpdatePage form {
            width: 100%;
            max-width: 600px;
            background-color: #fff;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 1);
            margin-top: 20px;
            margin-right: 200px;
        }

        #profileUpdatePage h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #236147;
        }

        #profileUpdatePage img {
            width: 210px;
            height: 230px;
            object-fit: cover;
            border-radius: 10%;
            margin-bottom: 10px;
        }

        #profileUpdatePage input[type="file"] {
            display: block; /* 보이도록 설정 */
        }

        #profileUpdatePage label {
            font-size: 16px;
            margin-bottom: 5px;
            color: #333;
            font-weight: bold;
        }

        #profileUpdatePage input[type="text"],
        #profileUpdatePage input[type="date"],
        #profileUpdatePage input[type="email"],
        #profileUpdatePage input[type="file"],
        #profileUpdatePage input[type="hidden"],
        #profileUpdatePage button {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
        }

        #profileUpdatePage button {
            background-color: #00664F;
            color: white;
            border: none;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        #profileUpdatePage button:hover {
            background-color: #004d3b;
        }

        #profileUpdatePage .input-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        #profileUpdatePage .input-wrapper {
            width: 48%; /* 두 요소를 50%로 설정 */
        }

        #profileUpdatePage .input-wrapper input {
            font-size: 16px;
        }

        #profileUpdatePage .address-btn {
            width: auto;
            background-color: #ddd;
            color: #333;
            cursor: pointer;
            padding: 8px 16px;
            font-size: 14px;
            border-radius: 4px;
        }

        #profileUpdatePage .address-btn:hover {
            background-color: #236147;
            color: white;
        }

        #profileUpdatePage .file-input-wrapper {
            text-align: center;
        }

        #profileUpdatePage .file-input-wrapper input {
            font-size: 14px;
        }

        #profileUpdatePage .hidden {
            display: none;
        }

        #profileUpdatePage .preview-image {
            margin-top: 15px;
            text-align: center;
        }

        #profileUpdatePage .preview-image img {
            max-width: 150px;
            border-radius: 50%;
        }
    </style>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function previewImage(event) {
            const file = event.target.files[0];
            const reader = new FileReader();
            reader.onload = function(e) {
                const img = document.getElementById('profilePreview');
                img.src = e.target.result;
                img.style.display = 'block'; // 이미지를 보이게 설정
            }
            if (file) {
                reader.readAsDataURL(file);
            }
        }

        function formatPhoneNumber(input) {
            let value = input.value.replace(/[^0-9]/g, "");  // 숫자만 남기기
            if (value.length < 4) {
                input.value = value;  // 3자리까지만 입력
            } else if (value.length < 7) {
                input.value = value.slice(0, 3) + "-" + value.slice(3);  // 3-4자리
            } else if (value.length < 11) {
                input.value = value.slice(0, 3) + "-" + value.slice(3, 7) + "-" + value.slice(7);  // 3-4-4자리
            } else {
                input.value = value.slice(0, 3) + "-" + value.slice(3, 7) + "-" + value.slice(7, 11);  // 3-4-4자리까지
            }
        }

        function findAddr() {
            new daum.Postcode({
                oncomplete: function (data) {
                    var roadAddr = data.roadAddress;
                    document.getElementById('address').value = roadAddr;
                    document.getElementById('address').focus();
                }
            }).open();
        }
    </script>
</head>

<body>
    <div id="profileUpdatePage">
        <h2>사용자 정보 수정</h2>
        <form action="updateUserInfo1" method="post" enctype="multipart/form-data">
            <!-- 프로필 주소와 이름을 히든 필드로 전달 -->
            <input type="hidden" value="${profile_addr}" name="profile_addr">
            <input type="hidden" value="${profile_name}" name="profile_name">

            <!-- 프로필 이미지 -->
            <div class="file-input-wrapper">
                <img id="profilePreview" src="${profile_addr}" alt="${profile_name}" class="preview-image">
                <input type="file" id="profileImage" name="profileImage" accept="image/*" onchange="previewImage(event)">
            </div>

            <!-- 사용자 아이디와 이름 -->
            <div class="input-group">
                <div class="input-wrapper">
                    <label for="userId">아이디:</label>
                    <!-- 아이디는 읽기 전용으로 표시 -->
                    <input type="text" id="userId" name="user_id" value="${user_id}" readonly>
                </div>
                <div class="input-wrapper">
                    <label for="userName">이름:</label>
                    <input type="text" id="userName" name="user_name" value="${user_name}" required>
                </div>
            </div>

            <!-- 생년월일과 전화번호 -->
            <div class="input-group">
                <div class="input-wrapper">
                    <label for="birthDate">생년월일:</label>
                    <input type="date" id="birthDate" name="birth" value="${birth}" required>
                </div>
                <div class="input-wrapper">
                    <label for="phone">전화번호:</label>
                    <input type="text" id="phone" name="phone_num" value="${phone_num}" oninput="formatPhoneNumber(this)" placeholder="010-xxxx-xxxx" required>
                </div>
            </div>

            <!-- 주소와 이메일 -->
            <div class="input-group">
                <div class="input-wrapper">
                    <label for="address">주소:</label>
                    <input type="text" id="address" name="address" value="${address}" placeholder="주소 입력" required>
                    <button type="button" class="address-btn" onclick="findAddr()">주소 찾기</button>
                </div>
                <div class="input-wrapper">
                    <label for="email">이메일:</label>
                    <input type="email" id="email" name="email" value="${email}" required>
                </div>
            </div>

            <button type="submit">저장</button>
        </form>
    </div>
</body>

</html>
