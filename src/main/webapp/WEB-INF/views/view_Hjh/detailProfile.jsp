<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../headerGreen.jsp" %>
<%@ include file="../myPageNav.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
</head>
<body>

<main>
    <h2>사용자 정보 수정 처리</h2>

    <c:if test="${not empty param.user_id}">
        <p>사용자 ID: ${param.user_id}</p>
        <p>수정된 이름: ${param.user_name}</p>
        <p>수정된 이메일: ${param.email}</p>
        <p>수정된 주소: ${param.address}</p>
        <p>수정된 전화번호: ${param.phone_num}</p>
        <p>수정된 생년월일: ${param.birth}</p>
    </c:if>


    <c:if test="${not empty param.user_name}">
        <p>수정 완료되었습니다.</p>
    </c:if>

</main>

</body>
</html>
