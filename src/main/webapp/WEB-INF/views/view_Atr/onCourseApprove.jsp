<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../headerGreen.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lecture Details</title>

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* General Styles */
        body {
            background-color: #faf9f6;
            color: #333;
            font-family: Arial, sans-serif;
     
        }

        h2 {
            text-align: center;
            color: #00664F;
            font-size: 2.5em;
            font-weight: bold;
            margin-bottom: 20px;
            margin-top: 20px;
            text-shadow: 1px 1px 5px rgba(85, 107, 47, 0.6);
        }

        table {
            width: 50%;
            margin: auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #e5e5e5;
        }

        th {
            background-color: #00664F;
            color: white;
            font-weight: bold;
            text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.1);
        }

        td {
            color: #333;
            background-color: #f9f8f5;
        }

        /* Form Button Styles */
        input[type="submit"] {
            background: linear-gradient(90deg, #556b2f, #6b8e23);
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            display: block;
            margin: 20px auto;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 10px rgba(85, 107, 47, 0.3);
        }

        input[type="submit"]:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(85, 107, 47, 0.4);
            background: linear-gradient(90deg, #6b8e23, #556b2f);
        }

        /* Input Box Styling */
        input[name="lctr_id"] {
            width: 50%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            display: block;
            margin: 20px auto;
            background-color: #faf9f6;
            color: #333;
        }
    </style>
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
    
    <form action="approveOnlineCourse">
        <input type="text" name="lctr_id" value="${lecture.lctr_id}" hidden="">
        <input type="submit" value="개설 허가">
    </form>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
