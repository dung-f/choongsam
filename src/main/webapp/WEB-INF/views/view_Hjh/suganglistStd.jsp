<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../headerGreen.jsp" %>
<%@ include file="../myPageNav.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>수강신청 목록</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: white;
            margin: 0;
            padding: 0;
        }

        main {
            margin-left: -180px; /* 내비게이션 바 너비 고려 */
            padding: 150px 200px;
            background-color: white;
            
        }

        h2 {
            color: #333;
            font-size: 28px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        /* 테이블 스타일 */
        table {
            width: 1300px;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        td {
            height: 35px;
        }

        th {
            background-color: #00664F;
            color: white;
            font-size: 16px;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        /* 수납하기 버튼 스타일 */
        .openModalButton {
            background-color: #FF4C4C;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        .openModalButton:hover {
            background-color: #218838;
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination a, .pagination .current {
            padding: 10px 15px;
            margin: 0 5px;
            background-color: #fff;
            color: #00664F;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            border: 1px solid #ddd;
        }

        .pagination .current {
            background-color: #00664F;
            color: white;
            pointer-events: none;
        }

        .pagination a:hover {
            background-color: #45a049;
        }

        /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            padding-top: 220px;
        }

        .modal-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            width: 400px;
            margin: auto;
            text-align: center;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        .modal-content h2 {
            font-size: 20px;
            color: #333;
            margin-bottom: 20px;
        }

        .modal-content p {
            font-size: 16px;
            color: #555;
            margin-bottom: 20px;
        }

        .timer {
            font-size: 18px;
            color: red;
            font-weight: bold;
        }

        button[type="submit"] {
            background-color: #00664F;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button[type="submit"]:hover {
            background-color: #218838;
        }

        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
        }

		.lctrName {
			text-align: left;
		}
    </style>
</head>
<body>

<main>
<h2>수강신청 목록</h2>

<!-- 수강신청 리스트 테이블 -->
<table>
    <thead>
        <tr>
            
            <th>번호</th>
            <th>대면/온라인</th>
            <th>강의명</th>
            <th>강사명</th>
            <th>신청일</th>
            <th>수강상태</th>
            <th>결제</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="course" items="${sugangStu}" varStatus="status">
            <tr>
            	
                <td>${status.index + 1}</td>
                <td>
                 <c:choose>
                     <c:when test="${course.ONOFF == '7001'}">대면</c:when>
                     <c:when test="${course.ONOFF == '7002'}">온라인</c:when>
                     <c:otherwise>알 수 없음</c:otherwise>
                 </c:choose>
                </td>
                <td class="lctrName">${course.LCTR_NAME}</td>
                <td>${course.prof_name}</td>
                <td>${course.aply_date}</td>
                <td>
                    <c:choose>
                        <c:when test="${course.reg_state == '2001'}">수강 신청중</c:when>
                        <c:when test="${course.reg_state == '2002'}">수강 신청완료</c:when>
                        <c:when test="${course.reg_state == '2003'}">수강중</c:when>
                        <c:when test="${course.reg_state == '2004'}">수강 완료</c:when>
                        <c:otherwise>알 수 없음</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${course.pay_state == 'Y'}">
                            <span>${course.pay_date}</span>
                        </c:when>
                        <c:when test="${(course.pay_state == 'N' or course.pay_state == null) and course.reg_state == '2001'}">
                         <button class="openModalButton" data-lctr-id="${course.lctr_id}" data-user-seq="${course.user_seq}" data-user-cnt="${course.CLASS_COUNT}" >수납하기</button>
                        </c:when>
                        <c:otherwise>
                            <span>기간만료</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<div class="pagination">
    <c:if test="${page.startPage > page.pageBlock}">
        <a href="/view_Hjh/suganglistStd?currentPage=${page.startPage - page.pageBlock}&keyword=${keyword}">이전</a>
    </c:if>
    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
        <c:choose>
            <c:when test="${i == page.currentPage}">
                <span class="current">${i}</span>
            </c:when>
            <c:otherwise>
                <a href="/view_Hjh/suganglistStd?currentPage=${i}&keyword=${keyword}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:if test="${page.endPage < page.totalPage}">
        <a href="/view_Hjh/suganglistStd?currentPage=${page.startPage + page.pageBlock}&keyword=${keyword}">다음</a>
    </c:if>
</div>

</main>

<!-- 모달 -->
<div id="paymentModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>수납완료 처리</h2>
        <p>QR결제</p>
        <img src="${pageContext.request.contextPath}/chFile/user/QR.png" alt="QR Code" width="200" />
        <p class="timer" id="timer">남은 시간: 60초</p>
        <form id="paymentForm" action="/view_Hjh/updatePayState" method="POST">
        
            <input type="hidden" name="lctr_id" id="lctrId" />
            <input type="hidden" name="user_seq" id="userSeq" />
            <input type="hidden" name="class_count" id="classcount" />
            <button type="submit">수납하기</button>
        </form>
    </div>
</div>

<script>
    // 모달 관련 스크립트
    var modal = document.getElementById("paymentModal");
    var btns = document.querySelectorAll(".openModalButton");
    var span = document.getElementsByClassName("close")[0];
    var timerElement = document.getElementById("timer");
    var countdown;

    btns.forEach(function(btn) {
        btn.onclick = function() {
            var lctrId = this.getAttribute("data-lctr-id");
            var userSeq = this.getAttribute("data-user-seq");
            var classcount = this.getAttribute("data-user-cnt");

            document.getElementById("lctrId").value = lctrId;
            document.getElementById("userSeq").value = userSeq;
            document.getElementById("classcount").value = classcount;

            modal.style.display = "block";

            var timeRemaining = 60;
            timerElement.textContent = "남은 시간: " + timeRemaining + "초";
            
            countdown = setInterval(function() {
                timeRemaining--;
                timerElement.textContent = "남은 시간: " + timeRemaining + "초";

                if (timeRemaining <= 0) {
                    clearInterval(countdown);
                    modal.style.display = "none";
                }
            }, 1000);
        };
    });

    span.onclick = function() {
        modal.style.display = "none";
        clearInterval(countdown);
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
            clearInterval(countdown);
        }
    }
</script>

</body>
</html>
