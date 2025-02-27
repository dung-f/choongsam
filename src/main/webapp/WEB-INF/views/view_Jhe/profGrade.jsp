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
.updateBtn{
	width: 60px;
	height: 40px;
	border-color: #00664F;
	background-color: white;
	color: #00664F;
	font-weight: bold;
	border-radius: 5px;
	padding: 10px;
	margin-top: 10px;
	margin-left: 1130px;
	transition: background-color 0.3s ease, color 0.3s ease, transform 0.2s ease;
}
.updateBtn:hover {
	background-color: #00664F;
	color: white;
	transform: scale(1.1); /* 버튼 크기 살짝 키우기 */
}
</style>
<title>수강생 성적 조회</title>
</head>
<body>
	<div class="container">
	<div class="contents">
		<h1>수강생 성적 조회</h1>
	</div>
<table>
	<tr>
		<th>강의명</th>
		<th class="col_3">수강생</th>
		<th class="col_3">출석점수</th>
		<th class="col_3">과제점수</th>
		<th class="col_3">총 점수</th>
		<th class="col_3">수료여부</th>
	</tr>
	<c:forEach var="studentScore" items="${studentScoreList}">
		<tr>
			<td>${studentScore.lctr_name}</td>
			<td>${studentScore.stud_name}</td>
			<td>${studentScore.atndc_scr}</td>
			<td>${studentScore.asmt_scr}</td>
			<td>${studentScore.last_scr}</td>
			<td>
				<c:choose>
					<c:when test="${studentScore.fnsh_yn == 'Y'}">수료</c:when>
					<c:otherwise>미수료</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</c:forEach>
</table>
		<a href="/Jhe/updateStudGrade/${lctr_id}/${user_seq}/${onoff}"><button type="submit" class="updateBtn">수정</button></a>

</div>
</body>
</html>