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
	    padding-bottom: 60px; /* 푸터 높이만큼 아래 여백 추가 */
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
        margin-bottom: 60px; /* 푸터 높이에 맞게 마진 설정 */
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
	
	.step2, .step3 {
	    background-color: #FFFFFF;
	    color: #BCBCBC;
	    border: 1px solid #BCBCBC;
	}

    input[type="text"], input[type="password"] {
    	width: 205px;
        height: 22px;
        padding: 5px 30px 5px 10px;
    }
     
     #btnNext {
		width: 250px;
        height: 36px;
        padding: 5px 10px 5px 10px;
        background-color: #00664F;
        color: white;
        border: 1px solid #00664F;
	}
	
	.join_box00 {
	    display: flex;          /* Flexbox 사용 */
	    justify-content: center; /* 자식 요소를 가운데 정렬 */
	    align-items: center;    /* 세로 방향으로도 가운데 정렬 (선택 사항) */
	    width: 100%;            /* 필요에 따라 전체 너비 사용 */
	}
	
	.join_box01 {
	    width: 800px;           /* 원하는 너비 설정 */
	    height: 200px;
	    overflow-y: auto;
	    border: 1px solid #BCBCBC;
	    padding: 10px;          /* 필요에 따라 마진 추가 */
	}
	
	.agree {
		margin-right: 420px;
	}
	
.agree input[type="checkbox"] {
    display: none; /* 기본 체크박스 숨김 */
}

.agree input[type="checkbox"] + label {
    position: relative;
    padding-left: 30px; /* 체크박스 공간 확보 */
    cursor: pointer;
}

/* 커스텀 체크박스 */
.agree label::before {
    content: '';
    position: absolute;
    left: 0;
    top: 0;
    width: 20px; /* 체크박스 너비 */
    height: 20px; /* 체크박스 높이 */
    border: 2px solid #00664F; /* 체크박스 테두리 색상 */
    background-color: white; /* 체크박스 배경색 */
}

/* 체크박스가 체크되었을 때 스타일 */
.agree input[type="checkbox"]:checked + label::before {
    background-color: #00664F; /* 체크된 상태 배경색 */
    border-color: #00664F; /* 체크된 상태 테두리 색상 */
}

/* 체크 표시 */
.agree input[type="checkbox"]:checked + label::after {
    content: '✔'; /* 체크 표시 문자 */
    position: absolute;
    left: 5px;
    top: -3px;
    color: white; /* 체크 표시 색상 */
    font-size: 18px; /* 체크 표시 크기 */
}
        
</style>

