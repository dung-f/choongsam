<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%@ include file="../myStudyHomeNav.jsp" %>
<%@ include file="../headerGreen.jsp" %>
	
<style>
    #listBody {
        width: 1582px;
        min-height: 100vh;
        background-color: #F1F1F1;
        margin-left: auto;
    }

    .infor {
        height: 130px;
        background-color: white;
        padding: 15px;
    }

    #inforText {
        width: 1400px;
        text-align: center;
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

    .box {
        margin-left: 100px;
        margin-top: 50px;
        width: 1320px;
        height: 400px;
        background-color: white;
        display: flex;
        justify-content: center; /* 가로 중앙 정렬 */
        align-items: center; /* 세로 중앙 정렬 */
    }

    .info1 {
        display: flex;
        flex-direction: column; /* 수직 정렬 */
        align-items: center; /* 가로 중앙 정렬 */
        text-align: center;
    }

    .txt {
        font-size: 35px;
        font-weight: bold;
        margin-bottom: 20px; /* 버튼과 텍스트 사이의 간격 */
    }

    .butt1 {
    	margin-top: 20px;
        height: 90px;
        width: 300px;
        background-color: #00664F;
        color: white;
        text-align: center;
        line-height: 90px; /* 버튼 텍스트 수직 중앙 정렬 */
        font-size: 25px;
		border-radius: 8px;
		box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3); /* 마우스 오버 시 그림자 */
    }
</style>



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
	
		
			<div class="box">
				<div class="info1">
					<label class="txt">${lectName } 강의가 성공적으로 등록되었습니다.</label>
					<a href="/sh_lecture_teacher?lctr_id=${lctr_id }&user_seq=${user_seq}">
						<div class="butt1">
							강의 화면으로 이동
						</div>
					</a>
				</div>
			</div>
		
		
		</div>
	

	
	
</body>
</html>