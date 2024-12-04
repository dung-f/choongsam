<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>강의영상</title>
    
</head>
<style>
body {
	display: flex;
	justify-content: flex-start;
	padding: 20px;
	box-sizing: border-box; /* box-sizing 설정 */
}
.container-left, .container-right {
	padding: 10px;
	box-sizing: border-box; /* padding이 포함된 너비 계산 */
}
.bookmark {
	padding-top: 100px;
	padding-left: 50px;
}
.suganging {
	padding-top: 100px;
	padding-left: 50px;
	font-size: 20px;
}
.exit-container {
	margin-top: 200px;
	margin-bottom: 50px;
	text-align: right;
}
.container-right {
    margin-left: 20px;
    width: 400px;
    height: 800px;
    border: 2px solid #ccc;
    border-radius: 10px;
    padding: 20px;
    background-color: #f9f9ff; /* 좀 더 부드러운 배경색 */
    display: flex;
    flex-direction: column;
    align-items: flex-start; /* 요소를 왼쪽 정렬 */
    gap: 20px; /* 요소 사이 간격 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
}
/* suganging (수강진행상황) 섹션 */
.suganging {
    font-size: 20px;
    font-weight: bold;
    color: #555;
}
/* 출석 인정 버튼 스타일 */
#markAttendance {
    margin-top: 10px;
    padding: 10px 20px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
}
#markAttendance:hover {
    background-color: #45a049;
}
/* exit-container 섹션 */
.exit-container {
    margin-top: auto; /* 나가기 버튼을 맨 아래로 이동 */
    margin-left: auto;
    text-align: right;
}
.exit-container button {
    background: none;
    border: none;
    cursor: pointer;
    outline: none;
}
.exit-container img {
    width: 40px;
    height: auto;
    transition: transform 0.2s ease;
}
.exit-container img:hover {
    transform: scale(1.1); /* 확대 효과 */
}
/* 강의자료 다운로드 링크 스타일 */
.container-right a {
    display: inline-block;
    padding: 12px 20px;
    margin-bottom: 20px; /* 위아래 요소와 간격 조정 */
    font-size: 16px;
    font-weight: bold;
    color: white;
    background-color: #4A90E2; /* 파란색 배경 */
    text-align: center;
    text-decoration: none;
    border-radius: 5px;
    transition: background-color 0.3s ease, transform 0.2s ease;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 가벼운 그림자 */
}
.container-right a:hover {
	background-color: #357ABD; /* 호버 시 어두운 파란색 */
    transform: scale(1.05); /* 약간 확대 효과 */
}
.bookmark a {
    display: block;
    margin: 5px 0;
    color: black !important;
    text-decoration: underline;
    background-color: transparent;
}
</style>

<body>
<div class="container-left">
   <div class="youtube" id="player"></div>
</div>

