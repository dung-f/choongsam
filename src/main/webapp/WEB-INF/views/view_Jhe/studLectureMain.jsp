<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
}

.container {
	display: flex;
	flex-direction: column;
	position: relative;
	/* 컨테이너의 배경색을 흰색에 가까운 연한 회색으로 설정합니다. */
	background-color: #fdfdfd;
	/* 컨테이너에 미세한 그림자를 추가하여 입체감을 줍니다. */
	top: 120px;
	/*  컨테이너의 너비 1320px 고정 */
	width: 1200px;
	/* 중앙 정렬 */
	margin: 0 auto;
	/* padding을 width에 포함하여 계산 */
	box-sizing: border-box;
	/* 자동으로 좌우 여백을 설정하여 가운데 정렬 */
	margin: 0 auto;
	height: auto;
	margin-bottom: 200px;
}

.list {
	margin: 50px 0;
}

table {
	padding: 0;
	border-top: 2px solid black;
}

th {
	color: gray;
	font-weight: bold;
	text-align: center;
	/* 중앙 정렬 */
	padding: 20px 0;
	background-color: #F9F9F9;
	color: black;
	border-bottom: 0.4px solid #e2e8ee;
	border-left: 0.4px solid #e2e8ee;
}

td {
	border-bottom: 0.4px solid #e2e8ee;
	border-left: 0.4px solid #e2e8ee;
	cursor: pointer;
	font-weight: bold;
	text-align: center;
	/* 중앙 정렬 */
	color: #323232;
	height: 50px;
}

.submitBtn{
	width: 70px;
	height: 40px;
	border: none;
	background-color: #00664F;
	border: none;
	color: white;
	font-weight: bold;

}

#cell-1{
width: 60%;

}
#cell-2{
width: 10%;

}
#cell-3{
width: 10%;

}
#cell-4{
width: 10%;

}
#cell-5{
width: 10%;

}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="contents">
			<h1>강의 정보 (수강생)</h1>

		</div>
		<div class="contents"></div>
			<table class="list">
				<thead>
					<tr>
						<th>강의명</th>
						<th>강사명</th>
						<th>출석</th>
						<th>과제</th>
						<th>성적</th>
					</tr>
				</thead>
				<c:forEach var="lecture" items="${studLectureMain}">
					<tbody>
						<tr>
							<td id="cell-1">${lecture.lctr_name}</td>
							<td id="cell-2">${lecture.user_name}</td>
							<td id="cell-3">
								<form action="/Jhe/studAtt" method="get">
									<input type="hidden" name="lctr_id" value="${lctr_id}" /> <input
										type="hidden" name="onoff" value="${onoff}" />
									<c:if test="${onoff == 7001}">
										<button class="submitBtn" type="submit">출석</button>
									</c:if>
									<c:if test="${onoff == 7002}">
										<button class="submitBtn" type="submit">온라인출석</button>
									</c:if>
								</form>
							</td>
							<td id="cell-4">
								<form action="/Jhe/studHomeworkList" method="get">
									<input type="hidden" name="lctr_id" value="${lctr_id}" />
									<button class="submitBtn" type="submit">과제</button>
								</form>
							</td>
							<td id="cell-5">
								<form action="/Jhe/studGrade" method="get">
									<input type="hidden" name="lctr_id" value="${lctr_id}" />
									<button class="submitBtn" type="submit">성적</button>
								</form>

							</td>
						</tr>
					</tbody>
				</c:forEach>
			</table>
	</div>










</body>
</html>