<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../headerGreen.jsp" %>
<%@ include file="../myPageNav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지 작성</title>
<style>
body {
	margin: 0;
	padding: 0;
}

.container {
	display: flex;
	flex-direction: column;
	position: relative;
	background-color: white;
	top: 120px;
	width: 1220px;
	margin: 0 auto;
	box-sizing: border-box;
	height: auto;
	padding: 20px; /* 여백 추가 */
	font-size: 20px;
	margin-bottom: 200px;
}

.list {
	margin: 50px 0;
}

table {
	padding: 0;
	width: 1280px;
	border-top: 2px solid black;
}

th {
	width: 200px;
	color: gray;
	font-weight: bold;
	text-align: center;
	padding: 20px 0;
	border-bottom: 0.4px solid #e2e8ee;
	font-size: 20px;
}

td {
	border-bottom: 0.4px solid #e2e8ee;
	border-left: 0.4px solid #e2e8ee;
	cursor: pointer;
	font-weight: bold;
	text-align: center;
	color: #323232;
	font-size: 14px;
	height: 50px;
}

.manager_pagination {
	text-align: center;
}

h1 {
	font-size: 40px;
}

input {
	width: 950px;
	height: 50px;
	font-size: 20px;
	border: #949494 1px solid;
	border-radius: none;
}

/* 기존 스타일 및 추가 스타일 */
.file-preview {
	margin-top: 10px;
	max-width: 100%;
	height: auto;
	border: 1px solid #ddd;
	padding: 10px;
}

textarea {
	width: 950px;
	height: 400px;
	font-size: 20px;
	border: #949494 1px solid;
	border-radius: none;
}

button {
	width: 200px;
	text-align: center;
	/* 버튼 가운데 정렬을 위한 추가 스타일 */
	margin: 20px auto; /* 버튼을 가운데 정렬 */
	display: block; /* 블록으로 설정 */
	height: 50px;
	background-color: #00664F;
	border: none;
	color: white;
}

/* 모달 기본 스타일 */
/* 모달 기본 스타일 */
.modal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.7);
}

/* 모달 콘텐츠 스타일 */
.modal-content {
	background-color: #fefefe;
	margin: 5% auto; /* 모달의 상단 여백을 조금 줄임 */
	padding: 20px;
	border: 1px solid #888;
	width: 90%;
	max-width: 1000px;
	border-radius: 10px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
	overflow-y: auto; /* 내용이 많을 경우 스크롤 */
}

/* 닫기 버튼 */
.close {
	color: #aaa;
	font-size: 28px;
	font-weight: bold;
	position: absolute;
	top: 15px;
	right: 20px;
}

/* 닫기 버튼 호버 */
.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

/* 강의 목록 테이블 스타일 */
#lectureTable {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

/* 테이블 헤더 스타일 */
#lectureTable th {
    padding: 10px;
    background-color: #00664F;
    color: white;
    font-size: 16px;
    text-align: left;
}

/* 강의 목록 행 스타일 */
#lectureTable td {
    padding: 10px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    font-size: 14px;
    color: #333;
}

/* 수신자 선택란 스타일 */
#lectureTable td input[type="checkbox"] {
    margin-left: 10px;
    margin-top: 5px;
}

/* 수신자 선택란 div 스타일 */
#lectureTable td div {
    margin-top: 10px;
    font-size: 14px;
    color: #666;
}

/* 선택된 수신자 표시 스타일 */
.selected {
    background-color: #d1e7dd;
}

/* 테이블 셀 호버 */
#lectureTable td:hover {
	background-color: #f1f1f1;
}




</style>
<c:set var="userSeq" value="${sessionScope.user_seq}" />
<script type="text/javascript">
		// 수신자 모달을 여는 함수
		function openRecipientModal() {
		document.getElementById('recipientModal').style.display = 'block'; // 모달 열기
		document.getElementById('lectureBody').innerHTML = ''; // 기존 목록 초기화
		document.getElementById('sendMessageButton').style.display = 'none'; // 수신자 추가 버튼 숨기기
		
		// 강의 목록을 가져와서 테이블에 채운다
		fetch(`/api/lectures/my?user_seq=${userSeq}`, { cache: 'no-store' })
		.then(response => response.json()) // 서버에서 JSON 형태로 데이터 받기
		.then(data => populateLectureTable(data)) // 데이터를 테이블에 채움
		.catch(error => console.error("Error fetching lectures:", error)); // 오류 처리
	}
	
	// 강의 목록을 테이블에 추가하는 함수
