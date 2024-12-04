<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../headerGreen.jsp" %>
<%@ include file="../myPageNav.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의사항 상세</title>
    <style>
        body {
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            flex-direction: column;
            position: relative;
            background-color: white;
            top: 120px;
            width: 1320px;
            margin: 0 auto;
            box-sizing: border-box;
            height: auto;
            padding: 20px; /* 여백 추가 */
            font-size: 20px;
        }

        .list {
            margin: 50px 0;
        }

        table {
            padding: 0;
            width: 1280px;
            border-top: 2px solid black;
        }

        th {
            width: 200px;
            color: gray;
            font-weight: bold;
            text-align: center;
            padding: 20px 0;
            border-bottom: 0.4px solid #e2e8ee;
            font-size: 20px;
        }

        td {
            border-bottom: 0.4px solid #e2e8ee;
            border-left: 0.4px solid #e2e8ee;
            cursor: pointer;
            font-weight: bold;
            color: #323232;
            font-size: 14px;
            height: 50px;
             padding: 20px;
              font-size: 20px;
        }
        
		.contentsss{
		    vertical-align: top; /* 내용 위쪽 정렬 */
		    height: 200px;
		    padding: 20px;
		    overflow-y: auto; /* 세로 스크롤 추가 */
    		word-wrap: break-word; /* 긴 단어 줄바꿈 */
		}

        .manager_pagination {
            text-align: center;
        }

        h1 {
            font-size: 40px;
        }

        input {
            width: 950px;
            height: 50px;
            font-size: 20px;
            border: #949494 1px solid;
            border-radius: none;
        }

         /* 기존 스타일 및 추가 스타일 */
         .file-preview {
            margin-top: 10px;
            max-width: 100%;
            height: auto;
            border: 1px solid #ddd;
            padding: 10px;
        }

        textarea {
            width: 950px;
            height: 400px;
            font-size: 20px;
            border: #949494 1px solid;
            border-radius: none;

        }
        
         button {
            width: 200px;
            text-align: center;
            /* 버튼 가운데 정렬을 위한 추가 스타일 */
            margin: 20px auto; /* 버튼을 가운데 정렬 */
            display: block; /* 블록으로 설정 */
            height: 50px;
            background-color: #00664F;
            border: none;
            color: white;
        }
       .contentsss {
		    padding: 20px;
		    font-size: 16px;
		    line-height: 1.6; /* 내용의 줄 간격 조정 */
		    white-space: normal; /* 텍스트 줄바꿈 정상 처리 */
		    word-wrap: break-word; /* 긴 단어는 자동으로 줄바꿈 처리 */
		    overflow-wrap: break-word; /* 단어가 길어지면 줄바꿈 처리 */
		}

        .answer-row {
            background-color: #f0f8ff;
        }
        
.contentsss, .answer-content {
  vertical-align: top; /* 내용 위쪽 정렬 */
    padding: 20px;
    font-size: 16px;
    line-height: 1.6;
    white-space: pre-wrap; /* 텍스트 줄바꿈 자동 처리 */
    word-wrap: break-word;
    overflow-wrap: break-word;
    overflow-y: auto;
    height: 200px;
    
}
.writeNoticeBtn {
	float: right;
	width: 200px;
	height: 50px;
	background-color: #00664F;
	border: none;
	color: white;
	text-align: center;
	margin-top: 10px; /* 버튼과 검색 바 간격 */
	text-decoration: none; /* 링크 스타일 없애기 */
	display: flex; /* flexbox 사용 */
	justify-content: center; /* 텍스트 가운데 정렬 */
	align-items: center; /* 세로 가운데 정렬 */
}

/* 모달 기본 스타일 */
.modal {
				display: none;
				/* 기본적으로 숨김 */
				position: fixed;
				z-index: 1;
				left: 0;
				top: 0;
				width: 100%;
				height: 100%;
				background-color: rgba(0, 0, 0, 0.5);
			}

			/* 모달 콘텐츠 스타일 */
			.modal-content {
				background-color: #fff;
				margin: 15% auto;
				padding: 20px;
				border: 1px solid #888;
				width: 50%;
			}

			.close {
				color: #aaa;
				float: right;
				font-size: 28px;
				font-weight: bold;
			}

			.close:hover,
			.close:focus {
				color: #000;
				text-decoration: none;
				cursor: pointer;
			}
			
			
			.NavBtn {
	display: flex;
	justify-content: center;
}

