<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../headerGreen.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lecture Details</title>

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: white;
            color: #333;
            font-family: Arial, sans-serif;
        }

        h2 {
            text-align: center;
            color: #556b2f;
            font-size: 2em;
            margin-bottom: 20px;
            margin-top: 20px;
        }

        table {
            width: 50%;
            margin: auto;
            border-collapse: collapse;
            background-color: #fdfdfd;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #00664F;
            color: white;
            font-weight: 600;
        }

        .checkIdMsg {
            margin-top: 5px;
            font-size: 14px;
            font-weight: bold;
        }

        .available {
            color: #6b8e23;
        }

        .unavailable {
            color: #b22222;
        }

        input[type="submit"] {
            background-color: #556b2f;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            margin-left:50%;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
            transition: background-color 0.3s;
            margin-bottom: 30px;
        }

        input[type="submit"]:hover {
            background-color: #6b8e23;
        }

        input[type="submit"]:disabled {
            background-color: #ccc;
            color: #777;
            cursor: not-allowed;
        }

        .accordion .card-header {
            background-color: #e9e9e9;
            border-bottom: 1px solid #ccc;
        }

        .btn-link {
            color: #556b2f;
            font-weight: bold;
            text-decoration: none;
        }

        .btn-link:hover {
            color: #6b8e23;
        }

        .card-body {
            background-color: #fdfdfd;
            color: #333;
            border: 1px solid #ccc;
        }
    </style>

    <script type="text/javascript">
        function saveTimeTbl(ahnIndex) {
            var lctr_id = $('#lctr_id').val();
            var schd = $('#schd' + ahnIndex).val();
            var lctr_room = $('#lctr_room' + ahnIndex).val();
            var checkIdMsg = $("#checkIdMsg" + ahnIndex);

            if (lctr_room === "null") {
                checkIdMsg.text("강의실을 지정해 주십시오").removeClass("available").addClass("unavailable");
                checkAllReservations();
                return;
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
                    
                    checkAllReservations();
                }
            });
        }

        function checkAllReservations() {
            var allAvailable = true;
            $('div[id^="checkIdMsg"]').each(function() {
                if ($(this).text() !== "예약 가능합니다") {
                    allAvailable = false;
                    return false;
                }
            });

            $('input[type="submit"]').prop('disabled', !allAvailable);
        }

        $(document).ready(function() {
            $('input[type="submit"]').prop('disabled', true);
        });
    </script>
</head>
<body>
    <h2>강의 상세</h2>
    <table>
        <tr>
            <th>강사</th>
            <td>${lecture.user_name}</td>
        </tr>
        <tr>
            <th>대면여부</th>
            <td>${lecture.onoff_tr}</td>
        </tr>
        <tr>
            <th>분류</th>
            <td>${lecture.lctr_category}</td>
        </tr>
        <tr>
            <th>강의명</th>
            <td>${lecture.lctr_name}</td>
        </tr>
        <tr>
            <th>모집인원</th>
            <td>${lecture.lctr_count}</td>
        </tr>
        <tr>
            <th>모집시작일</th>
            <td>${lecture.rcrt_date}</td>
        </tr>
        <tr>
            <th>수강료</th>
            <td>${lecture.lctr_cost}</td>
        </tr>
        <tr>
            <th>강의상태</th>
            <td>${lecture.lctr_state}</td>
        </tr>
        <tr>
            <th>평가기준</th>
            <td>${lecture.eval_criteria}</td>
        </tr>
        <tr>
            <th>개강일</th>
            <td>${lecture.lctr_start_date}</td>
        </tr>
        <tr>
            <th>차시 수</th>
            <td>${lecture.lctr_cntschd}</td>
        </tr>
        <tr>
            <th>시간표</th>
            <td>
                <div class="accordion" id="scheduleAccordion">
                    <div class="card">
                        <div class="card-header" id="headingOne">
                            <h5>${lecture.lctr_schd}</h5>
                            <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                강의실 등록
                            </button>
                        </div>
                        <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#scheduleAccordion">
                            <div class="card-body">
                                <form action="approveOfflineCourse">
                                    <input type="hidden" id="lctr_id" name="lctr_id" value="${lctr_id}">
                                    <table>
                                        <tr>
                                            <th>시간</th>
                                            <th>강의실</th>
                                        </tr>
                                        <c:forEach var="schd" items="${schdList}" varStatus="status">
                                            <input type="hidden" id="schd${status.index}" name="schd${status.index}" value="${schd}">
                                            <tr>
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
                            </div>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <!-- 강의 계획 모달 버튼 -->
	<div class="text-center mt-3">
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#syllabusModal" style="background-color: #00664F"
			id="lookDetail">강의 계획 보기</button>
	</div>

	<!-- 강의 계획 모달 -->
	<div class="modal fade" id="syllabusModal" tabindex="-1" role="dialog"
		aria-labelledby="syllabusModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="syllabusModalLabel">강의 계획</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<table class="syllabus-table table table-bordered">
						<tbody>
							<c:forEach var="syllabus" items="${syllabusList}"
								varStatus="status">
								<c:choose>
									<c:when test="${status.index eq 0 }">
										<tr>
											<th style="width: 20%;">강의 목표</th>
											<td>${syllabus.lctr_otln}</td>
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<th style="width: 20%;">${status.index}주차강의계획</th>
											<td>${syllabus.lctr_otln}</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
    
    
    <input type="submit" value="개설 허가" disabled>
    </form>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
<footer><%@ include file="../footer.jsp"%></footer>
</html>
