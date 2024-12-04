<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>

<%@ include file="../headerGreen.jsp" %>
<%@ include file="../myStudyHomeNav.jsp" %>
<link rel="stylesheet" href="../css/shContsUploadForm.css">


    <meta charset="UTF-8">
    <title>Insert title here</title>
    
    
    <script src="https://www.youtube.com/iframe_api"></script>
    <script type="text/javascript">

        

        let chapterIndex = 1; // 초기 인덱스 설정 (0은 기본 챕터)
        let player; // 전역 player 변수를 선언
        let isPlayerReady = false; // 플레이어 준비 상태를 추적하는 플래그
        let pendingVideoId = ''; // 로드할 비디오 ID를 저장하는 변수

        function videoChk() {
            var youtubeIdInput = document.querySelector('input[name="vdo_url_addr"]').value.trim();
            var youtubeIdMatch = youtubeIdInput.match(/([a-zA-Z0-9_-]{11})/);
            var youtubeId = youtubeIdMatch ? youtubeIdMatch[1] : '';

            var videoDiv = document.querySelector('.video');
            console.log('youtubeId >> ' + youtubeId);

            if (youtubeId) {
                if (!player) {
                    videoDiv.innerHTML = '<div id="player"></div>'; // player div를 추가
                    videoDiv.style.display = 'block'; // 비디오 div를 보이도록 설정

                    // 비디오가 준비되면 player를 생성합니다.
                    player = new YT.Player('player', {
                        height: '390',
                        width: '640',
                        videoId: youtubeId,
                        events: {
                            'onReady': onPlayerReady, // 플레이어가 준비되었을 때 호출되는 함수
                            'onStateChange': onPlayerStateChange // 플레이어 상태 변경 시 호출되는 함수
                        }
                    });
                } else {
                    pendingVideoId = youtubeId; // 비디오 ID를 대기 상태로 저장
                    if (isPlayerReady) {
                        player.loadVideoById(pendingVideoId); // 플레이어가 준비되면 비디오 ID 변경
                    }
                }
            } else {
                alert('유효한 유튜브 ID를 입력해주세요.');
                videoDiv.style.display = 'none'; // 유효하지 않으면 비디오 div 숨기기
            }
        }

        // 플레이어가 준비되었을 때 호출되는 함수
        function onPlayerReady(event) {
            isPlayerReady = true; // 플레이어 준비 상태를 true로 설정
            if (pendingVideoId) {
                player.loadVideoById(pendingVideoId); // 대기 중인 비디오 ID 로드
            }

            // 전체 재생 길이를 가져옵니다.
            updateVideoDuration(); // 플레이어가 준비되면 비디오 길이 업데이트
        }

        // 플레이어 상태가 변경될 때 호출되는 함수
        function onPlayerStateChange(event) {
            // 비디오가 로드될 때마다 재생 길이를 업데이트합니다.
            if (event.data === YT.PlayerState.PLAYING) {
                updateVideoDuration(); // 비디오가 재생될 때만 길이 업데이트
            }
        }

        // 비디오 길이를 업데이트하는 함수
        function updateVideoDuration() {
            const duration = player.getDuration()-1;
            const durationInSeconds = Math.trunc(duration); // 초 단위로 정수로 반내림
            console.log('vdo_length >> ' + durationInSeconds + ' 초'); // 수정된 로그 출력
            document.getElementById('vdo_length').value = durationInSeconds; // 비디오 길이를 정수로 폼 필드에 설정
        }
        
        //챕터시간 자동 형식 변환
        const hypenTime = (target) => {
        	 target.value = target.value
        	   .replace(/[^0-9]/g, '')
        	   .replace(/^(\d{2})(\d{2})(\d{2})$/, `$1:$2:$3`);
        	}
        
        //영상확인버튼 눌렀는지 확인하는 버튼
        function videoChk() {
		    const youtubeIdInput = document.querySelector('input[name="vdo_url_addr"]').value.trim();
		    const youtubeIdMatch = youtubeIdInput.match(/([a-zA-Z0-9_-]{11})/);
		    const youtubeId = youtubeIdMatch ? youtubeIdMatch[1] : '';
		
		    const videoDiv = document.querySelector('.video');
		    console.log('youtubeId >> ' + youtubeId);
		
		    if (youtubeId) {
		        if (!player) {
		            videoDiv.innerHTML = '<div id="player"></div>'; // player div를 추가
		            videoDiv.style.display = 'block'; // 비디오 div를 보이도록 설정
		
		            // 비디오가 준비되면 player를 생성합니다.
		            player = new YT.Player('player', {
		                height: '390',
		                width: '640',
		                videoId: youtubeId,
		                events: {
		                    'onReady': onPlayerReady,
		                    'onStateChange': onPlayerStateChange
		                }
		            });
		        } else {
		            pendingVideoId = youtubeId; // 비디오 ID를 대기 상태로 저장
		            if (isPlayerReady) {
		                player.loadVideoById(pendingVideoId); // 플레이어가 준비되면 비디오 ID 변경
		            }
		        }
		        
		        // 아래 코드 추가
		        document.getElementById('contsTest').value = "1"; // 유효한 ID일 때 contsTest 업데이트
		        alert('영상 확인되었습니다.'); // 이 부분은 비디오 확인 후 보여줍니다.
		    } else {
		        alert('유효한 유튜브 ID를 입력해주세요.');
		        videoDiv.style.display = 'none'; // 유효하지 않으면 비디오 div 숨기기
		    }
		}
        
     // 챕터 시간을 초로 변환하는 함수(컨트롤러에 값을 보내지는 않음)
        function getSecondsFromTimeString(timeString) {
            let totalSeconds = null;

            if (timeString) {
                const parts = timeString.split(":");
                if (parts.length === 3) {
                    const hours = parseInt(parts[0], 10);
                    const minutes = parseInt(parts[1], 10);
                    const seconds = parseInt(parts[2], 10);
                    totalSeconds = hours * 3600 + minutes * 60 + seconds;
                }
            }
            return totalSeconds;
        }
        
        function submitChk() {
            // Check if the hidden input contsTest has a value of 1
            const contsTestValue = document.getElementById('contsTest').value;
            if (contsTestValue !== "1") {
                alert('영상 확인 버튼을 눌러주세요');
                return false;
            }
            
         // 영상 전체 길이
            const videoLength = parseInt(document.getElementById('vdo_length').value, 10);

            // 챕터 시간 입력값 확인 및 비교
            const chapterInputs = document.querySelectorAll('input[name^="chp_str"]');
            for (const input of chapterInputs) {
                const chapterTimeString = input.value.trim();
                const chapterSeconds = getSecondsFromTimeString(chapterTimeString);

                if (chapterSeconds !== null && chapterSeconds > videoLength) {
                    alert('챕터 시간이 영상 전체 길이를 초과할 수 없습니다.');
                    return false;
                }
            }

            return true;
        }

    </script>
