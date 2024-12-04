<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../headerGreen.jsp" %>
<%@ include file="../myPageNav.jsp" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>문의사항</title>
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
	width: 1200px;
	/* 중앙 정렬 */
	margin: 0 auto;
	/* padding을 width에 포함하여 계산 */
	box-sizing: border-box;
	/* 자동으로 좌우 여백을 설정하여 가운데 정렬 */
	margin: 0 auto;
	height: 1300px;
	margin-bottom: 300px;
	
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
	font-size: px;
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
	width: 200px;
	height: 50px;
	background-color: #00664F;
	border: none;
	color: white;
	text-align: center;
	margin-top: 10px; /* 버튼과 검색 바 간격 */
	text-decoration: none; /* 링크 스타일 없애기 */
	display: flex; /* flexbox 사용 */
	justify-content: center; /* 텍스트 가운데 정렬 */
	align-items: center; /* 세로 가운데 정렬 */
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

/* 답변이 있는 경우 */
.answered {
    background-color: #00664F;
    color: white;
    font-weight: bold; /* 굵은 글씨 */
    text-align: center; /* 텍스트 가운데 정렬 */
    padding: 5px 10px; /* 패딩을 줄여서 버튼처럼 보이게 */
    font-size: 15px; /* 글씨 크기 줄이기 */
    height: 30px; /* 셀 높이 조정 */
    line-height: 20px; /* 텍스트가 셀 안에서 가운데 오도록 설정 */
    border-radius: 5px; /* 둥근 모서리 */
    cursor: pointer; /* 마우스 포인터가 버튼처럼 보이게 */
	
}

/* 답변이 없는 경우 */
.not-answered {
    background-color: red;
    color: white;
    font-weight: bold; /* 굵은 글씨 */
    text-align: center; /* 텍스트 가운데 정렬 */
    padding: 5px 10px; /* 패딩을 줄여서 버튼처럼 보이게 */
    font-size: 15px; /* 글씨 크기 줄이기 */
    height: 30px; /* 셀 높이 조정 */
    line-height: 20px; /* 텍스트가 셀 안에서 가운데 오도록 설정 */
    border-radius: 5px; /* 둥근 모서리 */
    cursor: pointer; /* 마우스 포인터가 버튼처럼 보이게 */
}

td.cell-no {
    width:10%;  /* 번호 셀의 너비 */
}

td.cell-title {
    width: 50%;  /* 제목 셀의 너비 */
    text-align: center; /* 텍스트는 가운데 정렬 */
    padding-left: 100px; /* 왼쪽 패딩을 주어 텍스트 위치를 조정 */
    padding-right: 100px; /* 오른쪽 패딩을 주어 균형 맞추기 */
}


td.cell-date {
    width: 25%;
}
td.cell-Yn {
    width: 15%;
}
</style>
</head>

<body>


	<div class="container">

		<div class="contents">
			<h1>1:1 문의사항</h1>
		</div>

		<div class="contents1">
		
				<div class="manager_Qna_header_search">
					<input type="text" name="keyword" class="keyword" id="keyword">
					<button type="submit" class="search_btn">검색</button>
				</div>
			

			<a class="writeNoticeBtn" href="/asks/new">문의사항 작성</a>
		</div>



		<table class="list">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성날짜</th>
					<th>답변여부</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>







		<!-- 페이징 네비게이션 ------------------------------------- -->
		<div class="manager_pagination">

		</div>

	</div>

	

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
			fetchNotes(`/api/asks?currentPage=\${currentPage}&keyword=\${encodeURIComponent(keyword || '')}`);
	
			// 검색 버튼 클릭 시 검색어와 페이지를 URL에 포함하여 이동
			document.querySelector('.search_btn').addEventListener('click', function(event) {
				event.preventDefault();
				const keyword = document.querySelector('.keyword').value;
				window.location.href = `/asks/my?currentPage=1&keyword=\${encodeURIComponent(keyword)}`;
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
					populateNoteTable(data.asks, data.paging, data.total);
					updatePagination(data.paging, data.total, data.keyword);
				})
				.catch(error => console.error('에러:', error));
		}
	
		function onPageClick(currentPage) {
			// 현재 입력된 검색어 가져오기
			const keyword = document.querySelector('.keyword').value;
			console.log(keyword);
			// 페이지 번호를 클릭하면 URL을 생성하고 fetchNotes 호출
			const url = "/api/asks?currentPage=" + currentPage + "&keyword=" + encodeURIComponent(keyword);
			fetchNotes(url);
		}
	
		// 받은 쪽지 테이블에 데이터를 채워주는 함수
		function populateNoteTable(asks, paging, total) {
			const tableBody = document.querySelector('.list tbody');
			tableBody.innerHTML = ''; // 기존 데이터 초기화
	
			if (asks.length === 0) {
				const emptyRow = `<tr><td colspan="3" style="text-align: center;">등록된 문의사항이 없습니다.</td></tr>`;
				tableBody.innerHTML = emptyRow;
				return;
			}
	
			let rows = '';
			const startIndex = total - ((paging.currentPage - 1) * paging.rowPage);  
	
			
			
			asks.forEach((ask, index) => {
				const indexInTable = startIndex - index;  
				const answerStatusClass = ask.dscsn_ans_yn === 'Y' ? 'answered' : 'not-answered'; // 조건에 맞는 클래스를 할당
				const answerStatusText = ask.dscsn_ans_yn === 'Y' ? '답변완료' : '미답변';
				
				rows += `
					<tr>
					<td class="cell-no">\${indexInTable}</td> <!-- 순번 표시 -->
					<td class="cell-title"><a href="/asks/\${ask.dscsn_sn}">\${ask.dscsn_ttl}</a></td> <!-- 제목에 a태그 추가 -->
					<td class="cell-date">\${ask.dscsn_reg_dt}</td>
						<td class="cell-Yn"><span class="\${answerStatusClass}">\${answerStatusText}</span></td>
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
					const url = "/api/asks?currentPage=" + i + "&keyword=" + encodeURIComponent(searchKeyword);
					paginationHtml += `<a class="pagination_a" href="javascript:void(0);" onclick="onPageClick(\${i})">\${i}</a>`;
				}
			}
	
			// 다음 페이지
			if (paging.endPage < paging.totalPage) {
				paginationHtml += `<a class="pagination_a_next" href="javascript:void(0);" onclick="onPageClick(\${paging.startPage + paging.pageBlock})">다음</a>`;
			}
	
			paginationContainer.innerHTML = paginationHtml;
		}
	</script>
	
</body>

</html>