function populateLectureTable(lectures) {
    const lectureBody = document.getElementById('lectureBody');
    lectureBody.innerHTML = ''; // 기존 내용 초기화

    // 강의 목록을 테이블에 추가
    lectures.forEach(lecture => {
        const tr = document.createElement('tr');
        const lectureCell = document.createElement('td');
        lectureCell.textContent = lecture.lctr_name;
        
		const lctr_id = String(lecture.lctr_id); // 명시적으로 문자열로 변환
		console.log(lctr_id);
        // 강의 클릭 시 수신자 목록 가져오기
		lectureCell.onclick = () => {
            const lctr_id = lecture.lctr_id; // 현재 강의 ID를 상수에 저장
            console.log("lectureId to pass:", lctr_id);
            fetchRecipients(lctr_id);
};

        const selectedRecipientCell = document.createElement('td');
        selectedRecipientCell.setAttribute('id', `selectedRecipient-${lecture.lctr_id}`);
        
        tr.appendChild(lectureCell);
        tr.appendChild(selectedRecipientCell);
        lectureBody.appendChild(tr);
    });
}
async function fetchRecipients(lctr_id) {
    try {
        //   const response = await fetch(`/api/lectures/recipients?lctr_id=${lctr_id}`);
       const response = await fetch('/api/lectures/recipients?lctr_id='+lctr_id);
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const data = await response.json();
        displayRecipients(data, lctr_id);
    } catch (error) {
        console.error('Error fetching recipients:', error);
        // 사용자에게 오류 메시지 표시
        alert('수신자를 가져오는 중 오류가 발생했습니다.');
    }
}
	
function displayRecipients(recipients, lctr_id) {
    const selectedRecipientCell = document.getElementById(`selectedRecipient-${lctr_id}`);
    selectedRecipientCell.innerHTML = ''; // 기존 수신자 초기화

    // 각 수신자를 div로 생성하여 표시
    recipients.forEach(recipient => {
        const recipientDiv = document.createElement('div');
        recipientDiv.style.display = 'flex';  // 이름과 체크박스를 가로로 정렬
        recipientDiv.style.alignItems = 'center';  // 체크박스를 수평 가운데로 정렬
        recipientDiv.style.marginBottom = '10px';  // 각 수신자 항목 간의 간격을 설정

        const checkbox = document.createElement('input');
        checkbox.type = 'checkbox';
        checkbox.setAttribute('data-user-seq', recipient.inst_seq || recipient.std_seq);
        checkbox.style.width = '15px';  // 체크박스 크기 설정
        checkbox.style.height = '15px'; // 체크박스 크기 설정

        recipientDiv.appendChild(checkbox); // 체크박스를 먼저 추가

        const nameSpan = document.createElement('span');
        nameSpan.textContent = recipient.inst_name || recipient.std_name;
        nameSpan.style.marginLeft = '10px';  // 체크박스와 이름 간의 간격

        recipientDiv.appendChild(nameSpan); // 이름을 나중에 추가

        selectedRecipientCell.appendChild(recipientDiv);
    });

    // 수신자가 한 명 이상일 경우 버튼 표시
    const sendMessageButton = document.getElementById('sendMessageButton');
    sendMessageButton.style.display = recipients.length > 0 ? 'block' : 'none';
}
//수신자를 선택하여 받는사람 필드에 추가하는 함수
function selectRecipient() {
    const selectedRecipients = [];
    const receiversInput = document.getElementById("receivers");

    // 모델에 저장된 값 가져오기
    const rcvrSeqElement = document.querySelector('input[name="rcvr_seq"]');
    const modelSeq = rcvrSeqElement ? rcvrSeqElement.value : null;  // 요소가 존재하면 값 가져오기, 아니면 null
    const modelName = receiversInput ? receiversInput.value : null;  // receiversInput이 null일 경우 처리

    // 모델에 값이 있으면 배열에 추가
    if (modelSeq && modelName) {
        selectedRecipients.push({ userSeq: modelSeq, userName: modelName });
    } else {
        // 체크된 수신자를 모아 selectedRecipients 배열에 추가
        document.querySelectorAll('#lectureTable input[type="checkbox"]:checked').forEach(checkbox => {
            const userSeq = checkbox.getAttribute('data-user-seq'); // 수신자 seq 가져오기
            const userName = checkbox.parentElement.textContent.trim(); // 수신자 이름 가져오기
            selectedRecipients.push({ userSeq, userName }); // 이름과 seq 객체로 저장
        });
    }
    // 선택된 수신자가 없을 때 경고 메시지 표시
    if (selectedRecipients.length === 0) {
        alert("수신자를 선택해주세요.");
        return;
    }

    // 선택된 수신자 이름을 문자열로 결합하여 "받는 사람" 필드에 추가
    receiversInput.value = selectedRecipients.map(r => r.userName).join(', ');

    // 모달 닫기
    closeModal();
    
    // 수신자 seq 배열 반환 (다른 함수에서 사용될 수 있도록)
    return selectedRecipients;
}