</head>
<body>
        <header>
        	<%@ include file="../header.jsp" %>
        </header>
        
        <main>
			
		  <form>
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
	            			
    			<div class="agree" style="margin-top: 20px; text-align: right;">
    				<input type="checkbox" id="agreeAll" onclick="toggleAgreeTerms()">
    				<label for="agreeAll">전체 동의</label>
				</div>
	        	<h4>회원가입 약관</h4>
				<div class="join_box00">
					<div class="join_box01" style="text-align: left;">
						제 1 조 (목적)<p>
						이 약관은 중삼대학교 HiVE센터가 운영하는 다음의 서비스 사이트에서(이하 “중삼대학교 HiVE센터”라 한다)에서 제공하는 각 종 콘텐츠 서비스(이하 “콘텐츠 서비스”라 한다)를 이용함에 있어 중삼대학교HiVE센터와 회원의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.
						
						제 2 조 (정의)<p>
						이 약관에서 사용하는 용어의 정의는 다음과 같습니다.<p>
						① "이용자"라함은 "중삼대학교 HiVE센터"에 접속하여 본 약관에 따라 중삼대학교 HiVE센터가 제공하는 콘텐츠 서비스 및 제반서비스를 이용하는 "회원" 및"비회원"을 말합니다.<p>
						② "회원” 이란 중삼대학교 HiVE센터에 접속하여 중삼대학교 HiVE센터 개인정보취급방침과 이 약관에 동의하고 중삼대학교 HiVE센터가 인정하는 절차에 따라 가입하여 회원 고유번호(ID)를 부여받은 자를 말합니다. "회원"은 중삼대학교 HiVE센터의 정보를 지속적으로 제공받으며, 중삼대학교 HiVE센터가 제공하는 모든 콘텐츠 서비스를 계속적으로 이용할 수 있습니다. 단, 특정 서비스는 제7조 2항에 따라 회원의 권리 중 일부를 제한할 수 있습니다.<p>
						③ "비회원"이란 회원에 가입하지 않고, 중삼대학교 HiVE센터가 제공하는 콘텐츠 서비스를 일시적으로 사용하거나 중삼대학교 HiVE센터가 제공하는 부가 서비스를 일시적으로 사용하는 이용자를 말합니다.<p>
						④ “콘텐츠 서비스”란 중삼대학교 HiVE센터가 제공하는 각 종 콘텐츠 및 콘텐츠 제반 서비스를 말합니다.<p>
						⑤ "부가 서비스"란 정규 콘텐츠 서비스 이외에 일시적으로 제공하는 서비스를 말합니다.<p>
						
						제 3 조 (약관 등의 명시와 설명 및 개정)<p>
						① 중삼대학교 HiVE센터는 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(회원의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호, 모사전송번호, 전자우편(E-mail)주소, 사업자 등록번호, 통신판매업신고번호, 개인정보관리책임자 등을 회원이 쉽게 알 수 있도록 원광보건대학 평생교육원의 초기 서비스화면(전면)에 게시합니다.<p>
						② 중삼대학교 HiVE센터는 회원이 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 회원가입탈퇴 콘텐츠 서비스 사용료 결제 후 취소 환불조건 등과 같은 중요한 내용을 회원이 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 회원의 확인을 구하여야 합니다.<p>
						③ 중삼대학교 HiVE센터는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제에 관한 법률, 전자상거래 기본법, 정보통신망 이용촉진 등에 관한 법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.<p>
						④ 중삼대학교 HiVE센터가 이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행 약관과 함께 원광보건대학 평생교육원의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 회원에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 원광보건대학 평생교육원은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 회원이 알기 쉽도록 표시합니다.<p>
						⑤ 중삼대학교 HiVE센터가 이 약관을 개정한 경우에, 개정 약관은 그 적용일자 이후에 체결되는 계약에만 적용되고, 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만, 이미 회원으로 가입한 자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항의 규정에 의해 개정한 약관의 공지기간 내에 원광보건대학 평생교육원에 송신하여 원광보건대학 평생교육원의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.<p>
						⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자보호지침 및 관계법령 또는 원광보건대학 평생교육원 서비스 이용안내, 상관례에 따릅니다.<p>
						
						제 4 조 (콘텐츠 서비스의 제공 및 변경)<p>
						① 중삼대학교 HiVE센터는 중삼대학교 HiVE센터가 제공하는 서비스에 대하여 다음과 같은 업무를 수행합니다.<p>
						1. 콘텐츠 서비스에 대한 정보 제공 및 사용료 지불의 체결.<p>
						2. 사용료 지불이 체결된 콘텐츠 서비스의 이행.<p>
						3. 회원의 원활한 콘텐츠 이용을 지원하기 위한 다음과 같은 서비스의 이행.<p>
						- 원격 제어 지원 서비스<p>
						- Q&A, 상담게시판, 운영자에게, 1:1상담 게시판 등의 운영<p>
						- 그 외 회원 지원을 위한 각종 서비스<p>
						4. 기타 원광보건대학 평생교육원이 정하는 업무.	<p>			
						② 원광보건대학 평생교육원은 법령 및 제도의 변경, 콘텐츠 서비스의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 콘텐츠 서비스의 내용을 변경할 수 있습니다. 이 경우에는 변경된 콘텐츠 서비스의 내용 및 제공일자를 명시하여 현재의 콘텐츠 서비스의 내용을 게시한 곳에 즉시 공지합니다.<p>
						③ 원광보건대학 평생교육원의 콘텐츠 서비스를 제공받기로한 회원이 콘텐츠 서비스 등의 품절 또는 기술적 사양의 변경 등의 사유로 콘텐츠 서비스를 변경할 경우에는 그 사유를 회원에게 통지 가능한 주소로 즉시 통지합니다.<p>
						④ 원광보건대학 평생교육원이 콘텐츠 서비스를 제공받기로한 회원에게 콘텐츠 서비스의 품절 또는 기술적 사양의 변경 등의 사유로 변경 또는 제공하지 못할 경우에는 원광보건대학 평생교육원은 이로 인하여 회원이 입은 손해를 배상하지 않습니다. 다만, 원광보건대학 평생교육원에 고의 또는 과실이 있는 경우에는 그러하지 아니합니다.
						
						제 5 조 (콘텐츠 서비스의 중단)
						① 원광보건대학 평생교육원은 컴퓨터 등 정보통신설비의 보수점검 교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 콘텐츠 서비스를 일시적으로 중단할 수 있습니다.
						② 원광보건대학 평생교육원은 제1항의 사유로 콘텐츠 서비스가 일시적으로 중단됨으로 인하여 회원 또는 제3자가 입은 손해에 대하여 배상하지 않습니다. 다만, 원광보건대학 평생교육원에 고의 또는 과실이 있는 경우에는 그러하지 아니합니다.
						③ 사업종목의 전환, 사업의 포기, 업체간의 통합 등의 이유로 콘텐츠 서비스를 제공할 수 없게 되는 경우에는 원광보건대학 평생교육원은 제8조에 정한 방법으로 회원에게 통지하고, 당초 원광보건대학 평생교육원에서 제시한 조건에 따라 회원에게 보상합니다. 다만, 원광보건대학 평생교육원이 보상기준 등을 고지하지 아니한 경우에는 회원들의 마일리지 또는 적립금 등을 원광보건대학 평생교육원에서 통용되는 통화가치에 상응하는 현물 또는 현금으로 회원에게 지급합니다.
						
						제 6 조 (회원가입)
						① 회원은 원광보건대학 평생교육원이 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로써 회원가입을 신청하며, 원광보건대학 평생교육원이 정한 실명 확인 절차를 거쳐 회원가입을 승낙하는 것을 원칙으로 합니다.
						② 원광보건대학 평생교육원은 제1항과 같이 회원으로 가입할 것을 신청한 회원 중 다음 각호의1에 해당하지 않는 한 회원으로 등록합니다.
						1. 가입신청자가 이 약관 제7조 제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우.
						다만, 제7조 제3항에 의한 회원자격 상실 후 원광보건대학 평생교육원의 회원 재가입 승낙을 얻은 경우에는 예외로 함.
						2. 등록 내용에 허위, 기재누락, 오기가 있는 경우.
						3. 기타 회원으로 등록하는 것이 원광보건대학 평생교육원의 기술상 현저히 지장이 있다고 판단되는 경우.
						
						③ 회원가입계약의 성립 시기는 원광보건대학 평생교육원의 승낙이 회원에게 도달한 시점으로 합니다.
						④ 회원은 등록사항에 변경이 있는 경우 즉시, 원광보건대학 평생교육원에 접속하여 회원정보를 수정하거나 전자우편(E-mail)주소, 기타 방법으로 원광보건대학 평생교육원에 그 변경사항을 알려야 합니다.										
						부칙
						이 약관은 2024년 01월 01일부터 개정 시행합니다.
					</div>					
				</div>
				<div class="agree" style="margin-top: 20px; text-align: right;">
        			<input type="checkbox" id="agreeTerms1">
        			<label for="agreeTerms1">회원가입 약관에 동의합니다.</label>
    			</div>
				
				<br>
				<h4>개인정보수집 및 이용안내</h4>
				<div class="join_box00">
					
					<div class="join_box01" style="text-align: left;">
						개인정보의 수집 및 이용 목적<p>
						- 서비스 이용에 따른 본인 식별, 실명 확인, 가입의사 확인, 연령제한 서비스 제공 및 만 14세 미만 아동 및 청소년회원의 법정대리인 동의 여부 확인<p>
						- 공지사항 전달, 민원처리 의사소통 경로 확보<p>
						- 사용료 결제시 정확한 결제자의 정보 확보<p>
						- 신규 서비스 등 최신정보 안내 및 개인맞춤 서비스 제공<p>
						- 불량회원 부정한 콘텐츠 사용 방지<p>
						- 중삼대학교 HiVE센터 서비스 이용 통계 정보관리<p>
						- 중삼대학교 HiVE센터가 판매하는 각종 콘텐츠 및 관련 서비스 홍보<p>
						
						개인정보의 수집 및 이용 목적<p>
						- 희망ID, 비밀번호, 이름, 주민등록번호, 주소, 전화번호, 휴대폰번호 , 전자우편(E-mail)주소, 결제계좌, 배송지 정보, 그 외 선택항<p>
						※ 14세 미만 아동 및 청소년회원인 경우 추가 항목 : 법정대리인의 동의서와 신분증 사본(본인확인용)<p>
						
						개인정보 보유 및 이용기간<p>
						- 회원이 콘텐츠 서비스를 이용하는 기간 동안만 회원정보를 보유하고 있으며, 콘텐츠 서비스 제공 및 민원사항 처리 등을 위하여 회원 정보를 이용합니다.<p>
						- 회원정보 중 이름, 생년월일, 성별, 로그인ID, 비밀번호, 전화번호, 주소, 휴대전화번호, 이메일, 법정대리인정보, 주민등록번호, 서비스이용기록, 접속로그, 쿠키, 접속IP정보, 결제기록, 인지경로, 관심분야의 항목을 보존합니다.<p>
						- 개인정보 수집 및 이용 목적이 달성된 후에는 해당 정보를 지체 없이 파기하는 것을 원칙으로 합니다.<p>
						- 단, “전자상거래 등에서의 소비자 보호에 관한 법률” 등 관련 법령의 규정에 의하여 보존할 필요가 있는 경우 관계 법령에서 정한 일정 기간 동안 회원정보 를 보관합니다.<p>
						
						- 탈퇴회원과 이용약관 제9조에 의한 회원자격상실의 경우, 해당 회원의 개인정보를 지체 없이 파기합니다.<p>
						다만, 아래의 경우에는 예외로 파며 처리를 유보되거나 처리가 지연될 수 있습니다.<p>
						1) 관련법령에서 규정하는 보존기간이 있는 경우 보존기간이 준수한 이후 파기합니다.<p>
						2) 사용 중인 콘텐츠가 있는 경우 사용기간이 종료된 후 파기합니다.<p>
					</div>	
									
				</div>
				<div class="agree" style="margin-top: 20px; text-align: right;">
        			<input type="checkbox" id="agreeTerms2">
        			<label for="agreeTerms2">개인정보수집 및 이용안내에 동의합니다.</label>
    			</div>

            
	        	</div>	        		        	
	        	
	        	<div class="btnSection" align="center" style="margin-bottom: 20px;">
					<input id="btnNext" type="button" value="다음">
	            </div>
	      </form>
		</main>
        <footer>
        </footer>
    </body>
    
    <footer>
        <%@ include file="../footer.jsp" %>
    </footer>
    
<script type="text/javascript">
	// 약관 모두 동의 시 다음 페이지 이동
	document.getElementById('btnNext').addEventListener('click', function() {
	    const isAgreed1 = document.getElementById('agreeTerms1').checked;
	    const isAgreed2 = document.getElementById('agreeTerms2').checked;
	
	    if (!isAgreed1 || !isAgreed2) {
	        alert('약관에 동의해야 다음으로 진행할 수 있습니다.');
	    } else {
	        location.href = 'signup2'; // 다음 페이지로 이동
	    }
	});
	
	// 전체 동의
	function toggleAgreeTerms() {
        // 전체 동의 체크박스를 확인
        var agreeAll = document.getElementById('agreeAll');
        
        // "전체 동의"가 체크되면 다른 두 체크박스를 모두 체크
        document.getElementById('agreeTerms1').checked = agreeAll.checked;
        document.getElementById('agreeTerms2').checked = agreeAll.checked;
    }
</script>
</html>