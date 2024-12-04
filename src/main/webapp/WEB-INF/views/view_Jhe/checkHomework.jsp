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
	padding-left: 30px;
}
table {
	width: 1200px;
}
.contents {
	width: 1200px;
	text-align: center;
}
</style>
<title>Insert title here</title>
</head>
<body>
<div class="container">
<div class="contents">
	<h1>과제 제출 확인</h1>
</div>
	<form action="/Jhe/checkHomework" method="get">
		<table>
			<tr>
				<th><input type="hidden" name="asmt_no" value="${checkHomework.asmt_no}">
					강의명</th>
				<td>${checkHomework.lctr_name}</td>
			</tr>
			<tr>
				<th>강사명</th>
				<td>${checkHomework.prof_name}</td>
			</tr>
			<tr>
				<th>과제명</th>
				<td>${checkHomework.asmt_nm}</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><a href="/api/files/${checkHomework.assigned_file_group}/1">${checkHomework.assigned_file}</a></td>
			</tr>
			<tr>
				<th>제출 과제</th>
				<td><a href="/api/files/${checkHomework.submitted_file_group}/1">${checkHomework.submitted_file}</a></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>