.NavBtn button{
		width: 200px;
	text-align: center;
	margin: 20px 20px; 
	display: block; 
	height: 50px;
	background-color: #00664F;
	border: none;
	color: white;
	font-size: 16px;
	text-decoration: none;
}
			
    </style>
    <script type="text/javascript">
    async function fetchAskDetail() {
        try {
            const response = await fetch(`/api/asks/${dscsn_sn}`);
            if (!response.ok) {
                throw new Error(`Error fetching notice: ${response.status}`);
            }
            const ask = await response.json();

            console.log(ask); // note 객체를 콘솔에 출력하여 구조 확인

            // 제목과 내용을 가져와서 표시
            document.getElementById('dscsn_ttl').textContent = ask.dscsn_ttl;
            document.getElementById('dscsn_cn').textContent = ask.dscsn_cn;
           


            // 답변이 존재하면 답변 표시
            if (ask.dscsn_ans_yn === 'Y' && ask.dscsn_ans_cn) {
                // 답변 내용이 있을 경우에만 보여주기
                document.getElementById('dscsn_ans_cn').textContent = ask.dscsn_ans_cn;
                // 답변 영역을 보이게 설정
                document.getElementById('dscsn_ans').style.display = 'table-row'; 
            } else {
                document.getElementById('dscsn_ans_cn').textContent = "답변이 아직 등록되지 않았습니다.";
                // 답변 영역을 숨김
                document.getElementById('dscsn_ans').style.display = 'none';
                
                
            }

            // dscsn_sn 값을 히든 input에 설정
        document.getElementById('dscsn_sn').value = ask.dscsn_sn;

// 모달에서 사용할 수 있도록 ask.dscsn_cn을 textarea에 설정
document.getElementById('dscsn_ans_cn').value = ask.dscsn_cn;

        } catch (error) {
            console.error('Error:', error);
            document.getElementById('dscsn_ttl').textContent = "문의사항을 불러올 수 없습니다.";
            document.getElementById('dscsn_cn').textContent = error.message;
        }
    }

    window.onload = fetchAskDetail;


    //모달 열기 함수
function openModal() {
	document.getElementById("adminModal").style.display = "block";
}

// 모달 닫기 함수
function closeModal() {
	document.getElementById("adminModal").style.display = "none";
}

// 모달 외부를 클릭했을 때 닫기
window.onclick = function (event) {
	var modal = document.getElementById("adminModal");
	if (event.target == modal) {
		modal.style.display = "none";
	}
}
      </script>
</head>
<body>



	<div class="container">
		<div class="contents">
			<h1>1:1 문의사항</h1>
		</div>
		<table class="list">
			<tr>
				<th>제목</th>
				<td id="dscsn_ttl"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td class="contentsss" id="dscsn_cn"></td>
			</tr>
			<tr id="dscsn_ans" class="answer-row" style="display: none;">
				<th>답변</th>
				<td class="answer-content" id="dscsn_ans_cn"></td>
			</tr>
		</table>

<div class="NavBtn">

		<button onclick="history.back();">목록</button>

		<c:choose>
			<c:when test="${sessionScope.usertype == 1003}">
				<!-- userType이 1003일 경우 버튼을 보여줍니다 -->
				<button onclick="openModal()">답변등록</button>
			</c:when>
			<c:otherwise>
				<!-- userType이 1003이 아닐 경우 버튼은 보이지 않습니다 -->
				<!-- 아무 것도 출력하지 않음 -->
			</c:otherwise>
		</c:choose>



</div>

	</div>

	<div id="adminModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal()">&times;</span>
                    <h2>답변 작성</h2>
                    <form action="/api/asks/reply" method="post">
                        <input type="hidden" id="dscsn_sn" name="dscsn_sn">
                        <input type="hidden" id="dscsn_ans_yn" name="dscsn_ans_yn" value="Y">
                        <textarea id="dscsn_ans_cn" name="dscsn_ans_cn"></textarea>
                        <div class="form-group">
                            <button type="submit">답변 등록하기</button>
                        </div>
                    </form>
                </div>
            </div>
       
    
</body>
</html>
