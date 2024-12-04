<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../headerGreen.jsp" %>
<%@ include file="../myStudyHomeNav.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/heStd.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>수강중인 강의 과제 리스트</title>
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
</head>
<body>
<div class="container">
<div class="contents">
<h1>과제 목록</h1>
</div>
	<table id="homeworkList">
		<tr>
			<th>강의명</th>
			<th class="col_3">강사명</th>
			<th>과제명</th>
			<th class="col_3">진행</th>
			<th class="col_3">마감일</th>
			<th class="col_3">제출</th>
		</tr>
		<c:set var="previousName" value="" />
		<c:set var="previousAsmtNm" value="" />
		<c:set var="previousprofNm" value="" />
		<c:forEach var="homeworkList" items="${studHomeworkList}">
			<c:if test="${homeworkList.lctr_name != previousName}">
				<tr>
					<td>${homeworkList.lctr_name}</td>
					<td>${homeworkList.prof_name}</td>
					<td>${homeworkList.asmt_nm}</td>
					<td>${homeworkList.asmtStatus}</td>
					<td>${homeworkList.sbmsn_end_ymd}</td>
					<td><c:choose>
						<c:when test="${homeworkList.sbmsn_yn == 'Y'}">
							<a href="/Jhe/checkHomework?asmt_no=${homeworkList.asmt_no}">과제 제출 확인</a></c:when>
						<c:when test="${homeworkList.sbmsn_yn == 'N'}">
							<a href="/Jhe/submitHomework?asmt_no=${homeworkList.asmt_no}">제출하기</a></c:when>
					</c:choose></td>
				</tr>
				<c:set var="previousName" value="${homeworkList.lctr_name}" />
				<c:set var="previousprofNm" value="${homeworkList.prof_name}" />
				<c:set var="previousAsmtNm" value="${homeworkList.asmt_nm}" />
			</c:if>
			<c:if
				test="${homeworkList.lctr_name == previousName && homeworkList.prof_name == previousprofNm && homeworkList.asmt_nm != previousAsmtNm}">
				<tr>
					<td></td>
					<td></td>
					<td>${homeworkList.asmt_nm}</td>
					<td>${homeworkList.asmtStatus}</td>
					<td>${homeworkList.sbmsn_end_ymd}</td>
					<td><c:choose>
						<c:when test="${homeworkList.sbmsn_yn == 'Y'}">
							<a href="/Jhe/checkHomework?asmt_no=${homeworkList.asmt_no}">과제 제출 확인</a></c:when>
						<c:when test="${homeworkList.sbmsn_yn == 'N'}">
							<a href="/Jhe/submitHomework?asmt_no=${homeworkList.asmt_no}">제출하기</a></c:when>
					</c:choose><input type="hidden" name="onoff" value="${homeworkList.onoff}" id="onoff"></td>
				</tr>
			</c:if>
		</c:forEach>
	</table>
</div>
</body>
</html>