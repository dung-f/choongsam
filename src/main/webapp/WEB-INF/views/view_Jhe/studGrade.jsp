<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../headerGreen.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/heStd.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
td {
	text-align: center;
}
table {
	width: 1200px;
}
.contents {
	width: 1200px;
	text-align: center;
}
</style>
<title>내 성적 조회</title>
</head>
<body>

<div class="container">
	<div class="contents">
		<h1>내 성적 조회</h1>
	</div>
<table>
	<tr>
		<th>강의명</th>
		<th class="col_3">출석점수</th>
		<th class="col_3">과제점수</th>
		<th class="col_3">총 점수</th>
		<th class="col_3">수료여부</th>
		<th class="col_3">쪽지</th>
	</tr>
	<c:forEach var="myScore" items="${myGradeList}">
		<tr>
			<td>${myScore.lctr_name}</td>
			<td>${myScore.atndc_scr}</td>
			<td>${myScore.asmt_scr}</td>
			<td>${myScore.last_scr}</td>
			<td>
				<c:choose>
					<c:when test="${myScore.fnsh_yn == 'Y'}">수료</c:when>
					<c:otherwise>미수료</c:otherwise>
				</c:choose>
			</td>
			<td>
<a href="../notes/new"><button type="button" class="submitBtn">쪽지</button></a>
			</td>
		</tr>
	</c:forEach>
</table>
</div>
</body>
</html>