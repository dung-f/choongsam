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
<title>수강생 출결현황</title>
</head>
<body>
	<div class="container">
	<div class="contents">
		<h1>차시별 수강생 출결현황</h1>
	</div>
	<table>
		<tr>
			<th>차시</th>
			<th>출석</th>
			<c:if test="${onoff != 7002}">
				<th>지각</th>
			</c:if>
			<th>결석</th>
			<th>출석률</th>
		</tr>
		<c:forEach var="AttMain" items="${profAttMainList}">
		<tr>
		 	<td><c:if test="${AttMain.onoff != 7002}">
		 			<a href="/Jhe/insertStudAtt?lctr_id=${AttMain.lctr_id}&LCTR_NO=${AttMain.lctr_no}&onoff=${AttMain.onoff}">
		 			${AttMain.lctr_no}</a>
		 		</c:if>
		 		<c:if test="${AttMain.onoff != 7001}">
		 			<a href="/Jhe/profAttDetail?lctr_id=${AttMain.lctr_id}&LCTR_NO=${AttMain.lctr_no}&onoff=${AttMain.onoff}">
		 			${AttMain.lctr_no}</a>
		 		</c:if>
		 	</td>
			<td>${AttMain.present_count}</td>
			<c:if test="${AttMain.onoff != 7002}"><td>${AttMain.late_count}</td></c:if>
			<td>${AttMain.absent_count}</td>
			<td>${AttMain.attendance_rate}%</td>
		</tr>
		</c:forEach>
	</table>
	</div>
</body>
</html>