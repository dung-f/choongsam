<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../headerGreen.jsp" %>
<%@ include file="../myPageNav.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자 - 사용자 정보 수정</title>
<!-- jQuery 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 스타일링 및 모달 -->
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f6f9;
        color: #333;
        margin: 0;
        padding: 0;
    }



    main {
        padding: 20px;
        max-width: 1200px;
        margin: 0 auto;
        padding: 80px;
    }

    .search-container {
        text-align: right;
        margin-bottom: 20px;
        
    }

    .search-container input {
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
        width: 300px;
    }

    .search-container button {
        padding: 10px 20px;
        font-size: 16px;
        background-color: #236147;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-left: 10px;
    }

    .search-container button:hover {
        background-color: #45a049;
    }

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background-color: #fff;
    border-radius: 10px;
    overflow: hidden;
}

th, td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid #ddd;
    word-wrap: break-word;  /* 긴 텍스트 줄바꿈 */
    overflow: hidden;       /* 텍스트가 너무 길 경우 숨기기 */
    text-overflow: ellipsis; /* 텍스트가 길면 '...'으로 표시 */
}

/* 테이블 헤더 스타일 */
th {
    background-color: #f2f2f2;
    color: #333;
    width: 150px; /* 고정된 너비 */
    height: 50px; /* 고정된 높이 */
}

/* 테이블 데이터 셀 스타일 */
td {
    height: 50px; /* 고정된 높이 */
    max-width: 150px; /* 고정된 너비 */
}

/* 링크 스타일 */
td a {
    color: #236147;
    text-decoration: none;
    font-weight: bold;
}

td a:hover {
    text-decoration: underline;
}
    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }

    .pagination a, .pagination .current {
        padding: 1px 5px;
        margin: 0 5px;
        background-color: white;
        color: black;
        text-decoration: none;
        border-radius: 5px;
        align-items: center; 
        justify-content: center;
    }

    .pagination .current {
        background-color: gray;
        pointer-events: none;
    }

    .pagination a:hover {
        background-color: gray;
    }

    /* 기본적인 모달 스타일 */
    #editModal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        background-color: rgba(0, 0, 0, 0.5);
        width: 60%;
        max-width: 600px;
        padding: 20px;
        border-radius: 10px;
    }

    .modal-content {
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .close {
        color: #aaa;
        font-size: 30px;
        font-weight: bold;
        float: right;
        cursor: pointer;
    }

    .close:hover,
    .close:focus {
        color: #000;
        text-decoration: none;
    }

    .modal-content h2 {
        text-align: center;
        margin-bottom: 20px;
        color: #333;
    }

    .modal-content form table {
        width: 100%;
        margin-bottom: 20px;
    }

    .modal-content table th,
    .modal-content table td {
        padding: 10px;
    }

    .modal-content input[type="text"],
    .modal-content input[type="email"] {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-top: 5px;
    }

    .modal-content input[type="submit"] {
        width: 100%;
        padding: 10px;
        background-color: #236147;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
    }

    .modal-content input[type="submit"]:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>

<main>
    <h2 style="margin-top: 100px;">회원정보수정</h2>
    <div class="search-container">
        <form action="/view_Hjh/updateProfileAdmin" method="get" id="searchForm">
            <input type="text" name="keyword" placeholder="아이디 or 이름" />
            <button type="submit">검색</button>
        </form>
    </div>

    <!-- 사용자 리스트 테이블 -->
    <table>
        <tr>
            <th>No</th>
            <th>이름</th>
            <th>아이디</th>
            <th>이메일</th>
            <th>주소</th>
            <th>핸드폰 번호</th>
            <th>회원 상태</th>
        </tr>
        <c:forEach var="user" items="${userList}" varStatus="status">
            <tr>
                <td>${(page.currentPage - 1) * page.rowPage + status.index + 1}</td>
                <td><a href="javascript:void(0);" class="editProfile" data-user-id="${user.user_id}" data-user-name="${user.user_name}" data-email="${user.email}" data-address="${user.address}" data-phone="${user.phone_num}" data-birth="${user.birth}">${user.user_name}</a></td>
                <td>${user.user_id}</td>
                <td>${user.email}</td>
                <td>${user.address}</td>
                <td>${user.phone_num}</td>
                <td>
                    <c:choose>
                        <c:when test="${user.USER_STATUS == '1001'}">학생</c:when>
                        <c:when test="${user.USER_STATUS == '1002'}">강사</c:when>
                        <c:otherwise>알 수 없음</c:otherwise> 
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>

    <!-- 페이지네이션 -->
    <div class="pagination">
        <c:if test="${page.startPage > page.pageBlock}">
            <a href="/view_Hjh/updateProfileAdmin?currentPage=${page.startPage - page.pageBlock}&keyword=${keyword}">이전</a>
        </c:if>
        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
            <c:choose>
                <c:when test="${i == page.currentPage}">
                    <span class="current">${i}</span>
                </c:when>
                <c:otherwise>
                    <a href="/view_Hjh/updateProfileAdmin?currentPage=${i}&keyword=${keyword}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${page.endPage < page.totalPage}">
            <a href="/view_Hjh/updateProfileAdmin?currentPage=${page.startPage + page.pageBlock}&keyword=${keyword}">다음</a>
        </c:if>
    </div> 
</main>

<!-- 수정 모달 -->
<div id="editModal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>사용자 정보 수정</h2>
        <form id="editForm" action="/view_Hjh/detailProfileEdit" method="post">
            <input type="hidden" name="user_id" id="user_id">
            <table>
                <tr>
                    <th>이름</th>
                    <td><input type="text" name="user_name" id="user_name" required /></td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td><input type="email" name="email" id="email" required /></td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td><input type="text" name="address" id="address" required /></td>
                </tr>
                <tr>
                    <th>핸드폰 번호</th>
                    <td><input type="text" name="phone_num" id="phone_num" required /></td>
                </tr>
                <tr>
                    <th>생년월일</th>
                    <td><input type="text" name="birth" id="birth" required /></td>
                </tr>
            </table>
            <input type="submit" value="수정하기">
        </form>
    </div>
</div>

<!-- JavaScript 코드 -->
<script>
$(document).ready(function() {
    // 이름 클릭 시 모달 열기
    $('.editProfile').on('click', function() {
        var userId = $(this).data('user-id');
        var userName = $(this).data('user-name');
        var email = $(this).data('email');
        var address = $(this).data('address');
        var phone = $(this).data('phone');
        var birth = $(this).data('birth');
        
        // 모달에 값 세팅
        $('#user_id').val(userId);
        $('#user_name').val(userName);
        $('#email').val(email);
        $('#address').val(address);
        $('#phone_num').val(phone);
        $('#birth').val(birth);

        // 모달 표시
        $('#editModal').fadeIn();
    });

    // 닫기 버튼 클릭 시 모달 닫기
    $('.close').on('click', function() {
        $('#editModal').fadeOut();
    });

    // 창 밖 클릭 시 모달 닫기
    $(window).on('click', function(event) {
        if ($(event.target).is('#editModal')) {
            $('#editModal').fadeOut();
        }
    });
});
</script>

</body>
</html>
