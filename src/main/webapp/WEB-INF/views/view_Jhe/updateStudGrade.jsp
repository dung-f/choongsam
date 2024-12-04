<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강생 성적 수정</title>
</head>
<body>
	<h2>수강생 성적 수정</h2>
	<form action="/Jhe/updateStudGrade" method="post">
		<table>
			<tr>
				<th><input type="hidden" name="userSeq" value="${upGrade.user_seq}">
					<input type="hidden" name="lctr_id" value="${upGrade.lctr_id}">
					강의명</th>
				<td>${upGrade.lctr_name}</td>
			</tr>
			<tr>
				<th>수강생</th>
				<td>${upGrade.stud_name}</td>
			</tr>
			<tr>
				<th>출석 점수</th>
				<td><input type="text" name="atndc_scr" value="${upGrade.atndc_scr}" required></td>
			</tr>
			<tr>
				<th>과제 점수</th>
				<td><input type="text" name="asmt_scr" value="${upGrade.asmt_scr}" required></td>
			</tr>
			<tr>
				<th>총 점수</th>
				<td><input type="text" name="last_scr" value="${upGrade.last_scr}" required></td>
			</tr>
		</table>
		<button type="submit">수정</button>
		<a href="/Jhe/profGrade?lctr_id=${upGrade.lctr_id}"><button type="button">취소</button></a>
	</form>
</body>
</html>