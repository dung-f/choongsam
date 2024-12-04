<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<style type="text/css">
    body {
        margin: 0;
        padding: 0;
        font-family: 'Noto Sans KR', sans-serif;
    }

    header {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        background-color: white; /* 배경색을 추가하여 가려지지 않게 함 */
        z-index: 1000; /* 다른 요소보다 위에 위치하도록 */
        border-bottom: 1px solid #ccc; /* 헤더 아래쪽 경계선 */
    }

    footer {
    	margin-top: 50px;	   
	}

    .main_container {
        margin-top: 120px; /* 헤더 높이에 맞게 마진 설정 */
        
        margin-left: 100px;
        margin-right: 100px;
        padding: 20px; /* 콘텐츠 여백 */
        text-align: center; /* 가운데 정렬 */
    }
    
    hr {
	    width: 400px; /* 원하는 너비 */
	    margin: 0 auto; /* 자동 마진으로 가운데 정렬 */
	}

    .signup_section {
	    display: flex;          
	    justify-content: center; /* 자식 요소를 가운데 정렬 */
	    width: 100%;           /* 전체 너비 사용 */   
    }
	
	.signup_step {
	    display: flex;          
	    align-items: center;   
	    height: 100px;    
	    
	}
	
	.step1, .step2, .step3 {
	    width: 270px;          
	    height: 35px;         
	    background-color: #00664F; /* step1의 배경색 */
	    color: white;
	    text-align: center;    
	    line-height: 35px;     
	    border: 1px solid #00664F;
	    margin: 0; /* 마진 제거 */
	}
	
	.step1, .step3 {
	    background-color: #FFFFFF;
	    color: #BCBCBC;
	    border: 1px solid #BCBCBC;
	}
	
	.join_write {
	    display: flex;               /* Flexbox 사용 */
	    flex-direction: column;      /* 세로 방향으로 정렬 */
	    align-items: center;         /* 자식 요소를 가운데 정렬 */
	    text-align: left;            /* 테이블 셀 안의 텍스트는 왼쪽 정렬 */
	    max-width: 600px;
	    margin: 20px auto;
	    padding: 20px;
	    border: 1px solid #ddd;
	    border-radius: 8px;
	    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	    background-color: #f9f9f9;
	}
	
	.text_guide {
	    font-size: 14px;
	    color: #555;
	    margin-bottom: 20px;
	    text-align: left;
	}
	
	table {
	    width: 100%;
	    border-collapse: collapse;
	}
	
	td {
	    padding: 10px;
	    vertical-align: middle;
	}
	
	td:first-child {
	    width: 30%;
	    font-weight: bold;
	    color: #333;
	}
	
	select, input[type="text"], input[type="password"], input[type="date"], input[type="file"] {
	    width: calc(100% - 20px);
	    padding: 10px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    font-size: 14px;
	    transition: border-color 0.3s;
	}
	
	select:focus, input[type="text"]:focus, input[type="password"]:focus, input[type="date"]:focus {
	    border-color: #007bff;
	    outline: none;
	}
	
	input[type="button"] {
	    padding: 10px 15px;
	    border: none;
	    border-radius: 4px;
	    background-color: #007bff;
	    color: white;
	    cursor: pointer;
	    transition: background-color 0.3s;
	}
	
	input[type="button"]:hover {
	    background-color: #0056b3;
	}
	
	input[type="button"]:focus {
	    outline: none;
	}
	
	@media (max-width: 600px) {
	    td {
	        display: block;
	        width: 100%;
	        margin-bottom: 10px;
	    }
	
	    td:first-child {
	        margin-bottom: 5px;
	    }
	}
	
	/* 메시지 ID 스타일 */
	.message {
	    color: red; /* 텍스트 색상 */
	    font-size: 12px; /* 폰트 크기 */
	    margin-top: 5px; /* 입력 필드와의 간격 */
	    height: 18px; /* 높이를 설정하여 줄 바꿈 방지 */
	}
	
	

	/* 각 tr 사이에 여백 추가 */
	table tr {
    	margin-bottom: 15px; /* tr 사이에 아래쪽 여백 추가 */
	}

	#checkIdMsg, #checkPwMsg1, #checkPwMsg2 {
		color: red; /* 텍스트 색상 */
	    font-size: 12px; /* 폰트 크기 */
	    margin-top: 5px; /* 입력 필드와의 간격 */
	    height: 18px; /* 높이를 설정하여 줄 바꿈 방지 */
	}
     
    #btnNext {
		width: 250px;
        height: 36px;
        padding: 5px 10px 5px 10px;
        background-color: #00664F;
        color: white;
        border: 1px solid #00664F;
	}
	
	#btnCheck {
		width: 80px;
        height: 36px;
        padding: 5px 10px 5px 10px;
        background-color: #00664F;
        color: white;
        border: 1px solid #00664F;
	}
	
	#btnAddress {
		width: 80px;
        height: 36px;
        padding: 5px 10px 5px 10px;
        background-color: #00664F;
        color: white;
        border: 1px solid #00664F;
	}
	
	.btnSection {
    margin-bottom: 10px; /* 아래쪽 마진을 줄입니다 */
    margin-top: 20px; /* 위쪽 마진을 추가하여 공간을 조절합니다 */
}
 
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    let isIdConfirmed = false; // 아이디 중복 확인 여부

    // 아이디 중복 체크
    function confirmId() {
        var userId = $("#user_id").val();

        // 아이디 유효성 검사
        var regex = /^[a-zA-Z0-9]{4,12}$/;  // 4~12자의 영문 또는 숫자만 허용
        if (!regex.test(userId)) {
            alert("아이디는 4~12자의 영문 또는 숫자만 가능합니다.\n특수문자나 한글은 포함될 수 없습니다.");
            $("#user_id").val('');  // 아이디 입력 필드 초기화
            return;
        }

        $.ajax({
            url: '/view_Ljm/confirmId', // 경로 확인
            type: 'GET',
            dataType: 'json',
            data: { 'user_id': userId },
            success: function (data) {
                var checkIdMsg = $("#checkIdMsg");
                if (data === 1) {
                    // 중복된 아이디
                    checkIdMsg.text("이미 존재하는 아이디입니다").css("color", "red");
                    isIdConfirmed = false;
                } else {
                    // 사용 가능한 아이디
                    checkIdMsg.text("사용 가능한 아이디입니다").css("color", "green");
                    isIdConfirmed = true;
                }
            },
            error: function () {
                alert("아이디 중복 확인 중 오류가 발생했습니다.");
            }
        });
    }

    // 중복 확인 버튼 클릭 시 호출
    $("#btnCheck").click(function() {
        confirmId();
    });

    // 회원가입 버튼 클릭 시 중복 확인 여부 체크
    $("#btnNext").click(function(event) {
        if (!isIdConfirmed) {
            alert("아이디 중복 확인을 해주세요.");
            event.preventDefault();  // 폼 제출을 막음
        }
    });

    // 폼 제출 이벤트 처리 (다른 방법으로도 제출될 수 있으므로)
    $("#signupForm").submit(function(event) {
        if (!isIdConfirmed) {
            alert("아이디 중복 확인을 해주세요.");
            event.preventDefault();  // 폼 제출을 막음
        }
    });
});

