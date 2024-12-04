<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 	
 	<style>
	    .footer_container {
	        display: flex; /* flexbox로 설정 */
	        align-items: center; /* 세로로 중앙 정렬 */
	        background-color: #00664F;
	        width: 100%; /* 화면의 가로폭을 꽉 채움 */
	        height: auto;
	        position: relative;
	        padding: 50px 0px 50px 0px;
	    }
	
	    .footer_main {
	        display: flex;
	        align-items: center; /* 이미지가 세로로 중앙 정렬되도록 */
	        justify-content: center; /* 이미지가 수평으로 중앙 정렬되도록 */
	        margin-left: 22%;
	    }
	
	    .footerInfo {
	        display: flex;
	        flex-direction: column; /* 세로로 정렬된 텍스트가 있는 컨테이너 */
	        gap: 20px; /* 각 텍스트 그룹 사이에 여백 */
	        margin-left: 50px; /* 왼쪽 여백 */
	    }
	
	    .footer_text_hed,
	    .footer_text_body,
	    .footer_text_footer {
	        display: flex;
	        gap: 10px; /* 각 텍스트 사이에 여백 */
	    }
	
	    .footer_text_hed_text1 {
	        color: white;
	    }
	
	    .footer_text_hed_text2 {
	        color: white;
	    }
	
	    .footer_text_hed_text3 {
	        font-size: 12px;
	        color: white;
	    }
	
	    .footer_text_hed_a1,
	    .footer_text_hed_a2 {
	        color: white;
	        font-weight: bold;
	    }
	
	    .footer_end_img {
	        margin-left: 15px;
	    }
	
	    .footer_img {
	        height: 200px;
	    }
	</style>
 	
 	
</head>
<body>

	<div class="footer_container">
		<div class="footer_main">
			<img alt="logo이미지" src="../image/footerLogo.png" class="footer_img">
		</div>
		
		<div class="footerInfo">
			<div class="footer_text_hed">
				<a href="#" class="footer_text_hed_a1">개인정보 처리방침</a>
				<div class="footer_text_hed_text1">│</div>
				<a href="#" class="footer_text_hed_a2">서비스 이용약관</a>
				<div class="footer_text_hed_text1">│</div>
				<a href="#" class="footer_text_hed_a2">이용약관</a>
			</div>
			<div class="footer_text_body">
				<div class="footer_text_hed_text2">중삼대</div>
				<div class="footer_text_hed_text1">│</div>
				<div class="footer_text_hed_text2">대표자: 조하은</div>
				<div class="footer_text_hed_text1">│</div>
				<div class="footer_text_hed_text2">개인정보보호책임자: 손정민</div>
				<div class="footer_text_hed_text1">│</div>
				<div class="footer_text_hed_text2">사업자등록번호:739-32-324230</div>
			</div>
			<div class="footer_text_footer">
				<div class="footer_text_hed_text2">사업장소재지: 서울특별시 마포구 신촌로 176, 3층 301호</div>
			</div>
			<div class="footer_text_end">
				<div class="footer_text_hed_text3">Copyright © 중삼 All Rights Reserved</div>
				<div class="footer_text_end_img">
				</div>
			</div>
		</div>
	</div>
</body>
</html>