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
h1 {
	margin-top: 70px;
}
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
.tdStyle {
	border: none;
	text-align: center;
	width: 100px;
	padding: 5px;
}
form {
	margin-top: -90px;
}
.submitBtn {
	margin-top: 20px;
	margin-left: 550px;
}
.loadGrade{
	width: 120px;
	height: 40px;
	border-color: #00664F;
	background-color: white;
	color: #00664F;
	font-weight: bold;
	border-radius: 5px;
	padding: 10px;
	margin-bottom: 10px;
	margin-left: 1075px;
}
/* 비활성화된 버튼 */
button[disabled] {
	width: 100px;
	height: 40px;
	border-color: #cccccc;  /* 흐릿한 회색 테두리 */
	background-color: #e0e0e0;  /* 흐릿한 회색 배경 */
	color: #999999;  /* 흐릿한 글자 색 */
	font-weight: normal;  /* 기본 폰트 굵기 */
	border-radius: 5px;
	padding: 10px;
	cursor: not-allowed;  /* 마우스 포인터를 '클릭 불가'로 변경 */
}
</style>
<title>수강생 성적 입력</title>
</head>
<body>
	<form action="/Jhe/updateStudGrade" method="post">
	<div class="container">
	<div class="contents">
		<h1>수강생 성적 수정</h1>
		<button type="button" class="loadGrade" onclick="loadGrade()">성적 불러오기</button>
	</div>
		<table>
			<tr>
				<th><input type="hidden" name="lctr_id" value="${lctr_id}">강의명</th>
				<th class="col_3">수강생</th>
				<th class="col_3">출석점수</th>
				<th class="col_3">과제점수</th>
				<th class="col_3">총 점수</th>
				<th class="col_3">수료여부</th>
			</tr>
			<c:forEach var="updateGrade" items="${updateGradeList}">
			<tr>
				<td>${updateGrade.lctr_name}</td>
				<td>${updateGrade.stud_name}<input type="hidden" name="user_seq" value="${updateGrade.user_seq}"></td>
				<td><input type="text" name="atndc_scr" value="0" class="tdStyle" required data-original-value="0"></td>
				<td><input type="text" name="asmt_scr" value="0" class="tdStyle" required data-original-value="0"></td>
				<td><input type="text" name="last_scr" value="0" class="tdStyle" required readonly></td>
				<td><span class="completion-status">미수료</span></td>
			</tr>
			</c:forEach>
		</table>
		<button type="submit" class="submitBtn" disabled>성적 수정</button>
	</div>
</form>