</head>
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

    <form action="contsUpdateForm" class="form" method="post" enctype="multipart/form-data" onsubmit="return submitChk()">
	    <c:forEach var="info" items="${info }">
	        <div id="inserts">
	            <div class="oneLine">
	               <div class="tb"> <label class="text">강의 제목 입력</label></div>
	                <input type="text" placeholder="강의 제목을 입력해주세요" name="vdo_file_nm" required="required" value="${info.vdo_file_nm }">
	            </div>
	
	            <div class="oneLine">
	                <div class="tb"><label class="text">차시</label></div>
	                <input type="text" name="lctr_no" value="${info.lctr_no }" readonly="readonly">
	                
	            </div>
	            
	            <!-- <div class="oneLine">
	                <div class="tb"><label class="text">강의개요</label></div>
	                <input type="text" name="lctr_otln" placeholder="강의개요를 입력해주세요">
	            </div> -->
	
	            <div class="twoLine">
				    <div class="tb"><label class="text">출석 인정 기간 설정</label></div>
				    	<input type="text" name="minDate" value="${info.befor_period}" readonly="readonly" class="tbViewing">~
				     	<input type="text" name="viewing_period" value="${info.viewing_period}" readonly="readonly" class="tbViewing">
				</div>
	
	            <div class="twoLine">
				    <div class="tb"><label class="text">유튜브 ID</label></div>
				    <input type="text" name="vdo_url_addr" id="vdo_url_addr" value="${info.vdo_url_addr}">
				    <input type="hidden" name="vdo_length" id="vdo_length" required="required">
				    <div>
				        <button type="button" id="idInput" onclick="videoChk()">영상 확인</button>
				        <input type="hidden" id="contsTest" value="0">
				    </div>
				</div>
	
	            <div class="video"></div>
	
	
		            <div id="chapter">
		                <div class="chapterTime">
		                    <div class="oneLine">
		                    	<div class="tb"><label class="text">챕터시간1 입력</label></div>
		                    	<input type="text" name="chp_str1" maxlength="6" oninput="hypenTime(this)" 
		                    		placeholder="00:00:00 형식으로 입력" class="tbViewing" value="${chpTime1 }">
		                    </div>
		                    <div class="oneLine">
		                    	<div class="tb"><label class="text">챕터내용1 입력</label></div>
		                    	<input type="text" name="conts_chpttl" value="${chpTtl1}">
		                    </div>
		                </div>
		                
		                <div class="chapterTime">
		                    <div class="oneLine">
		                    	<div class="tb"><label class="text">챕터시간2 입력</label></div>
		                    	<input type="text" name="chp_str2" maxlength="6" oninput="hypenTime(this)" 
		                    		placeholder="00:00:00 형식으로 입력" class="tbViewing" value="${chpTime2 }">
		                    </div>
		                    <div class="oneLine">
		                    	<div class="tb"><label class="text">챕터내용2 입력</label></div>
		                    	<input type="text" name="conts_chpttl2" value="${chpTtl2}">
		                    </div>
		                </div>
		                
		                <div class="chapterTime">
		                    <div class="oneLine">
		                    	<div class="tb"><label class="text">챕터시간3 입력</label></div>
		                    	<input type="text" name="chp_str3" maxlength="6" oninput="hypenTime(this)" 
		                    		placeholder="00:00:00 형식으로 입력" class="tbViewing"  value="${chpTime3 }">
		                    </div>
		                    <div class="oneLine">
		                    	<div class="tb"><label class="text">챕터내용3 입력</label></div>
		                    	<input type="text" name="conts_chpttl3" value="${chpTtl3}">
		                    </div>
		                </div>
		            </div>
	            
	            <div class="oneLine">
	            	<div class="file">
		                <div class="tb"><label class="text">첨부파일</label></div>
		                <div id="fileName">
		                	<label id="fileNameText">이전에 올린 첨부파일 명: ${info.file_nm }.${ info.file_extn_nm}</label>
		                </div>
		                <input type="file" name="file" id="fileButton">
		            </div>
	            </div>
	            
	            
	            <input type="hidden" name="lctr_id" value="${info.lctr_id}">
	    		<input type="hidden" name="user_seq" value="${info.user_seq}">
	    		<input type="hidden" name="conts_id" value="${info.conts_id}">
	            
	             <button type="submit" id="subBut">수업 등록</button>
	
	        
	    	</div>
	        </c:forEach>
    </form>
</div>

</body>
</html>
