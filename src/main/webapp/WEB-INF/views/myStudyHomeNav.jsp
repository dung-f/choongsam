<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	.header_nav{
		  position: fixed;
		  width: auto;
		  top:0;
		  height: 100vh;
		  z-index: 1;
		  background-color: #304742;
		  overflow:hidden;
		  transition:width .3s ease;
		  cursor:pointer;
		  @media screen and (min-width: 600px) {
		    width: 320px;
		  }
	}
	
	.header_butt {
	    width: 320px;
	    height: 90px;
	    font-size: 30px;
	    color: white;
	    display: flex;
	    align-items: center;
	    border-bottom: solid 2px white;
	    transition: background-color 0.2s ease, transform 0.3s ease, box-shadow 0.3s ease;
	}
	
	.header_butt:hover {
	    background-color: #00664F;
	    color: white;
	    transform: scale(1.1);
	    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3);
	}
	
	.header_link{
		margin-left: 50px;
	}
	
	.header_butt a {
		color: white;
		text-decoration: none;
	}
	
	.header_detail {
		width:300px;
		/* margin-left: 50px; */
		margin-top: 100px;
	}
	
	.header_info{
		margin-top: 50px;
		margin-bottom: 50px;
		margin-left: 50px;
		color: white;
	}
</style>

</head>

<body>

<nav>
	<div class="header_nav">

		<div class="header_detail">
			<div class="header_info">
				<!-- <label class="header_user">사용자 정보 </label> -->
				<div class="header_userName">
					<c:out value="${sessionScope.username}" />
				</div>
			</div>

			<div class="header_butt">
				<c:if test="${usertype == 1002}">
					<a href="/sh_lecture_teacher?lctr_id=${lctr_id }&user_seq=${sessionScope.user_seq}" class="header_link">내 강의실</a>
				</c:if>
				<c:if test="${usertype == 1001}">
					<a href="/sh_lecture_student?lctr_id=${lctr_id }&user_seq=${sessionScope.user_seq}" class="header_link">내 강의실</a>
				</c:if>
			</div>
			<div class="header_butt">
				<c:if test="${usertype == 1001}"><a href="/Jhe/studAtt?lctr_id=${lctr_id}&onoff=${onoff}" class="header_link">출석</a></c:if>
				<c:if test="${usertype == 1002}"><a href="/Jhe/profAttMain?lctr_id=${lctr_id}&onoff=${onoff}" class="header_link">출석</a></c:if>
			</div>
			<div class="header_butt">
				<c:if test="${usertype == 1001}"><a href="/Jhe/studHomeworkList?lctr_id=${lctr_id}" class="header_link">과제</a></c:if>
				<c:if test="${usertype == 1002}"><a href="/Jhe/profHomeworkList?lctr_id=${lctr_id}" class="header_link">과제</a></c:if>
			</div>
			<%-- <div class="header_butt">
				<c:if test="${usertype == 1001}"><a href="/Jhe/studGrade?lctr_id=${lctr_id}" class="header_link">성적</a></c:if>
				<c:if test="${usertype == 1002}"><a href="/Jhe/profGrade?lctr_id=${lctr_id}" class="header_link">성적</a></c:if>
			</div> --%>
		</div>

	</div>
</nav>

</body>
</html>