<script type="text/javascript">
	// 성적 불러오기 버튼 클릭 시 성적을 불러오는 AJAX 코드
	function loadGrade() {
		const lctr_id = "${lctr_id}";
		const onoff = "${onoff}";

		// 수정 버튼 활성화
		const submitButton = document.querySelector('.submitBtn');
		submitButton.disabled = false;

		// 모든 수강생에 대해 성적을 불러옴
		document.querySelectorAll('input[name="user_seq"]').forEach((userSeqInput, index) => {
			const user_seq = userSeqInput.value;

			// 정확한 URL 경로로 요청
			fetch(`/Jhe/updateStudGrade/loadGrades/${lctr_id}/${user_seq}/${onoff}`)
				.then(response => response.json())  // JSON 응답 받기
				.then(grades => {
					console.log("불러온 성적 데이터:", grades); // 확인용 로그

					// 성적 데이터를 필터링해서 해당 user_seq에 맞는 데이터를 찾기
					const grade = grades.find(g => g.user_seq === parseInt(user_seq));

					// 성적 데이터가 존재하면 해당 값을 폼에 채워넣기
					if (grade) {
						// 출석 점수, 과제 점수, 총점 입력
						const atndcInput = document.querySelectorAll('input[name="atndc_scr"]')[index];
						const asmtInput = document.querySelectorAll('input[name="asmt_scr"]')[index];
						const lastScrInput = document.querySelectorAll('input[name="last_scr"]')[index];

						atndcInput.value = (grade.atndc_scr !== undefined && grade.atndc_scr !== null) ? grade.atndc_scr : '';
						asmtInput.value = (grade.asmt_scr !== undefined && grade.asmt_scr !== null) ? grade.asmt_scr : '';
						lastScrInput.value = (grade.last_scr !== undefined && grade.last_scr !== null) ? grade.last_scr : '';

						// 수료 여부 설정 (Y일 경우 수료, N일 경우 미수료)
						const completionStatus = document.querySelectorAll('.completion-status')[index]; // 각 수강생의 수료 여부 요소
						if (grade.fnsh_yn === 'Y') {
							completionStatus.textContent = '수료';
						} else if (grade.fnsh_yn === 'N') {
							completionStatus.textContent = '미수료';
						}

						// 성적 불러오기 후 변경 사항 체크
						checkForChanges();
					}
				})
				.catch(error => {
					console.error('AJAX 요청 오류:', error);
				});
		});
	}

	document.addEventListener("DOMContentLoaded", function() {
		const lctr_id = "${lctr_id}";  // lctr_id를 템플릿에서 받아옴

		// 페이지가 로드될 때 EVAL_CRITERIA 값을 가져와서 저장
		let evalCriteria = null;  // 기본값을 null로 설정

		fetch(`/Jhe/getEvalCriteria/${lctr_id}`)
			.then(response => response.json())
			.then(data => {
				evalCriteria = data;  // data가 바로 evalCriteria 값
				console.log("불러온 성적 반영 비율:", evalCriteria);
				// 정상적으로 값을 가져온 후, 이벤트 리스너 추가
				addScoreUpdateListener(evalCriteria);
			})
			.catch(error => {
				console.error('EVAL_CRITERIA 요청 오류:', error);
			});

		// 출석점수와 과제점수를 수정할 때마다 총점수를 계산
		function addScoreUpdateListener(evalCriteria) {
			// 출석점수와 과제점수를 모두 독립적으로 계산할 수 있도록 설정
			const atndcInputs = document.querySelectorAll('input[name="atndc_scr"]');
			const asmtInputs = document.querySelectorAll('input[name="asmt_scr"]');
			const lastScrInputs = document.querySelectorAll('input[name="last_scr"]');
			const completionStatus = document.querySelectorAll('.completion-status');
			const submitButton = document.querySelector('.submitBtn');

			// 출석점수와 과제점수의 변경 이벤트 리스너 추가
			atndcInputs.forEach((atndcInput, index) => {
				atndcInput.addEventListener('input', function() {
					// 출석 점수가 100을 넘지 않도록 제한
					if (parseFloat(atndcInput.value) > 100) {
						alert("출석 점수는 100점을 초과할 수 없습니다.");
						atndcInput.value = 100;
					}
					calculateTotalScore(index, evalCriteria);  // 출석점수 수정 시 총점 계산
					checkForChanges();
				});
			});

			asmtInputs.forEach((asmtInput, index) => {
				asmtInput.addEventListener('input', function() {
					// 과제 점수가 100을 넘지 않도록 제한
					if (parseFloat(asmtInput.value) > 100) {
						alert("과제 점수는 100점을 초과할 수 없습니다.");
						asmtInput.value = 100;
					}
					calculateTotalScore(index, evalCriteria);  // 과제점수 수정 시 총점 계산
					checkForChanges();
				});
			});

			// 총점 계산 함수
			function calculateTotalScore(index, evalCriteria) {
				const atndcScore = parseFloat(atndcInputs[index].value) || 0;
				const asmtScore = parseFloat(asmtInputs[index].value) || 0;

				// 반영 비율 계산
				const atndcRatio = evalCriteria;  // 출석 점수 반영 비율
				const asmtRatio = 100 - evalCriteria;  // 과제 점수 반영 비율

				// 총점 계산
				const totalScore = Math.floor((atndcScore * (atndcRatio / 100)) + (asmtScore * (asmtRatio / 100)));

				// 총점 입력 필드에 값 반영
				lastScrInputs[index].value = totalScore;

				// 총점이 70 이상이면 '수료', 70 미만이면 '미수료'로 설정
				if (totalScore >= 70) {
					completionStatus[index].textContent = '수료';
				} else {
					completionStatus[index].textContent = '미수료';
				}
			}

			// 수정 사항이 있으면 수정 버튼 활성화, 없으면 비활성화
			function checkForChanges() {
				let hasChanges = false;

				// 각 수강생의 출석점수와 과제점수를 비교하여 수정된 부분이 있으면 hasChanges를 true로 설정
				atndcInputs.forEach((input, index) => {
					if (input.value !== input.getAttribute('data-original-value')) {
						hasChanges = true;
					}
				});

				asmtInputs.forEach((input, index) => {
					if (input.value !== input.getAttribute('data-original-value')) {
						hasChanges = true;
					}
				});

				// 수정 버튼 활성화/비활성화
				submitButton.disabled = !hasChanges;
			}
		}
	});
</script>

</body>
</html>