package com.postgre.choongsam.service;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.postgre.choongsam.dao.HmsDao;
import com.postgre.choongsam.dto.Class_Bookmark;
import com.postgre.choongsam.dto.Class_Schedule;
import com.postgre.choongsam.dto.File_Group;
import com.postgre.choongsam.dto.Lecture_Video;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;

@Service
@RequiredArgsConstructor
public class HmsServiceImpl implements HmsService{
	private final HmsDao HD;
	
	@Value("${youtube.api.key}")
	private String apiKey;
	
	@Value("${youtube.api.base-url}")
	private String baseUrl;
	
	//영상 가져오기
	public String getVideoDetails(String videoId) {
	    // YouTube API 호출 URL 생성
	    String url = String.format("%s/videos?id=%s&key=%s&part=snippet,contentDetails,statistics", baseUrl, videoId, apiKey);

	    // RestTemplate로 API 호출
	    RestTemplate restTemplate = new RestTemplate();
	    ResponseEntity<String> responseEntity = restTemplate.getForEntity(url, String.class);
	    String response = responseEntity.getBody();
	    

	    System.out.println("apiKey->"+apiKey);
	    System.out.println("msService response->"+response);
	    System.out.println("Request URL: " + url);
	    
	    // 응답이 null이거나 JSON 형식이 아닌 경우 처리
	    if (response == null || !response.trim().startsWith("{")) {
	        System.out.println("유효하지 않은 JSON 응답을 받았습니다.");
	        return null; // 또는 적절한 예외 처리
	    }
	    
	    try {
	        // JSON 응답에서 필요한 데이터 추출
	        JSONObject json = new JSONObject(response);
	        if (json.has("items") && json.getJSONArray("items").length() > 0) {
	            JSONObject item = json.getJSONArray("items").getJSONObject(0);
	            JSONObject snippet = item.getJSONObject("snippet");
	            JSONObject statistics = item.getJSONObject("statistics");
	            JSONObject contentDetails = item.getJSONObject("contentDetails");

	            String title = snippet.getString("title");
	            String description = snippet.getString("description");
	            String thumbnailUrl = snippet.getJSONObject("thumbnails").getJSONObject("high").getString("url");
	            String duration = contentDetails.getString("duration");
	            int viewCount = statistics.getInt("viewCount");
	            
	            // duration을 초 단위로 변환
	            int durationInSeconds = parseDuration(duration);
	            System.out.println("durationInSeconds->"+durationInSeconds);

	            // Lecture_Video 객체에 매핑
	            Lecture_Video video = new Lecture_Video();
	            video.setConts_id(videoId);
	            video.setVdo_file_nm(title);
	            video.setFile_data(description);
	            video.setVdo_url_addr(thumbnailUrl);
	            video.setVdo_length(durationInSeconds);
	            
	            //데이터베이스에 저장
	            HD.APIdata(videoId);

	            System.out.println("duration->" + duration);
	            System.out.println("durationInSeconds->" + durationInSeconds);
	            return "view_Hms/videoView";
	        } else {
	            System.out.println("API에서 유효한 비디오 데이터를 찾을 수 없습니다.");
	            return null;
	        }
	    } catch (Exception e) {
	        System.err.println("JSON 파싱 오류: " + e.getMessage());
	        return null;
	    }
	}
	
	// duration을 초 단위로 변환
    private int parseDuration(String duration) {
        int seconds = 0;
        duration = duration.replace("PT", "");

        if (duration.contains("H")) {
            String[] parts = duration.split("H");
            seconds += Integer.parseInt(parts[0]) * 3600;
            duration = parts[1];
        }
        if (duration.contains("M")) {
            String[] parts = duration.split("M");
            seconds += Integer.parseInt(parts[0]) * 60;
            duration = parts[1];
        }
        if (duration.contains("S")) {
            String[] parts = duration.split("S");
            seconds += Integer.parseInt(parts[0]);
        }
        return seconds;
    }

	//영상 목록 불러오기
	@Override
	public List<Lecture_Video> findAllVideo() {
		System.out.println("msService findAllVideo start..");		
		return HD.findAllVideo();
	}

	//뷰에서 값 가져와서 update해주기
	@Override
	public void saveWatchTime(Class_Schedule class_schedule) {
		System.out.println("msService saveWatchTime start...");
		HD.saveWatchTime(class_schedule);
	}

	//현재 max값
	@Override
	public long findCurrentMax(String videoId, int user_seq, int lctr_no) {
		System.out.println("msService findCurrentMax start..");
		System.out.println("msService findCurrentMax videoId.."+videoId);
		System.out.println("msService findCurrentMax user_seq.."+user_seq);
		return HD.findCurrentMax(videoId,user_seq,lctr_no);
	}

	//max값 빼고 업뎃
	@Override
	public void saveWatchTimeNoMaxUpdate(Class_Schedule class_schedule) {
		System.out.println("msService saveWatchTime start...");
		System.out.println("msService saveWatchTime class_schedule..."+class_schedule);
		HD.saveWatchTimeNoMaxUpdate(class_schedule);
	}

	//final
	@Override
	public int watchedFinalTime(String videoId, int user_seq, int lctr_no) {
		System.out.println("msService watchedFinalTime start...");
		System.out.println("msService watchedFinalTime videoId..."+videoId);
		System.out.println("msService watchedFinalTime user_seq..."+user_seq);
		return HD.watchedFinalTime(videoId, user_seq,lctr_no);
	}

	@Override
	public String getFilePath(String conts_id) {
		System.out.println("msservice getFileName start..");
		return HD.getFilePath(conts_id);
	}

	@Override
	public List<Class_Bookmark> getBookmarksByContsId(String conts_id) {
		System.out.println("msService bookmark start..");
		return HD.Bookmark(conts_id);
	}

	@Override
	public List<Class_Bookmark> getBookmark(String conts_id) {
		System.out.println("msService getBookmark start..");
		System.out.println("msService getBookmark conts_id.."+conts_id);
		return HD.getBookmark(conts_id);
	}

	@Override
	public String getfilename(String conts_id) {
		System.out.println("msService getfilename start..");
		System.out.println("msService getfilename conts_id.."+conts_id);	
		return HD.getfilename(conts_id);
	}

	@Override
	public File_Group getFilegogo(String conts_id) {
		System.out.println("msService getFilegogo start..");
		System.out.println("msService getFilegogo conts_id.."+conts_id);
		return HD.getfileGoGo(conts_id);
	}

	


	
	
}
