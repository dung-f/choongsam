<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../myStudyHomeNav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%-- <%@ include file="../myPageNav.jsp" %> --%>

<%@ include file="../myStudyHomeNav.jsp" %>
<%@ include file="../headerGreen.jsp" %>

<style>

	a{
		text-decoration: none;
	}
	
	#listBody{
		width: 1582px;
		height: 100vh;
		background-color: #F1F1F1;
		float: right;
	}
	
	.infor {
		height: 130px;
		background-color: white;
		padding: 15px;
	}
	
	#inforText {
		width: 1400px;
		text-align:center;
	}
	
	#lectureName {
		width: 1560px;
		height: 119px;
		text-align: center;
		font-size: 45px;
	}
	
	.teachName {
		margin-top: 20px;
	}
	
	#teachName {
		font-size: 25px;
		color: #A6A6A6;
		margin-bottom: 20px;
	}
	
	.list {
		width: 1370px;
		height: 173px;
		background-color: white;
		margin-bottom: 11px;
		display: flex;
		padding: 15px;
		margin-top: 15px;
		margin-left: 15px;
		border-radius: 8px;
		box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3); /* 마우스 오버 시 그림자 */
	}
	
	.thumbnailDiv {
		height: 160px;
		width: 250px;
	}
	
	#thumbnail {
		height: 170px;
		border-radius: 17px;
	}
	
	.vdoInfor {
		width: 566px;
		display: flex;
		margin-left: 90px;
	}
	
	.buttStatus {
		width: 240px;
		height: 86px;
		margin-left: 50px;
		font-size: 25px;
		font-weight: bold;
	}
	
	#chashi {
		font-size: 25px;
		color: #BBBBBB;
		width: 250px;
		height: 43px;
		margin-bottom: 20px;
	}
	
	#gigan {
		width: 485px;
	}
	
	#perTxt {
		font-size: 15px;
		color: #D9D9D9;
		margin-right: 5px;
	}
	
	#viewingPeriod {
		font-size: 15px;
		color: #BBBBBB;
		width: 565px;
		text-align: right;
		margin-left: 110px;
	}
	
	#title {
		font-size: 35px;
	}
	
	#startDiv {
		width:246px;
		height: 81px;
		background-color: #00664F;
		color: white;
	    display: flex;            /* Flexbox 사용 */
	    align-items: center;     /* 수직 중앙 정렬 */
   		justify-content: center;  /* 수평 중앙 정렬 */
		border-radius: 8px;
	}
	
	.chashiGigan{
		display: flex;
	}
	
	.percent {
		font-size: 20px;
		color: #D9D9D9;
		margin-left: 5px;
	}
	
	#meter{
		width: 460px;
		height: 30px;
	}
	
	.state {
	    width: 242px;
	    height: 78px;
	    margin-bottom: 10px;
	    display: flex;            /* Flexbox 사용 */
	    align-items: center;     /* 수직 중앙 정렬 */
	    justify-content: center;  /* 수평 중앙 정렬 */
	    text-align: center;      /* 텍스트 중앙 정렬 */
		border-radius: 8px;
	}
	
	.chulseokDiv {
	    border: 2px #00664F solid; /* 출석일 때 테두리 색 */
	    color: #00664F;
	    
	}
	
	.gyeolseokDiv {
	    border: 2px #C51616 solid; /* 결석일 때 테두리 색 */
	    color: #C51616;
	}
	
	.misugangDiv {
	    border: 2px #BBBBBB solid; /* 미수강일 때 테두리 색 */
	    color: #BBBBBB;
	}
	
	.jindo {
		display: flex;
		align-items: center;
		margin-top: 25px;
	}
	
	
	.offline {
		font-size: 90px;
        margin-left: 35vh;
        margin-top: 100px;
	}
	
	
	
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<body>
	<div id="listBody">
		<div class="infor">
			<div id="inforText">
				<span id="lectureName">
				${lectName }
			</span>
			<div class="teachName">
				<span id="teachName">
					${teacherName } 강사님
				</span>
			</div>
			</div>
		</div>
	
		
		<div class="offline">
			오프라인 강의입니다
		</div>
		
		
</div>
	

	
	
</body>
</html>