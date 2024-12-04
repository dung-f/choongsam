<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../headerGreen.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/heStd.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강사 강의실</title>
<style type="text/css">
</style>
</head>
<body>
	<div class="container">
		<div class="contents">
			<h1>${lctr_name}</h1>
		</div>
		<form action="/Jhe/studLectureMain" method="get">
			<table>
				<tr>
					<th>강의명</th>
					<th>강사명</th>
					<th>수강인원</th>
				</tr>
				<c:forEach var="lectureMain" items="${profLectureList}">
					<tr>
						<td>${lectureMain.lctr_name}</td>
						<td>${lectureMain.user_name}</td>
						<td>${lectureMain.reg_count}</td>
					</tr>
				</c:forEach>
			</table>
		</form>
		
		<form action="/Jhe/profAttMain" method="get">
			<input type="hidden" name="lctr_id" value="${lctr_id}" />
			<input type="hidden" name="onoff" value="${onoff}" />
				<c:if test="${onoff == 7001}">
					<button type="submit">출석</button>
				</c:if>
				<c:if test="${onoff == 7002}">
					<button type="submit">온라인출석</button>
				</c:if>
		</form>
		
		<form action="/Jhe/profHomeworkList" method="get">
		    <input type="hidden" name="lctr_id" value="${lctr_id}" />
		    <button type="submit">과제</button>
		</form>
		
		<form action="/Jhe/profGrade" method="get">
		    <input type="hidden" name="lctr_id" value="${lctr_id}" />
		    <button type="submit">성적</button>
		</form>
		</main>
	</div>
</body>
</html>