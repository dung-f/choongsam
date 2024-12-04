<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ include file="../header.jsp" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>공지사항</title>
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
					border-left:0.4px solid #e2e8ee; 
				}

				td {
					border-bottom: 0.4px solid #e2e8ee;
					border-left:0.4px solid #e2e8ee; 
					cursor: pointer;
					font-weight: bold;
					text-align: center;
					/* 중앙 정렬 */
					color: #323232;
				
					height: 50px;
				}


				.manager_pagination{
					text-align: center;

				}
				h1{
					font-size: 40px;

				}
				
				.contents1{
				display: flex;
				justify-content: space-between;
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
			
			.keyword{
				height: 40px;
				width: 255px;
				border-radius: 10px;
				border: 1px #949494 solid;
				font-size: 20px;
				text-align: center;
			}
			
			.search_btn{
				height: 40px;
				border-radius: 10px; 
				background-color:#00664F;
				width: 70px;
				font-size: 20px;
				color: white;
				border: none;
				
			}
			
			select{
			height: 40px;
				width: 255px;
				border-radius: 10px;
				border: 1px #949494 solid;
				font-size: 20px;
				text-align: center;
				color: #949494;
			
			}
			
			td a{
				color: black;
				text-decoration: none;
			}
			
			td a:hover {
				text-decoration: underline;
			}
			
			.content3{
			display: flex;
			 
			}

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


			</style>
		</head>
		<script type="text/javascript">
		
		
		</script>

		<body>


			<div class="container">
				<div class="contents">
					<h1>공지사항</h1>
				</div>

				<div class="contents1" >
				<div class="content2">
				
				
					<form action="/api/notice" id="frm">
						<div class="manager_Qna_header_search">
							<input type="text" name="keyword" class="keyword" id="keyword" placeholder="제목 또는 내용">
							<button type="submit" class="search_btn">검색</button>
						</div>
					</form>
				</div>
					<div class="content3">
					<c:if test="${sessionScope.usertype == 1003}">
					    <a class="activeBtn" href="/api/notice/new">작성</a>
					    <form action="/api/notice/delete" method="post" id="deleteForm">
					    <button class="activeBtn" type="submit" onclick="return confirm('정말 비활성화하시겠습니까?');">비활성화</button>
					    </form>
					</c:if>
					
					
					
					</div>

				</div>


				
					<table class="list">
						<thead>
							<tr>
								<c:choose>
								 <c:when test="${usertype == 1003}">
									<th>선택</th>
									</c:when>
								</c:choose>
								<th>번호</th>
								<th>제목</th>
								<th>등록일</th>
						<c:choose>
								 <c:when test="${usertype == 1003}">
									<th>노출여부</th>
									</c:when>
								</c:choose>
							</tr>
						</thead>
					<c:if test="${total>0}">
						<tbody>
						<c:set var="startIndex" value="${total - (page.currentPage - 1) * page.rowPage}" />
						
							<c:forEach var="notice" items="${noticeList}" varStatus="status">
								<tr>
								<c:choose>
								 <c:when test="${usertype == 1003}">
									<td> <input type="checkbox" name="deleteIds" value="${notice.ntc_mttr_sn}" form="deleteForm"></td>
									</c:when>
								</c:choose>
								
								
									<td>${startIndex - status.index}</td>
									<td><a href="/view_Sjm/noticeDetail?ntc_mttr_sn=${notice.ntc_mttr_sn}">${notice.ntc_mttr_ttl}</a></td>
									<td>${notice.ntc_mttr_dt}</td>
									<c:choose>
									    <c:when test="${usertype == 1003}">
									        <td>
									            <c:choose>
									                <c:when test="${notice.ntc_mttr_yn == 'Y'}">
									                    <span class="answered">활성</span>
									                </c:when>
									                <c:when test="${notice.ntc_mttr_yn == 'N'}">
									                    <span class="not-answered">비활성</span>
									                </c:when>
									                <c:otherwise>
									                    <span style="color: gray;">알 수 없음</span>
									                </c:otherwise>
									            </c:choose>
									        </td>
									    </c:when>
									</c:choose>
								</tr>
							</c:forEach>
						</tbody>
					</c:if>



			<c:if test="${total == 0}">
        <tbody>
            <tr>
                <td colspan="3" style="text-align: center;">등록된 공지사항이 없습니다.</td>
            </tr>
        </tbody>
    </c:if>
					</table>







				<!-- 페이징 네비게이션 ------------------------------------- -->
				<div class="manager_pagination">

					<!-- 이전 페이지 ------------------->
					<c:if test="${page.startPage > page.pageBlock}">
						<a id="page" class="pagination_a_back"
							href="/api/notice?currentPage=${page.startPage - page.pageBlock > 0 ? page.startPage - page.pageBlock : 1}&total=${total}&keyword=${keyword}">
							이전 </a>
					</c:if>


					<!-- 현재 페이지 ------------------->
					<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
						<c:choose>
							<c:when test="${i == page.currentPage}">
								<span class="pagination_current">${i}</span>
							</c:when>
							<c:otherwise>
								<a id="page" class="pagination_a"
									href="/api/notice?currentPage=${i}&total=${total}&keyword=${keyword}">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<!--  다음 페이지 -------------------->
					<c:if test="${page.endPage < page.totalPage}">
						<a class="pagination_a_next" id="page"
							href="/api/notice?currentPage=${page.startPage+page.pageBlock}&total=${total}&keyword=${keyword}">다음</a>
					</c:if>
				</div>

			</div>

	<footer>
		<%@ include file="../footer.jsp" %>
	
	</footer>

<script type="text/javascript">
function submitDeleteForm() {
    // 체크된 항목이 없으면 경고창 표시
    if (document.querySelectorAll('#deleteForm input[type="checkbox"]:checked').length === 0) {
        alert("삭제할 공지사항을 선택해주세요.");
        return;
    }
    // 폼 제출
    document.getElementById('deleteForm').submit();
}

</script>

		</body>

		</html>