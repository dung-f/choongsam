<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../headerGreen.jsp"%>
<%@ include file="../myPageNav.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Lecture List</title>
<style>
/* General Page Styling */
body {
    font-family: 'Roboto', sans-serif;
    background-color: white; /* Light greenish background */
    color: #333;
    margin: 0;
    padding: 0;
    text-align: center;
    line-height: 1.6;
}

main {
	padding: 70px 70px 70px 0;
    margin-left: -50px;
	background-color: white;
}

/* Title Styling */
h2 {
    color: #00664F; /* Deep green */
    margin: 30px 0;
    font-size: 2rem;
    font-weight: 700;
    letter-spacing: 2px;
    text-align: center;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
}

/* Table Styling */
table {
    width: 90%;
    margin: 30px auto;
    border-collapse: collapse;
    background-color: #ffffff;
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
    border-radius: 12px;
    overflow: hidden;
    transform: scale(1);
    transition: transform 0.3s ease-in-out;
}



/* Header row styling */
th {
    background-color: #00664F; /* Deep green */
    color: white;
    padding: 15px;
    font-size: 1.1rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}


/* Data cells styling */
td {
    background-color: #f9f9f9;
    padding: 6px;
    font-size: 1rem;
    transition: background-color 0.3s ease;
    cursor: pointer;
}


a.details-link {
    color: #00664F; /* Deep green */
    font-weight: 600;
    text-decoration: none;
    padding: 8px;
    border: 2px solid #00664F; /* Added a border for the button */
    transition: all 0.3s ease;
    display: inline-block;
    font-size: 1rem;
}

a.details-link:hover {
    background-color: #00664F; /* Deep green */
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.users {
	padding-left: 15px;
}

.lctrName{
	text-align: left;
}

/* Pagination Styling */
.pagination {
    margin-top: 30px;
    margin-bottom: 30px;
    text-align: center;
}

.pagination a {
    display: inline-block;
    padding: 12px 20px;
    margin: 0 6px;
    border: 2px solid #00664F; /* Deep green border */
    color: #00664F; /* Deep green text */
    text-decoration: none;
    font-weight: bold;
    background-color: #f8f8f8;
    font-size: 1rem;
    transition: all 0.3s ease;
    /* Removed border-radius to make buttons square */
}

.pagination a:hover {
    background-color: #00664F; /* Deep green */
    color: white;
    transform: scale(1.1);
}

.pagination a.active {
    background-color: #00664F; /* Deep green */
    color: white;
}

/* Hover effect on pagination buttons */
.pagination a:hover {
    transform: scale(1.1);
    box-shadow: 0 5px 15px rgba(0, 102, 79, 0.2);
}

</style>
</head>
<body>
<main>
    <h2>강의 개설 리스트</h2>
    <table>
        <thead>
            <tr>
                <th>회원번호</th>
                <th>대면 여부</th>
                <th>강의구분명</th>
                <th>강의명</th>
                <th>모집인원</th>
                <th>모집 시작일</th>
                <th>수강료</th>
                <th>강의상태명</th>
                <th>개강일</th>
                <th>총 차시</th>
                <th>상세보기</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="lecture" items="${lectureList}">
                <tr>
                    <td class="users">${lecture.user_name} (${lecture.user_seq})</td>
                    <td>${lecture.onoff_tr}</td>
                    <td>${lecture.lctr_category}</td>
                    <td class="lctrName">${lecture.lctr_name}</td>
                    <td>${lecture.lctr_count}</td>
                    <td>${lecture.rcrt_date}</td>
                    <td>${lecture.lctr_cost}</td>
                    <td>${lecture.lctr_state}</td>
                    <td>${lecture.lctr_start_date}</td>
                    <td>${lecture.lctr_cntschd}</td>
                    <td><a href="lectureDetail?lctr_id=${lecture.lctr_id}" class="details-link">상세보기</a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="pagination">
        <c:if test="${paging.startPage > 1}">
            <a href="?page=1">First</a>
            <a href="?page=${paging.startPage - 1}">Previous</a>
        </c:if>
        <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
            <a href="?page=${page}" class="${page == paging.currentPage ? 'active' : ''}">${page}</a>
        </c:forEach>
        <c:if test="${paging.endPage < paging.totalPage}">
            <a href="?page=${paging.endPage + 1}">Next</a>
            <a href="?page=${paging.totalPage}">Last</a>
        </c:if>
    </div>
    </main>
</body>
</html>
