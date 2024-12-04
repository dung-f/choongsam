<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../headerGreen.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
    /* 페이지 배경을 흰색으로 설정 */
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
        background-color: #fff; /* 배경 흰색 */
        color: #333; /* 기본 텍스트 색상 */
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    
    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
    }
    
    th {
        background-color: #f4f4f4;
        font-weight: bold;
    }
    
    /* 예약 메시지 스타일 */
    .checkIdMsg {
        margin-top: 5px;
        font-size: 14px;
        font-weight: bold;
    }
    
    /* 선택된 강의실의 예약 가능 여부 메시지 색상 */
    .available {
        color: #00664F; /* 포인트 색상 */
    }
    
    .unavailable {
        color: red;
    }
    
    /* 등록 버튼 스타일 */
    input[type="submit"] {
        background-color: #00664F; /* 포인트 색상 */
        color: white;
        padding: 10px 20px;
        border: none;
        cursor: pointer;
        font-size: 16px;
        margin-top: 20px;
        transition: background-color 0.3s ease;
    }
    
    input[type="submit"]:disabled {
        background-color: #ccc;
        cursor: not-allowed;
    }

    /* 테이블 헤더 스타일 */
    th {
        background-color: #f4f4f4;
        color: #00664F; /* 포인트 색상 */
    }

    /* 선택 박스 스타일 */
    select {
        font-size: 14px;
        padding: 5px;
        color: #00664F; /* 포인트 색상 */
    }

    /* 테이블 내 텍스트 색상 */
    td {
        color: #333;
    }
</style>
<script type="text/javascript">
    function saveTimeTbl(ahnIndex) {
        var lctr_id  = $('#lctr_id').val();
        var schd =  $('#schd' + ahnIndex).val();
        var lctr_room =  $('#lctr_room' + ahnIndex).val();
        var checkIdMsg = $("#checkIdMsg" + ahnIndex);

        if (lctr_room === "null") {
            checkIdMsg.text("강의실을 지정해 주십시오").removeClass("available").addClass("unavailable");
            checkAllReservations();
            return; // 강의실 선택이 안 된 경우, Ajax 요청을 하지 않음
        }

        $.ajax({
            url: '/overlapCheck',
            type: 'GET',
            dataType: 'json',
            data: {
                'schd': schd,
                'lctr_room': lctr_room
            },
            success: function(data) {
                if (data === true) {
                    checkIdMsg.text("예약 가능합니다").removeClass("unavailable").addClass("available");
                } else {
                    checkIdMsg.text("이미 예약된 시간대입니다").removeClass("available").addClass("unavailable");
                }
                
                // 모든 예약 가능 메시지 확인
                checkAllReservations();
            }
        });
    }

    function checkAllReservations() {
        var allAvailable = true;
        $('div[id^="checkIdMsg"]').each(function() {
            if ($(this).text() !== "예약 가능합니다") {
                allAvailable = false;
                return false; // 루프 종료
            }
        });
        
        // 모든 메시지가 "예약 가능합니다" 일 때만 submit 버튼 활성화
        $('input[type="submit"]').prop('disabled', !allAvailable);
    }

    $(document).ready(function() {
        // 초기화 시 submit 버튼 비활성화
        $('input[type="submit"]').prop('disabled', true);
    });
</script>
</head>
<body>
    <form action="addClassRoom">
        <input type="hidden" id="lctr_id" name="lctr_id" value="${lctr_id }">
        <table>
            <tr>
                <th>No</th>
                <th>시간</th>
                <th>강의실</th>
            </tr>
            <c:forEach var="schd" items="${schdList}" varStatus="status">
                <input type="hidden" id="schd${status.index}" name="schd${status.index}" value="${schd}">
                <tr>
                    <td>${status.index}</td>
                    <td>${schd}</td>
                    <td>
                        <select id="lctr_room${status.index}" name="lctr_room${status.index}" onchange="saveTimeTbl(${status.index})">
                            <option value="null" selected="selected">지정안됨</option>
                            <c:forEach var="classroom" items="${classroomList}">
                                <option value="${classroom.room_name}">${classroom.room_name}</option>
                            </c:forEach>
                        </select>
                        <div id="checkIdMsg${status.index}" class="checkIdMsg"></div>
                    </td>
                    <c:if test="${status.last}">
                        <input type="hidden" name="count" value="${status.index}">
                    </c:if>
                </tr>
            </c:forEach>
        </table>
        <input type="submit" value="등록" disabled>
    </form>
</body>
</html>
