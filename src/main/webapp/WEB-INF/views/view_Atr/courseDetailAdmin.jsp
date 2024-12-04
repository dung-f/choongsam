<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../headerGreen.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>강의 상세</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
/* General Page Styling */
body {
	font-family: Arial, sans-serif;
	background-color: #fff; /* 배경 흰색 */
	color: #333;
	margin: 0;
	flex-direction: column;
	align-items: center;
	box-sizing: border-box;
}

h2 {
	color: #00664F; /* 포인트 색상 */
	margin-bottom: 30px;
	text-align: center;
	font-size: 2em;
	text-shadow: 1px 1px 5px rgba(0, 102, 79, 0.3);
}

/* Table Styling */
table {
	margin-left: auto;
	margin-right: auto;
	width: 40%;
	border-collapse: collapse;
	background-color: #ffffff;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
	overflow: hidden;
	margin-top: 20px;
	margin-bottom: 50px;
}

th, td {
	padding: 15px;
	font-size: 16px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #00664F; /* 포인트 색상 */
	color: #ffffff;
	font-weight: bold;
	text-transform: uppercase;
}

td {
	background-color: #f4f9f5;
	color: #333;
}

tr:hover td {
	background-color: #e2f7e1; /* Hover effect */
}

/* Box Shadow for the Table */
table {
	box-shadow: 0 4px 12px rgba(0, 102, 79, 0.2);
}

/* Add a Bottom Border for the Table */
td:last-child {
	border-bottom: none;
}

/* Add a Button Style (if needed in the future) */
.btn {
	background-color: #00664F; /* 포인트 색상 */
	color: white;
	padding: 12px 25px;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

.btn:hover {
	background-color: #004e3c; /* Darker shade of the point color */
	transform: scale(1.05);
}

#lookDetail {
	margin-bottom: 5%;
}
</style>
</head>
<body>
	<h2>강의 상세</h2>
	<table>
		<tr>
			<th>강사</th>
			<td>${lecture.user_name}</td>
		</tr>
		<tr>
			<th>대면여부</th>
			<td>${lecture.onoff_tr}</td>
		</tr>
		<tr>
			<th>분류</th>
			<td>${lecture.lctr_category}</td>
		</tr>
		<tr>
			<th>강의명</th>
			<td>${lecture.lctr_name}</td>
		</tr>
		<tr>
			<th>모집인원</th>
			<td>${lecture.lctr_count}</td>
		</tr>
		<tr>
			<th>모집시작일</th>
			<td>${lecture.rcrt_date}</td>
		</tr>
		<tr>
			<th>수강료</th>
			<td>${lecture.lctr_cost}</td>
		</tr>
		<tr>
			<th>강의상태</th>
			<td>
				<form action="changeLectureState">
				<input hidden="" name="lctr_id" value="${lecture.lctr_id}">
					<select name="lctr_state">
						<option value="4002"
							<c:if test="${lecture.lctr_state eq '모집전'}">selected="selected"</c:if>>모집전</option>
						<option value="4003"
							<c:if test="${lecture.lctr_state eq '모집중'}">selected="selected"</c:if>>모집중</option>
						<option value="4004"
							<c:if test="${lecture.lctr_state eq '강의전'}">selected="selected"</c:if>>강의전</option>
						<option value="4005"
							<c:if test="${lecture.lctr_state eq '강의중'}">selected="selected"</c:if>>강의중</option>
						<option value="4006"
							<c:if test="${lecture.lctr_state eq '폐강'}">selected="selected"</c:if>>폐강</option>
						<option value="4007"
							<c:if test="${lecture.lctr_state eq '종강'}">selected="selected"</c:if>>종강</option>
					</select><input type="submit" value="수정" style="margin: 5px;">
				</form>
			</td>
		</tr>
		<tr>
			<th>평가기준</th>
			<td>${lecture.eval_criteria}</td>
		</tr>
		<tr>
			<th>개강일</th>
			<td>${lecture.lctr_start_date}</td>
		</tr>
		<tr>
			<th>차시 수</th>
			<td>${lecture.lctr_cntschd}</td>
		</tr>
	</table>

	<!-- 강의 계획 모달 버튼 -->
	<div class="text-center mt-3">
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#syllabusModal" style="background-color: #00664F"
			id="lookDetail">강의 계획 보기</button>
	</div>

	<!-- 강의 계획 모달 -->
	<div class="modal fade" id="syllabusModal" tabindex="-1" role="dialog"
		aria-labelledby="syllabusModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="syllabusModalLabel">강의 계획</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<table class="syllabus-table table table-bordered">
						<tbody>
							<c:forEach var="syllabus" items="${syllabusList}"
								varStatus="status">
								<c:choose>
									<c:when test="${status.index eq 0 }">
										<tr>
											<th style="width: 20%;">강의 목표</th>
											<td>${syllabus.lctr_otln}</td>
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<th style="width: 20%;">${status.index}주차강의계획</th>
											<td>${syllabus.lctr_otln}</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
<footer><%@ include file="../footer.jsp"%></footer>
</html>
