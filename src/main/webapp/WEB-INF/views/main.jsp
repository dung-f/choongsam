<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>


    <style>
    
    	/* 애니메이션 정의
	    @keyframes slideIn {
	        from {
	            transform: translateX(20%); /* 화면 밖 오른쪽에서 시작
	        }
	        to {
	            transform: translateX(0); /* 원래 위치로 이동
	        }
	    } */
   		
   		body{
   			text-align: center;
   			background-color: #F1F1F1;
   			width: 100%;
   		}
   		
   		tr, td {
   			height: 40px;
   			border: solid 3px #F1F1F1;
   		}
   		
   		.main_container{
   			height: 511px;
   		}
   		
   		/* 애니메이션 적용 */
	    #banner {
	        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3);
	        /* animation: slideIn 1.8s ease-out; /* 1.5초 동안 애니메이션 실행 */
	        width: 100%; /* 이미지가 화면 너비에 맞춰지도록 설정 */ */
	    }
   		
   		table{
   			text-align: center;
   			font-size: 20px;
   			margin: 0 auto;
   			width: 1100px;
   			background-color: white;
   			border-collapse: collapse;
   		}
   		
   		#tableHead {
   			background-color: #00664F;
   			color: white;
   			height: 20px;
   			font-size: 25px;
   		}
   		
   		.onoff {
   			width: 160px;
   		}
   		
   		.lctrName {
   			width: 177px;
   		}
		
		.lctrStartDay {
			width: 140px;
		}
		
		.lctrCnt {
			width: 100px;
		}
		
		.regiCnt {
			width: 100px;
		}
		
		.noticeDate {
			width: 280px;
		}
		
		.lectureList {
			margin-top: 80px;
			margin-bottom: 100px;
		}
		
		.noticeGongji {
			margin-top: 100px;
			margin-bottom: 150px;
		}
		
		.bannerBottom {
			width: 1920px;
			background-color: #00664F;
			text-align: center;
		}
		
		.info {
			font-size: 40px;
			color: #00664F;
			font-weight:bold;
			margin-right: 43%;
			
		}
    </style>

		
		
		 
    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
    </head>

	      

    <body>
        
        <header>
         	<%@ include file="header.jsp" %>
        </header>

       <div class="main_container">

        
        
       	<!-- 하단의 div는 메인페이지를 이미지로 넣지않고 따로 만드는경우 사용하는 것으로 함 -->
        <div class="main">
        	<img alt="배너" src="../image/banner.png" id="banner">
        	
        	
        	<div class="lectureList">
        			<label class="info">모집중인 강의</label>
        			<table>
        				<tr id="tableHead">
        					<td class="onoff">온/오프라인 여부</td>
        					<td class="lctrName">강의명</td>
        					<td class="lctrStartDay">개강일</td>
        					<td class="lctrCnt">모집인원수</td>
        					<td class="regiCnt">신청인원수</td>
        				</tr>
        				
        				<c:forEach var="list" items="${lecture}">
        					<tr>
        						<c:if test="${list.onoff == 7001}">
								    <td class="onoff">대면</td>
								</c:if>
								<c:if test="${list.onoff == 7002}">
								    <td class="onoff">비대면</td>
								</c:if>

        						<td class="lctrName">${list.lctr_name }</td>
        						<td class="lctrStartDay">${list.lctr_start_date }</td>
        						<td class="lctrCnt">${list.lctr_count }</td>
        						<td class="regiCnt">${list.register_count }</td>
        					</tr>
        				</c:forEach>
        			</table>
        	</div>
        	
        	<div class="bannerBottom">
        		<img alt="배너" src="../image/bannerBottom.png">
        	</div>
        	
        	
        	
        	<div class="noticeGongji">
        		<label class="info">최근 공지사항</label>
        		<table>
        				<tr id="tableHead">
        					<td class="noticeTtl">공지제목</td>
        					<td class="noticeDate">공지 등록 날짜</td>
        				</tr>
        				
        				<c:forEach var="notice" items="${notice}">
        					<tr>
        						<td class="noticeTtl">${notice.ntc_mttr_ttl }</td>
        						<td class="noticeDate">${notice.ntc_mttr_dt }</td>
        					</tr>
        				</c:forEach>
        			</table>
        	</div>
        </div>
        


        
    </body>
    
    	<footer>
            <%@ include file="footer.jsp" %>
        </footer>

    </html>