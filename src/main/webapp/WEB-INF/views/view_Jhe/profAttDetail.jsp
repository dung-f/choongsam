<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../headerGreen.jsp" %>
<%@ include file="../myStudyHomeNav.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/heStd.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.contents{
	width: 1200px;
	text-align: center;
}
td {
	text-align: center;
}
table {
	width: 1200px;
}
</style>
<title>차시별 수강생 출결 현황</title>
</head>
<body>
	<div class="container">
	<div class="contents">
		<h1>차시별 수강생 출결 현황</h1>
	</div>
	<table>
		<tr>
			<th>학생 이름</th>
			<th>출석 상태</th>
		</tr>
		<c:forEach var="profAttDetail" items="${profAttDetailList}">
		<tr>
		 	<td>${profAttDetail.stud_name}</td>
			<td>
				<c:choose>
					<c:when test="${profAttDetail.att_status == 5001}">출석</c:when>
					<c:when test="${profAttDetail.att_status == 5002}">지각</c:when>
					<c:when test="${profAttDetail.att_status == 5003}">결석</c:when>
				</c:choose>
			</td>
		</tr>
		</c:forEach>
	</table>
	</div>
</body>
</html>