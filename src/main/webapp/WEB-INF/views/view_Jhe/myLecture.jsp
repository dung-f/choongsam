<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../headerGreen.jsp" %>
<%@ include file="../myPageNav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
#myLecture {
	color: black;
}
#door {
	width: 40px;
}

body {
	font-family: 'Arial', sans-serif;
	background-color: white;
	margin: 0;
	padding: 0;
}

main {
	margin-left: -180px;
	padding: 150px 200px;
	background-color: white;
}

h2 {
	color: #333;
	font-size: 28px;
	margin-bottom: 20px;
	font-weight: bold;
}

table {
	width: 1300px;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	padding: 12px;
	text-align: center;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #00664F;
	color: white;
	font-size: 16px;
}

#lctrName{
	text-align: left;
}

/* .myLecDiv {
	margin-bottom: 45px;
}
.home {
	width: 30px;
	height: 30px;
	margin-left: 350px;
}

.Right {
	width: 30px;
} */
</style>
<title>내 강의 리스트</title>
</head>
<body>
<main>
<!-- 	<div class="myLecDiv">
		<span><a href="../"><img alt="홈" src="../chFile/Homework/홈.png" class="home"></a>
			<img alt="꺽새" src="../chFile/Homework/꺽새.png" class="Right">
			마이페이지
			<img alt="꺽새" src="../chFile/Homework/꺽새.png" class="Right">
			내 강의실
			<img alt="꺽새" src="../chFile/Homework/꺽새.png" class="Right">
			수강중인 강의 목록</span>
	</div> -->
	<h2>수강중인 강의 목록</h2>
	<c:if test="${usertype == 1002}"><h2>강의 관리</h2></c:if>
	<c:if test="${usertype == 1001}"><h2>수강중인 강의 목록</h2></c:if>
	<table id="homeworkList">
		<tr>
			<th id="lctrName">강의명</th>
			<th>강사명</th>
			<th>강의상태</th>
			<th>강의실</th>
		</tr>
		<c:forEach var="homeworkList" items="${homeworkList}">
				<tr>
					<td id="lctrName"><strong>${homeworkList.lctr_name}</strong></td>
					<td>${homeworkList.user_name}
					<td><c:choose>
							<c:when test="${homeworkList.lctr_state == 4005}">강의중</c:when>
							<c:when test="${homeworkList.lctr_state == 4007}">종강</c:when>
						</c:choose></td>
					<td>
						<%-- <c:if test="${homeworkList.lctr_state == 4007 || homeworkList.lctr_state == 4005}">
							<a href="/Jhe/studGrade?lctr_id=${homeworkList.lctr_id}&user_seq=${user_seq}&onoff=${homeworkList.onoff}" id="myLecture">
							<button>성적 조회</button></a>
						</c:if> --%>
						<c:if test="${homeworkList.lctr_state == 4005 || homeworkList.lctr_state == 4007}">
							<a href="/sh_lecture_student?lctr_id=${homeworkList.lctr_id}&user_seq=${user_seq}&onoff=${homeworkList.onoff}" id="myLecture">
							<img alt="강의실입장" src="../chFile/Homework/입장.png" id="door"></a>
						</c:if>
					</td>
				</tr>
		</c:forEach>
	</table>
	</main>
</body>
</html>