// 메시지 전송 함수
function sendMessage() {
    const noteTitle = document.querySelector('[name="note_ttl"]').value; // 제목
    if (!noteTitle) {
        alert('제목을 입력해주세요.');
        return;
    }

    const noteContent = document.querySelector('[name="note_cn"]').value;
    const sndptySeq = document.querySelector('[name="sndpty_seq"]').value;
    const sndptyNoteYn = document.querySelector('[name="sndpty_note_yn"]').value;
    const rcvrNoteYn = document.querySelector('[name="rcvr_note_yn"]').value;
    const bfrNoteSnElement = document.querySelector('[name="bfr_note_sn"]');
    const bfrNoteSn = bfrNoteSnElement ? bfrNoteSnElement.value : null;
    
    // selectRecipient 호출하여 선택된 수신자 가져오기
    const selectedRecipients = selectRecipient();
    if (!selectedRecipients) return; // 선택된 수신자가 없다면 종료

    const messageData = {
    	    sndpty_seq: sndptySeq,
    	    rcvr_seq: selectedRecipients.map(r => r.userSeq).join(','), // 수신자 seq만 추출하여 콤마로 구분된 문자열로 변환
    	    note_ttl: noteTitle,
    	    note_cn: noteContent,
    	    sndpty_note_yn: sndptyNoteYn,
    	    rcvr_note_yn: rcvrNoteYn,
    	    bfr_note_sn:bfrNoteSn
    	};

    console.log("messageData:", messageData); // messageData가 제대로 설정되었는지 확인

    // Ajax 요청 코드 (예시)
    fetch('/api/notes', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(messageData)
    })
    .then(response => response.json())
    .then(data => {
        if (data === 1) {
            alert('쪽지가 전송되었습니다.');
			// 성공하면 보낸 쪽지 목록으로 이동
			window.location.href = '/notes/sent';  // 보낸 쪽지 목록 페이지로 이동
        } else {
            alert('쪽지 전송에 실패했습니다.');
        }
    })
    .catch(error => console.error('Error:', error));
}
	// 모달 닫기 함수
	function closeModal() {
	    document.getElementById('recipientModal').style.display = 'none'; // 모달 숨기기
	}
	</script>
</head>
<body>


	<div class="container">
		<div class="contents">
			<h1>쪽지 작성</h1>
		</div>

		<form method="post" action="/api/notes" onsubmit="event.preventDefault(); sendMessage();">


			<input type="hidden" name="sndpty_seq" value="${sessionScope.user_seq}"> 
			<input type="hidden"	name="sndpty_note_yn" value="N"> 
			<input type="hidden" name="rcvr_note_yn" value="N">

	
			<table class="list">
				<tr>
					<th>받는사람</th>
					<td>
					<c:choose>
						    <c:when test="${not empty rcvr_seq}">
						        <input type="hidden" name="rcvr_seq" value="${rcvr_seq}">
						        <input type="text" id="receivers" name="receivers" value="${receiver_name}" readonly>
						        <input type="hidden" name="bfr_note_sn" value="${bfr_note_sn}">
						    </c:when>
						    <c:otherwise>
						        <input type="text" id="receivers" name="receivers" readonly>
						<button type="button" onclick="openRecipientModal()">추가</button> 
						<!-- 값을 직접 확인 --></td>
						    </c:otherwise>
						</c:choose>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="note_ttl" required></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="note_cn" rows="10" required></textarea></td>
				</tr>
			</table>

			<button type="submit">작성완료</button>
		</form>
	</div>


	<!-- 수신자 선택 모달 -->
	<div id="recipientModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<h2>쪽지 보내기</h2>
			<table id="lectureTable" class="table">
				<thead>
					<tr>
						<th>강의 목록</th>
						<th>수신자 선택</th>
					</tr>
				</thead>
				<tbody id="lectureBody">
					<tr>
						<td id="lectureList"></td>
						<td id="lecturePeople"></td>
					</tr>
				</tbody>
			</table>
			
			<button id="sendMessageButton" style="display: none;"
				onclick="selectRecipient()">수신자 추가하기</button>
		</div>
	</div>
</body>
</html>