//비밀번호 유효성 검사 및 일치 여부 확인
function confirmPw() {
    var pw1 = $('#pw1').val();
    var pw2 = $('#pw2').val();

    // 비밀번호 유효성 검사 (4~12자의 영문 또는 숫자만 허용)
     var regex = /^[a-zA-Z0-9!@#$%^&*()_+={}\[\]:;"'<>,.?\/\\|-]{4,12}$/;
    
    // 비밀번호 유효성 메시지
    if (!regex.test(pw1)) {
        $('#checkPwMsg1').text('비밀번호는 4~12자의 영문 또는 숫자만 가능합니다.').css('color', 'red');
    } else {
        $('#checkPwMsg1').text('사용 가능한 비밀번호 형식입니다.').css('color', 'green');
    }

    // 비밀번호 확인 일치 여부 확인
    if (pw1 && pw2) {
        if (pw1 === pw2) {
            $('#checkPwMsg2').text('비밀번호 일치').css('color', 'green');
        } else {
            $('#checkPwMsg2').text('비밀번호 불일치').css('color', 'red');
        }
    }
}

// 주소 찾기 API
function findAddr() {	
	var postcode = new daum.Postcode({
		oncomplete: function (data) {
			var roadAddr = data.roadAddress;
			var jibunAddr = data.jibunAddress;
			if (roadAddr !== '') {
				document.getElementById("addr1").value = roadAddr;
			} else if (jibunAddr !== '') {
				document.getElementById("addr2").value = jibunAddr;
			}
			// 상세 주소에 자동 포커스
			document.getElementById("addr2").focus();
		},
		onclose: function () {
			// 팝업이 닫힐 때 수행할 동작
			console.log("주소 팝업이 닫혔습니다.");
		}
	});

	// 팝업 열기
	postcode.open();
}


</script>
</head>
<body>
        <header>
        	<%@ include file="../header.jsp" %>
        </header>
        
        <main>
          <form action="signup" method="POST" id="signupForm" enctype="multipart/form-data">
	        <div class="main_container">
			<h2 style="color: #00664F ">회원가입</h2>
			<hr style="width: 400px; margin: 0 auto;">
			<br>
			<p>
	           <div class="signup_section">
	            	<div class="signup_step">
	            		<div class="step1">이용약관</div>
	            		<div class="step2">정보입력</div>
	            		<div class="step3">가입완료</div>
	           		</div>			
	           </div>	
           
           
	            <div class="join_write">
	           		<div class="text_guide">* 필수항목이므로 꼭 작성해주세요</div>
	           		<table class="">
	           			<tr>
	           				<td>회원유형 *<div class="message"></div></td>
	           				<td><select name="user_status" class="select" required="required" style="width: 300px;">
		  							<option disabled selected>회원 유형을 선택하세요</option>
		  							<option value="1001">학생</option>
		  							<option value="1002">강사</option>
								</select>
								<div class="message"></div>
							</td>
	           			</tr>
	           			
	           			<tr>
	           				<td>이름 *<div class="message"></div></td>
	           				<td>
	           					<input name="user_name" id="user_name" type="text" required="required">
	           					<div class="message"></div>
	           				</td>	           				
	           			</tr>
	           			
	           			
	           			<tr>
	           				<td>아이디 *<div class="message"></div></td>
	           				<td>
	           					<input name="user_id" id="user_id" type="text" placeholder="4~12자의 영문 또는 숫자 입력" required="required">
	           					<div id="checkIdMsg"></div>
	           				</td>
	           				<td>
	           					<input id="btnCheck" type="button" value="중복확인" onclick="confirmId()">
	           					<div class="message"></div>
	           				</td>
	           				
	           			</tr>
	           			
	           			<tr>
	           				<td>비밀번호 *</td>
	           				<td>
	           					<input name="password" id="pw1" type="password" oninput="confirmPw()" placeholder="4~12자의 영문 또는 숫자 입력" required="required">
	           					<div id="checkPwMsg1"></div>	  	           				
	           				</td>
	           			</tr>
	           			
	           			<tr>
	           				<td>비밀번호 확인 *<div class="message"></div></td>
	           				<td>
	           					<input type="password" id="pw2" oninput="confirmPw()" required="required">
	           					<div id="checkPwMsg2"></div>
	           				</td>
	           			</tr>
	           			
	           			<tr>
	           				<td>생년월일 *<div class="message"></div></td>
	           				<td>
	           					<input name="birth" type="date" placeholder="0000-00-00 형식으로 입력" required="required">
	           					<div class="message"></div>
	           				</td>
	           			</tr>
	           			
	           			<tr>
	           				<td>주소 *<div class="message"></div><div class="message"></div></td>
	           				<td>
	           					<input name="address" type="text" id="addr1" placeholder="주소" required="required" style="margin-bottom: 10px;" readonly="readonly">
	           					<input name="addr_detail" type="text" id="addr2" placeholder="상세주소">	           					
	           				</td>
	           				<td>
	           					<input id="btnAddress" type="button" onclick="findAddr()" value="찾기">
	           					<div class="message"></div><div class="message"></div>
	           				</td>
	           			</tr>
	           			
	           			<tr>
	           				<td>메일 *<div class="message"></div></td>
	           				<td>
	           					<input name="email" type="text" required="required">
	           					<div class="message"></div>
	           				</td>
	           			</tr>
	           			
	           			<tr>
	           				<td>전화번호 *<div class="message"></div></td>
	           				<td>	           				
	           					<input name="phone_num" type="text" placeholder="000-0000-0000" required="required">
					           	<div class="message"></div>			
	           				</td>
	           			</tr>
	           			
	           			<tr>
	           				<td>프로필 사진</td>
	                        <td>
	                            <input type="file" id="profileImage" name="profileImage" accept="image/*" onchange="previewImage(event)">
	                        </td>
	                        <td>
	                            <img id="preview" src="#" alt="이미지를 선택해주세요" style="width: 100px; height: 100px; display:none;">
	                        </td>	  	           				
	           			</tr>
	           				           		           			
	           		</table>
	            </div>
           
	       </div>
	        	
	        	<div class="btnSection" align="center" style="margin-bottom: 20px;">
					<input id="btnNext" type="submit" value="회원가입">
	            </div>
	      </form>
		</main>
        <footer>
        </footer>
    </body>
    
    <footer>
        <%@ include file="../footer.jsp" %>
    </footer>
</html>