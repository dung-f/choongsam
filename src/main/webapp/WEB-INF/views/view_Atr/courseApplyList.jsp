<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Lecture List</title>
<style>

body {
	font-family: Arial, sans-serif;
	background-color: white;
	color: #333;
	margin: 0;
	flex-direction: column;
	align-items: center;
}

h2 {
	color: #3e4a2c;
	margin-bottom: 20px;
	text-align: center;
}


table {
	width: 90%;
	margin-left: 5%;
	margin-right: 5%; border-collapse : collapse;
	background-color: #ffffff;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	border-radius: 8px;
	overflow: hidden;
	border-collapse: collapse;
}

th, td {
	padding: 12px;
	font-size: 15px;
	text-align: left;
	height: 50px;
}

th {
	background-color: #00664F;
	color: #ffffff;
}

td {
	background-color: white;
}


td.full {
	color: red;
}


.pagination {
	margin-top: 20px;
	margin-bottom: 20px;
	text-align: center;
}

.pagination a {
	display: inline-block;
	padding: 8px 16px;
	margin: 0 4px;
	border: 1px solid #ddd;
	text-decoration: none;
	color: #333;
	border-radius: 5px;
	background-color: #00664F;
}

.pagination a.active {
	font-weight: bold;
	background-color: #00664F;
	color: #ffffff;
}

.pagination a:hover {
	background-color: #6d805a;
	color: #ffffff;
}


a.apply-link {
	color: #6d805a;
	font-weight: bold;
	text-decoration: none;
}

a.apply-link[hidden] {
	display: none;
}
.container{
	margin-top: 150px;
	margin-bottom: 300px;
}
</style>
</head>
<body>
<div class="container">
	<h2>강의 리스트</h2>
	<table>
		<thead>
			<tr>
				<th>회원번호</th>
				<th>온/오프라인 여부</th>
				<th>강의구분명</th>
				<th>강의명</th>
				<th>모집인원수</th>
				<th>신청인원</th>
				<th>모집 시작일</th>
				<th>수강료</th>
				<th>개강일</th>
				<th>총 차시</th>
				<th>신청하기</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="lecture" items="${lectureList}">
				<tr>
					<td>${lecture.user_name}</td>
					<td>${lecture.onoff_tr}</td>
					<td>${lecture.lctr_category}</td>
					<td>${lecture.lctr_name}</td>
					<td>${lecture.lctr_count}</td>
					<td
						class="${lecture.lctr_count eq lecture.register_count ? 'full' : ''}">
						${lecture.register_count}</td>
					<td>${lecture.rcrt_date}</td>
					<td>${lecture.lctr_cost}</td>
					<td>${lecture.lctr_start_date}</td>
					<td>${lecture.lctr_cntschd}</td>
					<td><a href="courseApplyDetail?lctr_id=${lecture.lctr_id}"
						class="apply-link"
						<c:if test="${lecture.lctr_count eq lecture.register_count}"> hidden</c:if>>신청하기</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="pagination">
		<c:if test="${paging.startPage > 1}">
			<a href="?page=1">First</a>
			<a href="?page=${paging.startPage - 1}">Previous</a>
		</c:if>
		<c:forEach begin="${paging.startPage}" end="${paging.endPage}"
			var="page">
			<a href="?page=${page}"
				class="${page == paging.currentPage ? 'active' : ''}">${page}</a>
		</c:forEach>
		<c:if test="${paging.endPage < paging.totalPage}">
			<a href="?page=${paging.endPage + 1}">Next</a>
			<a href="?page=${paging.totalPage}">Last</a>
		</c:if>
	</div>
	</div>
</body>
<footer><%@ include file="../footer.jsp"%></footer>
</html>
