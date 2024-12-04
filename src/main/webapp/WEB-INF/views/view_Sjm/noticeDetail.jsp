<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../headerGreen.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세</title>
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

#file-list a {
    font-size: 20px;
    color: #00664F; /* 링크 색상 */
    text-decoration: underline; /* 밑줄 제거 */
}

.NavBtn {
	display: flex;
	justify-content: center;
}

.NavBtn a {
	width: 200px;
	text-align: center;
	margin: 20px 20px; 
	display: block; 
	height: 50px;
	background-color: #00664F;
	border: none;
	color: white;
	font-size: 16px;
	text-decoration: none;
}

#historyBtn {
width: 200px;
	text-align: center;
	/* 버튼 가운데 정렬을 위한 추가 스타일 */
	margin: 20px 20px; /* 버튼을 가운데 정렬 */
	display: block; /* 블록으로 설정 */
	height: 50px;
	background-color: #00664F;
	border: none;
	color: white;
		font-size: 16px;
}
</style>
<script type="text/javascript">

    // URL에서 공지사항 번호(ntc_mttr_sn) 추출
    const urlParams = new URLSearchParams(window.location.search);
    const ntc_mttr_sn = "${ntc_mttr_sn}";  // 서버에서 전달받은 파라미터를 JavaScript 변수로 사용
    console.log(ntc_mttr_sn); // 확인용

    // 공지사항 데이터 가져오기
    async function fetchNoticeDetail() {
        try {
            const response = await fetch(`/api/notice/${ntc_mttr_sn}`);
            if (!response.ok) {
                throw new Error(`Error fetching notice: ${response.status}`);
            }
            const notice = await response.json();

            // 가져온 데이터를 HTML 요소에 넣기
            document.getElementById('notice.ntc_mttr_ttl').textContent = notice.ntc_mttr_ttl;
            document.getElementById('notice.ntc_mttr_cn').textContent = notice.ntc_mttr_cn;
            const ntc_mttr_sn = "${ntc_mttr_sn}";  // 서버에서 전달된 값
            
            console.log(notice.file_group);
            
         // 파일 정보 가져오기
            const filesResponse = await fetch('/api/files/'+notice.file_group);
            const files = await filesResponse.json();
            
         // 파일 정보 표시
            const fileListElement = document.getElementById('file-list');
            if (files && files.length > 0) {
            	files.forEach(file => {
            	    const fileName = file.file_nm;  // 파일 이름
            	    const fileExtension = file.file_extn_nm || '';  // 파일 확장자, 없으면 빈 문자열로 처리

            	    console.log(fileName);
            	    console.log(fileExtension);
            	    // 파일 이름과 확장자가 정상적으로 결합되었는지 확인
            	    console.log(`File: `+fileName+`.`+fileExtension+``);
					console.log(`/api/files/`+file.file_group+`/`+file.file_seq+``);
            	   // 이미지 파일인지 확인
				   if (['jpg', 'jpeg', 'png', 'gif'].includes(fileExtension.toLowerCase())) {
                    // 이미지 파일인 경우
                    const imgElement = document.createElement('img');
                    imgElement.src = `/api/files/` + file.file_group + `/` + file.file_seq;  // 이미지 경로 설정
                    imgElement.alt = fileName;  // 대체 텍스트 설정
                    imgElement.style.maxWidth = '100%';  // 이미지 크기 조정

                    const fileItem = document.createElement('li');
                    fileItem.appendChild(imgElement);
                    fileListElement.appendChild(fileItem);
                } else {
                    // 이미지 파일이 아닌 경우
                    const fileLink = document.createElement('a');
                    fileLink.href = `/api/files/` + file.file_group + `/` + file.file_seq;  // 파일 다운로드 경로 설정
                    fileLink.textContent = `\${fileName}.\${fileExtension}`;
                    fileLink.target = '_blank';  // 새 탭에서 열기

                    const fileItem = document.createElement('li');
                    fileItem.appendChild(fileLink);
                    fileListElement.appendChild(fileItem);
                }
            });
        } else {
            fileListElement.innerHTML = '<li>첨부파일이 없습니다.</li>';
        }

    } catch (error) {
        console.error('Error:', error.message);
    }
}

    // 페이지 로드 시 공지사항 상세 정보 가져오기
    window.onload = () => {
        const urlParams = new URLSearchParams(window.location.search);
        const ntc_mttr_sn = urlParams.get('ntc_mttr_sn');  // URL에서 공지사항 번호 가져오기
        fetchNoticeDetail(ntc_mttr_sn);
    };
      </script>
</head>
<body>



	<div class="container">
		<div class="contents">
			<h1>공지사항</h1>
		</div>
		<table class="list">
			<tr>
				<th>제목</th>
				<td id="notice.ntc_mttr_ttl"></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td id="file-list">
					<!-- 파일 목록이 여기에 추가됩니다. -->
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td class="contentsss" id="notice.ntc_mttr_cn"></td>
			</tr>
		</table>

<div class="NavBtn">
		<button id="historyBtn" onclick="history.back();">목록</button>
		<c:if test="${sessionScope.usertype == 1003}">
		<button id="historyBtn" onclick="location.href='/api/notice/edit?ntc_mttr_sn=${ntc_mttr_sn}'">수정</button>
		</c:if>
		<%-- <a href="/api/notice/edit?ntc_mttr_sn=${ntc_mttr_sn}"><span>수정</span></a> --%>

</div>
	</div>

</body>
</html>
