<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../headerGreen.jsp" %>
<%@ include file="../myPageNav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지 상세</title>
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
	width: 1320px;
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
	color: #323232;
	font-size: 14px;
	height: 50px;
	padding: 20px;
	font-size: 20px;
}

.contentsss {
	vertical-align: top; /* 내용 위쪽 정렬 */
	height: 500px;
	padding: 20px;
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

.NavBtn {
	display: flex;
	justify-content: center;
}

button {
	width: 200px;
	text-align: center;
	/* 버튼 가운데 정렬을 위한 추가 스타일 */
	margin: 20px 20px; /* 버튼을 가운데 정렬 */
	display: block; /* 블록으로 설정 */
	height: 50px;
	background-color: #00664F;
	border: none;
	color: white;
}
</style>
<script type="text/javascript">

    async function fetchNoteDetail() {
        try {
            const response = await fetch(`/api/notes/${note_sn}`);
            if (!response.ok) {
                throw new Error(`Error fetching notice: ${response.status}`);
            }
            const note = await response.json();
            
            console.log(note); // note 객체를 콘솔에 출력하여 구조 확인

            // 가져온 데이터를 HTML 요소에 넣기
            document.getElementById('note_ttl').textContent = note.note_ttl;
            document.getElementById('note_cn').textContent = note.note_cn;
            document.getElementById('dsptch_dt').textContent = note.dsptch_dt;

            // 보낸사람과 받은사람 설정
            const userSeq = "${sessionScope.user_seq}"; // JSP에서 세션의 user_seq를 가져옴
            console.log('userSeq:', userSeq); // userSeq 출력
            console.log('note.sndpty_seq:', note.sndpty_seq); // sndpty_seq 출력

            // 답장하기 버튼의 링크를 동적으로 설정
            const replyButton = document.getElementById("replyButton");
            replyButton.onclick = function() {
            	
            	const note_sn = note.note_sn;
            	const sndpty_seq =note.sndpty_seq;
            	const sender_name = note.sender_name
            	
            	
                location.href = '/notes/new?note_sn='+ note_sn + '&sndpty_seq=' + sndpty_seq +'&sender_name=' +sender_name ;
            };
            
            const senderReceiverRow = document.getElementById('sender_receiver');

            if (userSeq === note.sndpty_seq) {
                senderReceiverRow.innerHTML = `<th>받은사람</th><td>` + note.receiver_name + `</td>`;
            } else {
                senderReceiverRow.innerHTML = `<th>보낸사람</th><td>` + note.sender_name + `</td>`;
            }
            
            
        } catch (error) {
            console.error('Error:', error);
            document.getElementById('note_ttl').textContent = "쪽지를 불러올 수 없습니다.";
            document.getElementById('note_cn').textContent = error.message;
        }
    }

    window.onload = fetchNoteDetail;
      </script>
</head>
<body>





	<div class="container">
		<div class="contents">
			<h1>쪽지</h1>
		</div>
		<table class="list">
			<tr>
				<th>제목</th>
				<td id="note_ttl"></td>
			</tr>
			<tr>
				<th>보낸날짜</th>
					<td  id="dsptch_dt"></td>
			</tr>
			<tr id="sender_receiver">
					
			</tr>
			
			<tr>
				<th>내용</th>
				<td class="contentsss" id="note_cn"></td>
			</tr>
		</table>
		<div class="NavBtn">
			<button onclick="history.back();">목록</button>
			
			<button id="replyButton">답장하기</button>

		</div>
	</div>

	<footer>
		<%@ include file="../footer.jsp"%>

	</footer>
</body>
</html>