<div class="container-right">
	<a href="/api/files/ms/${conts_id}">강의자료 다운</a>
   
   <!-- 북마크 기능 -->
   <div class="bookmark" style="font-size: 20px;">
    <label style="font-weight: 700; font-size: 24px;"><강의 시간 북마크></label><p>
    <div id="bookmarkLinks"></div>
   </div>
   
   <!-- 수강진행상황 -->
   <div class="suganging">
    <label>학습시간</label>
    <span id="conts_max">분</span>/<span id="vdo_length">분</span>
    <button id="markAttendance">출석인정</button><p>
   		<div id="status"></div>
   	</div>
   	
   	<!-- 나가기 -->
   	<div class="exit-container">
   		<form id="exitForm" action="/api/progress/save" method="POST">
   			<input type="hidden" name="videoId" value="">
   			<input type="hidden" name="userId" value="">
   			<input type="hidden" name="conts_final" value="">
   			<input type="hidden" name="conts_max" value="">
   			<input type="hidden" name="vdo_length" value="">
   			<input type="hidden" name="user_seq" value="${user_seq}">
   			<input type="hidden" name="lctr_no" value="${lctr_no}">
            강의실 나가기
            <button type="button" id="exitButton">
                <img src="../image/나가기.png" style="width: 50px; height: auto;">
            </button>
   	</form>
   </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
    let player;
    let vdo_length = 0; 		  //영상길이
    let conts_max = 0; 	          //최대시청시간
    let conts_final = 0; 		  //마지막시청시간
    let originalTime; 			  //조작한 시간(플레이어 일시정지, 조작 시 원래대로 돌리는 데 사용)
    let isPaused = false;		  //일시정지 여부
    let videoId = "${videoId}";   //유튜브 영상 url
    let conts_id = "${conts_id}"; //강의영상번호
    let bookmarks =[];
 	let user_seq = "${user_seq}";
 	let lctr_no ="${lctr_no}";
 	let updateInterval; // setInterval의 참조를 저장할 변수
 	
 	
 	
 	
    // youtube IFrame API 호출함수
    function onYouTubeIframeAPIReady() {
    	
        player = new YT.Player('player', {
            videoId: videoId,
            height: '778',
            width: '1377',
            playerVars: {
                rel: 0,
                modestbranding: 1
            },
            events: {
                'onReady': onPlayerReady,
                'onStateChange': onPlayerStateChange
            }
        });
    }
    
    //페이지 로드 ajax 
    window.onload = function(){
    	console.log("user_seq ->"+ user_seq);
    	fetch(`/api/lectures/init?conts_id=${conts_id}`)
    	.then(response => response.json())
    	.then(data => {
    		console.log("Response from server:", data);
    	})
    	.catch(error => {
    		console.log("Error:", error);
    	});
    }
    

    
 	// 데이터베이스에서 북마크 정보를 불러오는 ajax
    function fetchBookmarks(conts_id) {
 		var conts_id = conts_id;
 		console.log('conts_id');
	    $.ajax({
	        url: `/api/bookmarks/${conts_id}`,
	        type: 'GET',
	        dataType: 'json',
	        success: function(bookmarks) {
	            console.log("북마크 데이터 로드:", bookmarks);
	            displayBookmarks(bookmarks); // 화면에 북마크 표시
	        },
	        error: function(error) {
	            console.error('북마크 로딩 오류:', error);
	        }
	    });
	} 
    document.addEventListener('DOMContentLoaded', function() {
        // displayBookmarks 함수 호출
        displayBookmarks(bookmarks);
    });
    
 	
    //북마크 데이터를 화면에 표시
    function displayBookmarks(bookmarks) {
	    const bookmarkContainer = document.querySelector('.bookmark');
	    // 기존 내용 초기화
	    while (bookmarkContainer.firstChild) {
	        bookmarkContainer.removeChild(bookmarkContainer.firstChild);
	    }	    
	    // 북마크 데이터가 없을 경우
	    if (bookmarks.length === 0) {
	        const noBookmarksMessage = document.createElement('p');
	        noBookmarksMessage.innerText = "북마크가 없습니다.";
	        bookmarkContainer.appendChild(noBookmarksMessage);
	    }	
	    // 북마크 데이터 배열을 순회하며 링크를 생성
	    bookmarks.forEach((bookmark, index) => {
	        const bookmarkLink = document.createElement('a');
	        bookmarkLink.href = "#";        
	        const conts_chptime = Number(bookmark.conts_chptime);  // 숫자 변환
	        const conts_chpttl = Number(bookmark.conts_chpttl);    // 숫자 변환
	        const timeText = "북마크" + (index + 1)+ " - " + Math.floor(bookmark.conts_chptime) + "초" + ":" + (bookmark.conts_chpttl);	        
	        
	        console.log(timeText);  // 콘솔에 출력하여 확인
	        console.log(bookmark.conts_chptime);//둘다 나옴	        
	       
	        bookmarkLink.innerText = timeText;
	        bookmarkLink.style.display = "block";
	        bookmarkLink.style.margin = "5px 0";
	        bookmarkLink.style.color = "blue";
	        bookmarkLink.style.textDecoration = "underline";
	        // 북마크 클릭 시 시청한 시간에 따라 동작
	        bookmarkLink.addEventListener('click', () => {
	            if (conts_max >= conts_chptime) {
	                player.seekTo(conts_chptime, true); // 시청 완료된 지점일 경우 해당 시간으로 이동
	            } else {
	                alert("해당지점으로 이동하기 위해서는 먼저 시청해야 합니다."); // 시청하지 않은 지점일 경우 경고
	            }
	        });
	        bookmarkLink.addEventListener('click', () => {
	            player.seekTo(bookmark.conts_chptime, true);
	        });
	        bookmarkContainer.appendChild(bookmarkLink);
	    });
	}
   
 	// YouTube 플레이어가 준비된 후 북마크 데이터를 불러오도록 호출
    function onPlayerReady(event) {
        vdo_length = player.getDuration();
        document.getElementById('vdo_length').innerText = Math.floor(vdo_length / 60) + "분";

        loadFinalTime(videoId); // 마지막 시청 위치 불러오기
        fetchBookmarks(conts_id); // 데이터베이스에서 북마크 불러오기
        event.target.playVideo(); // 영상 재생
        checkPlayerTime(); // 재생 시간 체크
    }

    //마지막위치에서 재생
    function loadFinalTime(videoId, user_seq, lctr_no) {
    console.log('Loading final time for videoId:', videoId); // videoId가 올바른지 로그로 확인
    if (!videoId) {
        console.error("videoId is missing!"); // videoId가 없을 경우 에러 로그
        return; // videoId가 없으면 함수를 종료
    } 

    fetch(`/api/progress/${videoId}?user_seq=${user_seq}&lctr_no=${lctr_no}`) // videoId가 올바르게 삽입되었는지 확인
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            console.log(data); // 반환되는 데이터 출력
            const savedTime = data.conts_final;
            if (savedTime && savedTime > 0) {
                player.seekTo(savedTime, true);
                conts_final = savedTime; // 불러온 시간으로 conts_final 업데이트
            }
        })
        .catch(error => console.error("시청 시간을 불러오지 못했습니다:", error));
	}
    
   //재생시간 체크(현재 재생시간을 10ms마다 업뎃해서 conts_final과 watchedTime을 저장)
   function checkPlayerTime() {
    if (!isPaused) {
        conts_final = player.getCurrentTime(); // 현재 재생 위치 저장
        if (conts_final > conts_max) {
            conts_max = conts_final; // 최대 시청 시간 저장
            document.getElementById('conts_max').innerText = Math.floor(conts_max / 60) + "분";
        	}
        // 3초마다 시청 시간을 데이터베이스에 저장
        saveWatchTimeToDatabase();
    	}
}
  	
 	 //3초마다 save 불러서 저장
	function saveWatchTimeToDatabase() {
	    // 데이터베이스에 저장할 데이터 준비
	    const data = {
	        videoId: videoId,
	        user_seq: user_seq,
	        lctr_no: lctr_no,
	        conts_final: Math.floor(conts_final),
	        conts_max: Math.floor(conts_max),
	        vdo_length: Math.floor(vdo_length)
	    };
	
	    // AJAX 요청을 통해 데이터를 서버에 전달하여 저장
	    $.ajax({
	        url: '/api/progress/save', // 저장할 API 엔드포인트
	        type: 'POST',
	        data: data, // JSON이 아닌 URL-encoded 데이터로 전달
	        success: function(response) {
	            console.log('시청시간이 저장되었습니다.');
	        },
	        error: function(error) {
	            console.error('시청시간 저장 오류:', error);
	        }
	    });
	}


	// 슬라이더 움직임체크
    function checkSliderMovement() {
        const currentTime = player.getCurrentTime();
        // 슬라이더 조작을 감지하고, 제한 범위를 벗어나면 원래 위치로 되돌림.
        if (!isPaused && Math.abs(currentTime - conts_final) > 0.5 && currentTime > conts_max) {
            originalTime = conts_final;
            const validatePosition = setTimeout(() => {
                if(player.getCurrentTime() > conts_max){
                    // 최대 시청 시간 이상 조작 시 원래 위치로
                    player.seekTo(originalTime, true); 
                }else{
                    clearInterval(validatePosition);
                }
            }, 200);
        }
    }

  	
	 // 플레이어 상태변화 감지
    function onPlayerStateChange(event) {
    isPaused = event.data === YT.PlayerState.PAUSED;
    if (event.data === YT.PlayerState.ENDED) { // 영상이 끝났을 때 실시간 시간 업데이트 멈추기       
        clearInterval(updateInterval);
        console.log('영상이 종료되었습니다.');
    } else if (!isPaused) { // 영상이 재생 중이라면 타이머 시작
        checkSliderMovement();        
        if (!updateInterval) {
            updateInterval = setInterval(checkPlayerTime, 3000); // 3초마다 업데이트
        }
    }
}


    // 출석인정 기능 
    document.getElementById('markAttendance').addEventListener('click', () => {
        if (Math.abs(conts_max - vdo_length) <= 5) {
            document.getElementById('status').innerText = "출석이 인정되었습니다!";
        } else {
            document.getElementById('status').innerText = "출석이 인정되지 않았습니다. 영상 시청을 완료해주세요.";
        }
    });

    
    //유튜브 api 자료 가져오기 함수
    $(document).ready(function(){
        $.ajax({
            url: "/api/youtube/config",
            type: "GET",
            success: function(config) {
            	const apiKey = config.apiKey;  // Spring Boot에서 제공한 API Key
            	const baseUrl = config.baseUrl;  // Spring Boot에서 제공한 Base URL

            	// 2. YouTube API 요청
            	$.ajax({
            		url: `${baseUrl}videos`,
            		type: "GET",
		            data: {
		                part: 'snippet,contentDetails,statistics',
		                id: videoId,
		                key: apiKey
            		},
            		success: function(data) {
                    	console.log(data);
                        if (data.items && data.items.length > 0) {
                            const item = data.items[0];
                            const title = item.snippet.title;
                            const description = item.snippet.description;
                            const thumbnailUrl = item.snippet.thumbnails.high.url;
                            const channelId = item.snippet.channelId;

                         	// YouTube 영상 정보를 출력
                            const output = `
                                <h3>${title}</h3>
                                <p>${description}</p>
                                <img src="${thumbnailUrl}" alt="${title}">
                                <p>채널 ID: ${channelId}</p>
                            `;
                            $("#player").append(output);
                        } else {
                            console.error("해당 비디오 정보를 찾을 수 없습니다.");
                        }
                    },
                    error: function(error) {
                        console.error("YouTube API 요청 오류:", error);
                    }
                });
            },
            error: function(error) {
            	console.error("YouTube API 설정 정보 가져오기 오류:", error);
            }
        });
    });
      
    document.getElementById('exitButton').addEventListener('click', () => {
        // 폼의 hidden input 필드에 데이터 설정
        document.querySelector('input[name="conts_final"]').value = Math.floor(conts_final);
        document.querySelector('input[name="conts_max"]').value = Math.floor(conts_max);
        document.querySelector('input[name="vdo_length"]').value = Math.floor(vdo_length);
        document.querySelector('input[name="videoId"]').value = videoId;
        console.log('conts_final:', conts_final);
        
        // 폼 제출
        document.getElementById('exitForm').submit();
    });
</script>
<script src="https://www.youtube.com/iframe_api"></script>
</body>
</html>
