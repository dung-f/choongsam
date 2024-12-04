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
<style type="text/css">
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>과제 등록</title>
</head>
<body>
	<div class="container">
	<div class="contents">
		<h1>과제 등록</h1>
	</div>
		<form action="/Jhe/insertHomework" method="post" id="insertHomework" enctype="multipart/form-data">
			<table>
				<tr>
					<th>강의명</th>
					<td>${findByLctrName.lctr_name}</td>
				</tr>
				<tr>
					<th>과제명</th>
					<td><input type="text" name="asmt_nm" required></td>
				</tr>
				<tr>
					<th>시작일</th>
					<td><input type="text" name="sbmsn_bgng_ymd" required></td>
				</tr>
				<tr>
					<th>마감일</th>
					<td><input type="text" name="sbmsn_end_ymd"></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td>
						<div class="file_list">
							<div>
								<div class="file_input">
									<input type="file" name="files" onchange="selectFile(this);" />
									<button type="button" onclick="removeFile(this);" class="btns del_btn">
										<span>삭제</span>
									</button>
									<button type="button" onclick="addFile();" class="btns fn_add_btn">
										<span>파일 추가</span>
									</button>
								</div>
							</div>
						</div>
					</td>
				<tr>
					<th>과제내용</th>
					<td><textarea name="asmt_cn"></textarea>
					<input type="hidden" name="lctr_id" value="${findByLctrName.lctr_id}"></td>
				</tr>
			</table>
			<input type="submit" value="등록" class="submitBtn" style=" margin-left: 180px; margin-top: 10px;">
			<a href="../Jhe/profHomeworkList?lctr_id=${findByLctrName.lctr_id}"><button type="button" class="submitBtn">취소</button></a>
		</form>
	</div>

	<script type="text/javascript">
     // 파일 선택
     function selectFile(element) {

         const file = element.files[0];
         const filename = element.closest('.file_input').firstElementChild;

         // 1. 파일 선택 창에서 취소 버튼이 클릭된 경우
         if ( !file ) {
             filename.value = '';
             return false;
         }

         // 2. 파일 크기가 10MB를 초과하는 경우
         const fileSize = Math.floor(file.size / 1024 / 1024);
         if (fileSize > 10) {
             alert('10MB 이하의 파일로 업로드해 주세요.');
             filename.value = '';
             element.value = '';
             return false;
         }

         // 3. 파일명 지정
         filename.value = file.name;
     }


     // 파일 추가
     function addFile() {
         const fileDiv = document.createElement('div');
         fileDiv.innerHTML =`
             <div class="file_input">
                 <input type="text" readonly />
                 <label> 첨부파일
                     <input type="file" name="files" onchange="selectFile(this);" />
                 </label>
             </div>
             <button type="button" onclick="removeFile(this);" class="btns del_btn"><span>삭제</span></button>
         `;
         document.querySelector('.file_list').appendChild(fileDiv);
     }


     // 파일 삭제
     function removeFile(element) {
         const fileAddBtn = element.nextElementSibling;
         if (fileAddBtn) {
             const inputs = element.previousElementSibling.querySelectorAll('input');
             inputs.forEach(input => input.value = '')
             return false;
         }
         element.parentElement.remove();
     }
    </script>

</body>
</html>