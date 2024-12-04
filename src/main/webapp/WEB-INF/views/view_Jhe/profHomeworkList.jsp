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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
.delHomework {
	margin-top: 10px;
	background-color: #DB3A00;
	color: white;
	border: none;
	padding: 8px;
	border-radius: 5px;
	margin-bottom: 50px;
	font-weight: bold;
}
td {
	padding: 10px;
	text-align: center;
	font-size: 15px;
}
table {
	width: 1200px;
}
.filePng {
	width: 40px;
	height: 40px;
}
</style>
<title>진행중인 강의 과제 리스트</title>
</head>
<body>
	<div class="container">
	<div class="contents">
		<h1>과제 관리</h1>
	</div>
	<form action="/Jhe/insertHomework" method="get" style="width: 1200px; text-align: right;">
		<input type="hidden" name="lctr_id" value="${lctr_id}">
    		<button type="submit" class="submitBtn" style="margin-bottom: 10px;">과제 등록</button>
	</form>
<form action="/Jhe/deleteHomework?lctr_id=${lctr_id}" method="post">
	<table class="homeworkList">
		<tr>
			<th>강의명</th>
			<th class="col_3">강사명</th>
			<th>과제명</th>
			<th class="col_3">진행</th>
			<th class="col_3">시작일</th>
			<th class="col_3">마감일</th>
			<th class="col_3">제출</th>
			<th class="col_3">삭제</th>
		</tr>
		<c:set var="previousName" value="" />
		<c:set var="previousAsmtNm" value="" />
		<c:set var="previousprofNm" value="" />
		<c:forEach var="profHomework" items="${profHomeworkList}">
			<c:if test="${profHomework.lctr_name != previousName}">
				<tr>
					<td>${profHomework.lctr_name}</td>
					<td>${profHomework.prof_name}</td>
					<td><a href="/Jhe/updateHomework?asmt_no=${profHomework.asmt_no}">${profHomework.asmt_nm}</a></td>
					<td>${profHomework.asmtStatus}</td>
					<td>${profHomework.sbmsn_bgng_ymd}</td>
					<td>${profHomework.sbmsn_end_ymd}</td>
					<td class="col_3">${profHomework.submissionRate}%</td>
					<td class="col_3"><input type="checkbox" name="delCheck" value="${profHomework.asmt_no}"></td>
				</tr>
				<c:set var="previousName" value="${profHomework.lctr_name}" />
				<c:set var="previousprofNm" value="${profHomework.prof_name}" />
				<c:set var="previousAsmtNm" value="${profHomework.asmt_nm}" />
			</c:if>
			<c:if test="${profHomework.lctr_name == previousName
						&& profHomework.prof_name == previousprofNm
						&& profHomework.asmt_nm != previousAsmtNm}">
				<tr>
					<td></td>
					<td></td>
					<td><a href="/Jhe/updateHomework?asmt_no=${profHomework.asmt_no}">${profHomework.asmt_nm}</a></td>
					<td>${profHomework.asmtStatus}</td>
					<td>${profHomework.sbmsn_bgng_ymd}</td>
					<td>${profHomework.sbmsn_end_ymd}</td>
					<td class="col_3">${profHomework.submissionRate}%</td>
					<td class="col_3"><input type="checkbox" name="delCheck" value="${profHomework.asmt_no}"></td>
				</tr>
				<c:set var="previousAsmtNm" value="${profHomework.asmt_nm}" />
			</c:if>
		</c:forEach>
	</table>
	<button type="submit" class="delHomework">선택한 과제 삭제</button>
	<div class="contents">
		<h1>과제 제출 현황</h1>
	</div>
	<table class="studList">
		<tr>
			<th>과제명</th>
			<th class="col_3">학생 이름</th>
			<th class="col_3">제출 상태</th>
			<th class="col_3">제출 파일</th>
		</tr>
		<c:forEach var="studList" items="${studList}">
			<tr>
				<td>${studList.asmt_nm}</td>
				<td class="col_3">${studList.stud_name}</td>
				<td class="col_3">${studList.sbmsn_yn}</td>
				<td class="col_3">
				<c:if test="${studList.file_group != 0}">
					<a href="/api/files/${studList.file_group}/1">
					<img alt="제출파일" src="../chFile/Homework/파일.png" class="filePng"></a>
				</c:if></td>
			</tr>
		</c:forEach>
	</table>
</form>
</div>
</body>
</html>