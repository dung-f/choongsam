<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../headerGreen.jsp"%>
<%@ include file="../myPageNav.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>강의 등록</title>
<!-- Bootstrap CSS 추가 -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>

body {
	background-color: #fff; 
	font-family: Arial, sans-serif;
	color: #333;
}

h2 {
	color: #00664F; 
	font-weight: bold;
	text-align: center;
	margin-bottom: 30px;
	font-size: 2em;
	text-shadow: 1px 1px 5px rgba(0, 102, 79, 0.6);
	margin-top: 10%;
}

.form-group label {
	font-weight: bold;
	color: #00664F; 
}

.form-group input, .form-group select {
	border-radius: 8px;
	border: 1px solid #b8c095;
	padding: 10px;
	background-color: #f1f1eb;
	color: #333;
	transition: border-color 0.3s;
}

.form-group input:focus, .form-group select:focus {
	border-color: #00664F; 
}


.btn-primary {
	background: linear-gradient(90deg, #00664F, #008C60); 
	color: #fff;
	border: none;
	border-radius: 5px;
	padding: 12px 25px;
	font-size: 16px;
	font-weight: bold;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	box-shadow: 0 4px 10px rgba(0, 102, 79, 0.3);
}

.btn-primary:hover {
	transform: scale(1.05);
	box-shadow: 0 5px 15px rgba(0, 102, 79, 0.4);
	background: linear-gradient(90deg, #008C60, #00664F); 
}


.modal-header {
	background-color: #00664F;
	color: #fff;
}

th, td {
	padding: 0.75rem;
	text-align: center;
	cursor: pointer;
	font-size: 0.9em;
}

th {
	background-color: #e7e8e2;
	color: #00664F;
}

td {
	background-color: #fff;
	transition: background-color 0.3s;
}

td:hover, .selected {
	background-color: #00664F; 
	color: #fff;
	font-weight: bold;
}


#selectionDisplay {
	background-color: #e1edc8;
	color: #00664F; /* 포인트 색상 */
	padding: 12px;
	text-align: center;
	border-radius: 8px;
	font-weight: bold;
	margin-top: 20px;
}

#submitbutton {
	margin-left: 47%;
	margin-bottom: 30px;
}
</style>
<script>
    function homeworkEval() {
        const selectedValue = parseInt(document.getElementById("attendanceEval").value);
        document.getElementById("displayValue").innerText = 100 - selectedValue;
    }


    const selectedTimes = [];

    function toggleTimeSelection(day, hour, cell) {
        const timeSlot = day + "요일" + hour + "시";
        const index = selectedTimes.indexOf(timeSlot);

        if (index === -1) {
            selectedTimes.push(timeSlot);
            cell.classList.add("selected");
        } else {
            selectedTimes.splice(index, 1);
            cell.classList.remove("selected");
        }

        document.getElementById("selectionDisplay").innerText = "선택한 시간: " + selectedTimes.join(", ");
        document.getElementById("selectedTimesInput").value = selectedTimes.join(", ");
    }

    function submitForm() {
        document.getElementById("selectedTimesInput").value = selectedTimes.join(", ");
        document.getElementById("timeSelectionForm").submit();
    }
    function toggleTimetableSelection() {
        const onoffSelect = document.getElementById("onoff").value;
        const timeSelectionButton = document.querySelector("button[data-target='#timeSelectionModal']");
        const selectionDisplay = document.getElementById("selectionDisplay");
        
        if (onoffSelect === "7002") { 
            
            timeSelectionButton.disabled = true;
            selectedTimes.length = 0; 
            selectionDisplay.innerText = "선택한 시간: 없음";
            document.getElementById("selectedTimesInput").value = "";
        } else {
            timeSelectionButton.disabled = false;
        }
    }
</script>
</head>
<body>
	<div class="container mt-5">
		<h2>강의 등록</h2>
		<form action="registerCourse" id="timeSelectionForm" method="post">
			<div class="form-group">
				<label>강의명&nbsp;&nbsp;</label> <input type="text" name="lctr_name"
					required>
			</div>
			<div class="form-group">
				<label>수강 인원&nbsp;&nbsp;</label> <input type="number"
					name="lctr_count" required>
			</div>
			<div class="form-group">
				<label>대면 여부&nbsp;&nbsp;</label> <select name="onoff" id="onoff"
					onchange="toggleTimetableSelection()">
					<option value="7001" selected="selected">대면</option>
					<option value="7002">비대면</option>
				</select>
			</div>
			<div class="form-group">
				<label>분류&nbsp;&nbsp;</label> <select name="lctr_category">
					<option value="3001" selected="selected">일반 과정</option>
					<option value="3002">전문 과정</option>
				</select>
			</div>
			<div class="form-group">
				<label>모집 시작일&nbsp;&nbsp;</label> <input type="date"
					name="rcrt_date" required>
			</div>
			<div class="form-group">
				<label>개강일&nbsp;&nbsp;</label> <input type="date"
					name="lctr_start_date" required>
			</div>
			<div class="form-group">
				<label>총 차시&nbsp;&nbsp;</label> <input type="number"
					name="lctr_cntschd" required>
			</div>
			<div class="form-group">
				<label>평가기준<br>
				<br> 출석:
				</label> <select id="attendanceEval" name="attendanceEval"
					onchange="homeworkEval()" required>
					<c:forEach var="i" begin="0" end="100" step="10">
						<option value="${100 - i}">${100 - i}%</option>
					</c:forEach>
				</select>
				<p>
					<label>과제:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span id="displayValue">0</span>%
					</label>
			</div>
			<div class="form-group">
				<label>수강료</label> <input type="number" name="lctr_cost" required>
			</div>

			<div class="form-group text-center">
				<button type="button" class="btn btn-primary" data-toggle="modal"
					data-target="#timeSelectionModal">시간표 선택하기</button>
			</div>

			<p id="selectionDisplay">선택한 시간:</p>
			<input type="hidden" id="selectedTimesInput" name="lctr_schd">
			<input type="hidden"  name="user_seq" value="${user_seq}">
			<input type="submit" id="submitbutton" value="확인"
				class="btn btn-primary">
		</form>

		<!-- 시간표 모달 -->
		<div class="modal fade" id="timeSelectionModal" tabindex="-1"
			role="dialog" aria-labelledby="timeSelectionModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="timeSelectionModalLabel">시간표 선택</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<c:set var="days">월,화,수,목,금</c:set>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>시간</th>
									<c:forEach var="day" items="${days}">
										<th>${day}요일</th>
									</c:forEach>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="hour" begin="9" end="21">
									<tr>
										<th>${hour}시</th>
										<c:forEach var="day" items="${days}">
											<td onclick="toggleTimeSelection('${day}', ${hour}, this)">${day}요일
												${hour}시</td>
										</c:forEach>
									</tr>
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
	</div>

	<!-- Bootstrap JS, Popper.js 및 jQuery 추가 -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
<footer><%@ include file="../footer.jsp"%></footer>
</html>