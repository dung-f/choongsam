<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 성적 상세 조회</title>
</head>
<body>
<h2>내 성적 상세 조회</h2>
<table>
	<tr>
		<th>강의명</th>
		<th>출석점수</th>
		<th>과제점수</th>
		<th>총 점수</th>
		<th>수료여부</th>
	</tr>
	<c:forEach var="myScore" items="${myGradeDetailList}">
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
		</tr>
	</c:forEach>
</table>
<a href="../notes/new"><button type="button">쪽지</button></a>
</body>
</html>