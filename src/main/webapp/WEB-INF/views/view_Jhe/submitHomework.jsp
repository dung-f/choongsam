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
<title>Insert title here</title>
</head>
<style>
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
<body>
<div class="container">
<div class="contents">
	<h1>과제 제출</h1>
</div>
	<form action="/Jhe/submitHomework" method="post" enctype="multipart/form-data" id="submitHomework">
		<table>
			<tr>
				<th><input type="hidden" name="asmt_no" value="${upHomework.asmt_no}">
					강의명</th>
				<td>${upHomework.lctr_name}</td>
			</tr>
			<tr>
				<th>강사명</th>
				<td>${upHomework.prof_name}</td>
			</tr>
			<tr>
				<th>과제명</th>
				<td>${upHomework.asmt_nm}</td>
			</tr>
			<tr>
				<th>마감일</th>
				<td>${upHomework.sbmsn_end_ymd}</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><a href="/api/files/${upHomework.file_group}/1">${upHomework.file_nm}</a></td>
			</tr>
			<tr>
				<th>과제 파일 업로드</th>
				<td>
					<div class="file_list">
						<div class="file_input">
							<input type="file" name="files" onchange="selectFile(this);" />
							<button type="button" onclick="removeFile(this);" class="btns del_btn">
								<span>삭제</span>
							</button>
							<button type="button" onclick="addFile();" class="btns fn_add_btn">
								<span>파일 추가</span>
							</button>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>제출</th>
				<td><input class="submitBtn" type="submit" value="제출">
		<a href="../Jhe/studHomeworkList"><button class="submitBtn" type="button">취소</button></a></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>