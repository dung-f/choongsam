<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>강의영상</title>
</head>

<body>
<div class="container-left">
   <!-- YouTube Player -->
   <div class="youtube" id="player"></div>
</div>

<div class="container-right">
   <!-- 북마크 기능 -->
   <div class="bookmark">
    <a href="#" id="seekToStart">영상 시작</a><p>
    <a href="#" id="seekToHalf">점점 잠오는 시점</a><p>
    <a href="#" id="seekToEnd">다 끝나가니 기다리시오</a> 
   </div>
   <!-- 수강진행상황 -->
   <div class="suganging">
    <label>최대 학습시간</label>
    <span id="conts_max">0분</span>/<span id="vdo_length">0분</span>
    <button id="markAttendance">출석인정</button><p>
   		<div id="status"></div>
   </div>
   <div>
   	
   </div>
   
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
    let player;
    let vdo_length = 0; 			//영상길이
    let conts_max = 0; 	//최대시청시간
    let conts_final = 0; 		//마지막시청시간
    let originalTime; 			//조작한 시간(플레이어 일시정지, 조작 시 원래대로 돌리는 데 사용)
    let isPaused = false;		//일시정지 여부

    // youtube IFrame API 호출함수
    function onYouTubeIframeAPIReady() {
        player = new YT.Player('player', {
            height: '778',
            width: '1377',
            videoId: 'KhpO-7bHeAs',
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

    // 북마크(비디오가 준비된 후 이벤트 리스너 설정)
    function onPlayerReady(event) {
    	vdo_length = player.getDuration();
        document.getElementById('vdo_length').innerText = Math.floor(vdo_length / 60) + "분";
        event.target.playVideo();
        checkPlayerTime();

        document.getElementById('seekToStart').addEventListener('click', () => {
            if (conts_max >= 0) player.seekTo(0, true);
            else alert("개요로 이동하기 위해서는 먼저 시청해야 합니다.");
        });

        document.getElementById('seekToHalf').addEventListener('click', () => {
            const halfTime = vdo_length / 2;
            if (conts_max >= halfTime) player.seekTo(halfTime, true);
            else alert("잠오는 시점으로 이동하기 위해서는 먼저 시청해야 합니다.");
        });

        document.getElementById('seekToEnd').addEventListener('click', () => {
            if (conts_max >= vdo_length - 5) player.seekTo(vdo_length, true);
            else alert("끝으로 이동하기 위해서는 먼저 시청해야 합니다.");
        });
    }

  	//재생시간 체크(현재 재생시간을 10ms마다 업뎃해서 conts_final과 watchedTime을 저장)
    function checkPlayerTime() {
        setInterval(() => {
            if (!isPaused) {
            	conts_final = player.getCurrentTime();//현재 재생위치 저장
                if (conts_final > conts_max) {
                	conts_max = conts_final; //최대시간 저장
                    document.getElementById('conts_max').innerText = Math.floor(conts_max / 60) + "분";
                }
            }
        }, 3000); //3초마다 현재시간 업뎃
    }

  	// 플레이어 상태변화 감지
    function onPlayerStateChange(event) {
        isPaused = event.data === YT.PlayerState.PAUSED;
        if (!isPaused) checkSliderMovement();
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

    // 출석인정 기능 
    document.getElementById('markAttendance').addEventListener('click', () => {
        if (Math.abs(conts_max - vdo_length) <= 5) {
            document.getElementById('status').innerText = "출석이 인정되었습니다!";
        } else {
            document.getElementById('status').innerText = "출석이 인정되지 않았습니다. 영상 시청을 완료해주세요.";
        }
    });
    
    
    
    
    
    
    
    //유튜브 api 자료 가져오기 함수
    const videoId = 'KhpO-7bHeAs';  // 조회할 비디오 ID

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
            	console.error("YouTube config 요청 오류:", error);
            }
        });
    });
    
    
  	//마지막 시청시간을 불러오는 함수
    function saveWatchTime(){
    	fetch('/api/progress/save',{
    		method: 'POST',
    		headers: {'Content-Type': 'application/json'},
    		body: JSON.stringify({
    			videoId: '4HGg3PGxXTI',
    			userId: 'user50',
    			conts_final: conts_final
    		})
    		
    	});
    }
    
    setInterval(saveWatchTime, 500)//시청시간 저장
    
    
    //페이지 로드 시 마지막 시청시간을 불러오는 함수
    function loadWatchTime(){
    	fetch('/api/progress/4HGg3PGxXTI/user50')
    	.then(response => response.json())
    	.then(conts_final => {
    		if(conts_final >0 ){
    			player.seekTo(conts_final,true);
    		}
    	});
    }
    
</script>
<script src="https://www.youtube.com/iframe_api"></script>
</body>
</html>
