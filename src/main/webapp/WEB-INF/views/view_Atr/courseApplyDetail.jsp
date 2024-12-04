<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../headerGreen.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>강의 신청 상세</title>
<!-- Bootstrap CSS 추가 -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	font-family: Arial, sans-serif;
	background-color: white;
	color: #333;
	margin: 0;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

h2 {
	color: #00664F;
	text-align: center;
	margin-bottom: 20px;
}

.main-table {
	margin-top: 20px;
	margin-left: 30%;
	width: 40%;
	border-collapse: collapse;
	background-color: #ffffff;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	border-radius: 8px;
	overflow: hidden;
}

th, td {
	padding: 15px;
	text-align: left;
	font-size: 16px;
}

th {
	background-color: #00664F;
	color: #ffffff;
}

td {
	background-color: white;
}

.form-button {
	text-align: center;
	margin-top: 20px;
}

.form-button input[type="submit"] {
	background-color: #00664F;
	color: #ffffff;
	font-size: 16px;
	border: none;
	padding: 10px 20px;
	cursor: pointer;
	border-radius: 5px;
	transition: background-color 0.3s ease;
	margin-bottom: 40px;
}

.form-button input[type="submit"]:hover {
	background-color: #4e623e;
}

/* Modal Custom Styles */
.modal .modal-header {
	background-color: #00664F;
	color: #ffffff;
}

.modal .modal-body {
	background-color: #f7f7f7;
}

.modal .modal-content {
	border-radius: 8px;
}

.syllabus-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
	background-color: #ffffff;
	border-radius: 8px;
	overflow: hidden;
}

.syllabus-table th, .syllabus-table td {
	padding: 12px;
	font-size: 15px;
	text-align: center;
}

.syllabus-table th {
	background-color: #00664F;
	color: #ffffff;
}

.syllabus-table td {
	background-color: #f7f7f7;
	color: #333;
}
h2{
	margin-top: 100px;

}
</style>
</head>
<body>
	<h2>강의 신청 상세</h2>
	<table class="main-table">
		<tr>
			<th>강사명</th>
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
			<td>${lecture.lctr_state}</td>
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
			data-target="#syllabusModal" style="background-color: #00664F">강의 계획 보기</button>
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
											<th style="width: 20%;">${status.index}주차 강의 계획</th>
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

	<form class="form-button" action="applyCourse">
		<input type="hidden" value="${lecture.lctr_id}" name="lctr_id">
		<input type="hidden" value="${lecture.lctr_cntschd}" name="lctr_cntschd">
		
		<input type="hidden" value="${user_seq}" name="student_id"> <input
			type="submit" value="신청하기">
	</form>

	<!-- Bootstrap JS, Popper.js, and jQuery -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
<footer><%@ include file="../footer.jsp"%></footer>
</html>
