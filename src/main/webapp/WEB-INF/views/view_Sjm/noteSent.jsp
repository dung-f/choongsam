<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../headerGreen.jsp" %>
<%@ include file="../myPageNav.jsp" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>쪽지함</title>
<style>
body {
	margin: 0;
	padding: 0;
}

.container {
	display: flex;
	flex-direction: column;
	position: relative;
	/* 컨테이너의 배경색을 흰색에 가까운 연한 회색으로 설정합니다. */
	background-color: white;
	/* 컨테이너에 미세한 그림자를 추가하여 입체감을 줍니다. */
	top: 120px;
	/*  컨테이너의 너비 1320px 고정 */
	width: 1320px;
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

.manager_pagination {
	text-align: center;
}

h1 {
	font-size: 40px;
}

.contents1 {
	display: flex;
	justify-content: space-between;
}

.writeNoticeBtn {
	width: 150px;
	height: 50px;
	background-color: #00664F;
	border: none;
	color: white;
	 font-size: 20px;
	text-align: center;
	text-decoration: none; /* 링크 스타일 없애기 */
	display: flex; /* flexbox 사용 */
	justify-content: center; /* 텍스트 가운데 정렬 */
	align-items: center; /* 세로 가운데 정렬 */
	 font-weight: bold;
}

.pagination_current {
	border-radius: 10px;
	width: 35px; /* 크기를 키움 */
	height: 35px; /* 높이 설정 */
	border: 1px solid black;
	display: inline-flex;
	justify-content: center;
	align-items: center; /* 텍스트 가운데 정렬 */
	font-size: 18px; /* 폰트 크기 조정 */
	background-color: black;
	color: white;
}

.pagination_a {
	border-radius: 10px;
	width: 35px; /* 크기를 키움 */
	height: 35px; /* 높이 설정 */
	border: 1px solid black;
	display: inline-flex;
	justify-content: center;
	align-items: center; /* 텍스트 가운데 정렬 */
	font-size: 18px; /* 폰트 크기 조정 */
	text-decoration: none; /* 링크 스타일 없애기 */
	color: black; /* 링크 색상 설정 */
}

.keyword {
	height: 40px;
	width: 255px;
	border-radius: 10px;
	border: 1px #949494 solid;
	font-size: 20px;
	text-align: center;
}

.search_btn {
	height: 40px;
	border-radius: 10px;
	background-color: #00664F;
	width: 70px;
	font-size: 20px;
	color: white;
	border: none;
}

select {
	height: 40px;
	width: 255px;
	border-radius: 10px;
	border: 1px #949494 solid;
	font-size: 20px;
	text-align: center;
	color: #949494;
}

td a {
	color: black;
	text-decoration: none;
}

td a:hover {
	text-decoration: underline;
}
.red-text {
     background-color: red;
    color: white;
    border-radius: 10px;
    margin-right: 10px;
    display: inline-block; /* 인라인 블록으로 변경하여 박스 형태로 만듬 */
    padding: 3px 7px; /* 내부 여백을 추가하여 넓히기 */
    width: auto; /* 자동으로 너비를 조정 (필요에 따라 고정 값으로 변경 가능) */
    
}

td.cell-del {
    width:10%;  /* 번호 셀의 너비 */
}
td.cell-no {
    width:10%;  /* 번호 셀의 너비 */
}

td.cell-title {
    width: 40%;  /* 제목 셀의 너비 */
    text-align: center; /* 텍스트는 가운데 정렬 */
    padding-left: 100px; /* 왼쪽 패딩을 주어 텍스트 위치를 조정 */
    padding-right: 100px; /* 오른쪽 패딩을 주어 균형 맞추기 */
}

td.cell-name {
    width: 15%;  /* 보낸사람 셀의 너비 */
}
td.cell-date {
    width: 25%;
}
.content3{
			display: flex;
			 
			}
				.activeBtn{
				width: 100px;
	            height: 50px;
	            background-color: #00664F;
	            border: none;
	            color: white;
	            text-align: center;
	            text-decoration: none; /* 링크 스타일 없애기 */
	            display: flex; /* flexbox 사용 */
	            justify-content: center; /* 텍스트 가운데 정렬 */
	            align-items: center; /* 세로 가운데 정렬 */
	            font-size: 20px;
	            font-weight: bold;
	            margin-left: 20px;
	    
				}

</style>
</head>


<body>


	<div class="container">

		<div class="contents">
			<h1>보낸 쪽지</h1>
		</div>

		<div class="contents1">
		<div class="contents2">
				<div class="manager_Qna_header_search">
				 <input type="text" name="keyword" class="keyword" id="keyword">
					<button type="submit" class="search_btn">검색</button>
				</div>
				</div>
			<div class="content3">
			<a class="writeNoticeBtn" href="/notes/new">쪽지 보내기</a>
			<form action="/api/note/delete" method="post" id="deleteForm">
			<button class="activeBtn" type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">쪽지 삭제</button>
			</form>
		
		</div>
		</div>



		<table class="list">
			<thead>
				<tr>
				<th>선택</th>
					<th>번호</th>
					<th>제목</th>
					<th>받은사람</th>
					<th>보낸날짜</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>







		<!-- 페이징 네비게이션 ------------------------------------- -->
		<div class="manager_pagination">


		</div>

	</div>

	<footer>
		<%@ include file="../footer.jsp"%>

	</footer>
	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function() {
			// 페이지 로드 시 URL에서 검색어를 추출하여 입력 필드에 설정
			const urlParams = new URLSearchParams(window.location.search);
			const keyword = urlParams.get('keyword');
			if (keyword) {
				document.querySelector('.keyword').value = keyword;
			}
		
			// 받은쪽지 목록을 가져오고, 검색어가 있을 경우 해당 검색어와 함께 요청
			const currentPage = urlParams.get('currentPage') || 1;  // 기본 페이지는 1로 설정
			fetchNotes(`/api/notes/sent?currentPage=\${currentPage}&keyword=\${encodeURIComponent(keyword || '')}`);
		
			// 검색 버튼 클릭 시 검색어와 페이지를 URL에 포함하여 이동
			document.querySelector('.search_btn').addEventListener('click', function(event) {
				event.preventDefault();
				const keyword = document.querySelector('.keyword').value;
				window.location.href = `/notes/sent?currentPage=1&keyword=\${encodeURIComponent(keyword)}`;
			});
		});
		
		function fetchNotes(apiUrl) {
			console.log("너야 ?", apiUrl);
			fetch(apiUrl)
				.then(response => {
					if (!response.ok) {
						throw new Error('네트워크 오류 발생');
					}
					return response.json();
				})
				.then(data => {
					populateNoteTable(data.notes, data.paging, data.total);
					updatePagination(data.paging, data.total, data.keyword);
				})
				.catch(error => console.error('에러:', error));
		}
		
		function onPageClick(currentPage) {
			// 현재 입력된 검색어 가져오기
			const keyword = document.querySelector('.keyword').value;
			console.log(keyword);
			// 페이지 번호를 클릭하면 URL을 생성하고 fetchNotes 호출
			const url = "/api/notes/sent?currentPage=" + currentPage + "&keyword=" + encodeURIComponent(keyword);
			fetchNotes(url);
		}
		
		// 받은 쪽지 테이블에 데이터를 채워주는 함수
		function populateNoteTable(notes, paging, total) {
			const tableBody = document.querySelector('.list tbody');
			tableBody.innerHTML = ''; // 기존 데이터 초기화
		
			if (notes.length === 0) {
				const emptyRow = `<tr><td colspan="3" style="text-align: center;">등록된 쪽지가 없습니다.</td></tr>`;
				tableBody.innerHTML = emptyRow;
				return;
			}
		
			let rows = '';
			const startIndex = total - (paging.currentPage - 1) * paging.rowPage;  // startIndex 계산
		
			notes.forEach((note, index) => {
				const indexInTable = startIndex - index;  // 각 항목의 번호 계산
		
				const checkboxDisabled = note.rcvr_note_yn === 'Y' ? 'disabled' : '';
				
				
				rows += `
					<tr>
					<td class="cell-del"> <input type="checkbox" name="deleteIds" value="\${note.note_sn}" form="deleteForm"
                    onclick="if (!this.checked && !note.rcptn_dt) { alert('삭제할 수 없는 항목입니다.'); }"></td>
					<td class="cell-no">\${indexInTable}</td> <!-- 순번 표시 -->
						<td class="cell-title"><a href="/note/\${note.note_sn}">\${note.note_ttl}</a></td> <!-- 제목에 a태그 추가 -->
						<td class="cell-name">\${note.receiver_name}</td>
						<td class="cell-date">\${note.dsptch_dt}</td>
					</tr>
				`;
			});
			tableBody.innerHTML = rows; // 모든 행을 한 번에 추가
		}
		
		function updatePagination(paging, total, keyword) {
			const paginationContainer = document.querySelector('.manager_pagination');
			let paginationHtml = '';
		
			// keyword가 undefined일 경우 빈 문자열로 처리
			const searchKeyword = (keyword === undefined || keyword === null) ? '' : keyword;
			console.log(searchKeyword);
			
			// 이전 페이지
			if (paging.startPage > paging.pageBlock) {
				paginationHtml += `<a class="pagination_a_back" href="javascript:void(0);" onclick="onPageClick(\${paging.startPage - paging.pageBlock})">이전</a>`;
			}
		
			// 페이지 번호
			for (let i = paging.startPage; i <= paging.endPage; i++) {
				if (i === paging.currentPage) {
					paginationHtml += `<span class="pagination_current">\${i}</span>`;
				} else {
					console.log("여기는 페이지 누를때 서치 키워드 -->", searchKeyword);
					const url = "/api/notes/sent?currentPage=" + i + "&keyword=" + encodeURIComponent(searchKeyword);
					paginationHtml += `<a class="pagination_a" href="javascript:void(0);" onclick="onPageClick(\${i})">\${i}</a>`;
				}
			}
		
			// 다음 페이지
			if (paging.endPage < paging.totalPage) {
				paginationHtml += `<a class="pagination_a_next" href="javascript:void(0);" onclick="onPageClick(\${paging.startPage + paging.pageBlock})">다음</a>`;
			}
		
			paginationContainer.innerHTML = paginationHtml;
		}
		
		
		function submitDeleteForm() {
		    // 체크된 항목이 없으면 경고창 표시
		    if (document.querySelectorAll('#deleteForm input[type="checkbox"]:checked').length === 0) {
		        alert("삭제할 쪽지를 선택해주세요.");
		        return;
		    }
		    
		    
		    
		    // 폼 제출
		    document.getElementById('deleteForm').submit();
		}
		
		
		</script>
		


</body>

</html>