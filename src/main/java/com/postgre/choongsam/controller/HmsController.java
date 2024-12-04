package com.postgre.choongsam.controller;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import com.postgre.choongsam.dao.HmsDao;
import com.postgre.choongsam.dto.Class_Bookmark;
import com.postgre.choongsam.dto.Class_Schedule;
import com.postgre.choongsam.dto.File_Group;
import com.postgre.choongsam.dto.Lecture_Video;
import com.postgre.choongsam.dto.Syllabus;
import com.postgre.choongsam.service.HmsService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Slf4j
@Controller
@RequiredArgsConstructor
@CrossOrigin(origins="*")//모든 출처에서의 요청을 허용
public class HmsController {
	
	private final HmsService HS;
	private final HmsDao HD;
	
	@Value("${file.base-path}")
	private String basepath;
	
	
	//영상불러오기
	@GetMapping("/video-details")
	public String getVideoDetails(@RequestParam String videoId, Model model,
			@RequestParam int user_seq,
			@RequestParam int lctr_no) {
		System.out.println("hmsController youtube api start..");
		System.out.println("hmsController Received videoId:"+ videoId);
		System.out.println("hmsController Received user_seq:"+ user_seq);
		System.out.println("hmsController Received lctr_no:"+ lctr_no);
		//System.out.println("Received filename:"+ filename);
		
		String URL = HD.getURL(videoId); //videoId를 이용해서 Addr 다시 불러오기
		System.out.println("msController getURL ->"+ URL);
		
		String result = HS.getVideoDetails(URL);		
		System.out.println("mscontroller getVideoDetails result->"+result);
		
		//Lecture_video 객체 생성
		Lecture_Video lectureVideo =  new Lecture_Video();
		lectureVideo.setConts_id(videoId);
		
		//유튜브 url 생성 (addr로 변경)
		String videoUrl = "http://www.youtube.com/embed/" + URL;
		System.out.println("hmsController videoUrl:"+videoUrl);		
		model.addAttribute("videoUrl", videoUrl);
		model.addAttribute("videoId",URL); //videoId에 URL 주소값 넣어서 보내기.
		model.addAttribute("conts_id",videoId); //0101 등 영상번호
		model.addAttribute("user_seq",user_seq);
		model.addAttribute("lctr_no",lctr_no);
		String filename= HD.getfilename(videoId);
		
		model.addAttribute("filename",filename);
		
		return "view_Hms/videoView";
	}

	//postgre 모든 영상 조회
	@GetMapping("/video-list")
	public String getVideoList(Model model) {
		List<Lecture_Video> videoList = HS.findAllVideo();
		model.addAttribute("videoList",videoList);
		return "view_Hms/videoList";
	}
	
	//시청시간 저장하기
	@PostMapping("/api/progress/save")
	public String dataSave(Lecture_Video lecture_video, 
			@RequestParam String videoId,
			@RequestParam int user_seq,
			@RequestParam int lctr_no,
			@RequestParam long conts_final,
			@RequestParam long conts_max, 
			@RequestParam int vdo_length) {
		System.out.println("msController dataSave start..");
		System.out.println("msController dataSave videoId->"+videoId);
		System.out.println("msController dataSave user_seq->"+user_seq);
		System.out.println("msController dataSave lctr_no->"+lctr_no);
		System.out.println("msController dataSave conts_final->"+conts_final);		
		System.out.println("msController dataSave vdo_length->"+vdo_length);		
		System.out.println("conts_max 방금 재생한 currentmax값->"+conts_max);
	
		Syllabus lctrInfo = HD.findLctrInfo(videoId,lctr_no);
		System.out.println("msController datasave lctrInfo->"+lctrInfo);
		Class_Schedule class_schedule = new Class_Schedule();
		
		//현재 DB의 conts_max값 조회
		long currentContsMax = HS.findCurrentMax(videoId,user_seq,lctr_no);	
		System.out.println("mscontroller 현재 DB max값->"+currentContsMax);	
			
		class_schedule.setConts_final(conts_final);		
		class_schedule.setConts_id(videoId);
		class_schedule.setUser_seq(user_seq);
		class_schedule.setLctr_id(lctrInfo.getLctr_id());
		class_schedule.setLctr_no(lctrInfo.getLctr_no()); 	
		System.out.println("msController filnasave class_schedule->"+class_schedule);
		String lctr_id = lctrInfo.getLctr_id();
		System.out.println("msController filnasave lctr_no->"+lctr_id);

		// conts_max가 현재 값보다 큰 경우에만 업데이트
	    if (conts_max > currentContsMax) {
	        class_schedule.setConts_max(conts_max); // 새로운 conts_max 설정
	        long conts_prgrt = (class_schedule.getConts_max()*100)/vdo_length;
			System.out.println("conts_prgrt->"+conts_prgrt);
			class_schedule.setConts_prgrt(conts_prgrt);      
	        HS.saveWatchTime(class_schedule); // conts_max를 포함한 업데이트
	    } else {
	        // conts_max가 현재 값보다 작거나 같은 경우, conts_final만 업데이트
	        class_schedule.setConts_max(currentContsMax); // 기존 값을 유지
	        long conts_prgrt = (class_schedule.getConts_max()*100)/vdo_length;
			System.out.println("conts_prgrt->"+conts_prgrt);
			class_schedule.setConts_prgrt(conts_prgrt);
	        HS.saveWatchTimeNoMaxUpdate(class_schedule); // conts_max 없이 업데이트
	    }   		
	    System.out.println("mscontroller dataSave class_schedule->"+class_schedule);	
		return "redirect:/sh_lecture_student?lctr_id="+lctr_id+"&user_seq="+user_seq;//이전 강의목록으로
	}
	
	//마지막 위치 가져오기
	@GetMapping("/api/progress/{videoId}")
	public ResponseEntity<Class_Schedule> getProgress(@PathVariable String videoId, 
			@RequestParam int user_seq,
			@RequestParam int lctr_no) {
		System.out.println("msController getProgress start..");
		System.out.println("msController getProgress videoId.."+videoId);
		System.out.println("msController getProgress user_seq.."+user_seq);
		System.out.println("msController getProgress lctr_no.."+lctr_no);
	    // 비디오 ID를 사용하여 시청 시간 정보를 조회합니다.
	    int conts_final = HS.watchedFinalTime(videoId, user_seq, lctr_no);    
	    System.out.println("mscontroller getProgress conts_final"+conts_final);

	    // 결과를 DTO로 포장하여 반환.
	    Class_Schedule response = new Class_Schedule();
	    response.setConts_final(conts_final);
	    return ResponseEntity.ok(response);
	}
	
	//파일이름
	@GetMapping("/api/lectures/init")
	public String getfilename(@RequestParam String conts_id, Model model) {
		System.out.println("mscontroller getfilename start..");
		System.out.println("mscontroller getfilename conts_id.."+conts_id);
		String filename = HS.getfilename(conts_id);
		System.out.println("mscontroller getfilename filename->"+filename);
		model.addAttribute("filename",filename);
		return "view_Hms/videoView";
	}
	
	//강의자료 다운로드
	@GetMapping("/api/lectures/download/{conts_id}")
	public ResponseEntity<?> downloadLecture(@PathVariable("conts_id") String conts_id, Model model) {
	    try {
	        // 데이터베이스에서 파일 경로 가져오기
	        String filePathFromDb = HS.getFilePath(conts_id);
	        System.out.println("filePathFromDb for conts_id " + conts_id + ": " + filePathFromDb);  // 로그로 확인

	        // 파일 경로가 null인 경우
	        if (filePathFromDb == null || filePathFromDb.trim().isEmpty()) {
	            System.out.println("No file path found for filename: " + conts_id);
	            
	            // 파일이 없으면 alert 메시지를 포함한 HTML 반환
	            String alertScript = "<script type='text/javascript'>"
	                + "alert('첨부된 파일이 없습니다!');"
	                + "window.history.back();"
	                + "</script>";

	            return ResponseEntity.status(HttpStatus.OK)
	                    .header(HttpHeaders.CONTENT_TYPE, "text/html; charset=UTF-8")
	                    .body(alertScript);  // alert창 띄우기
	        }

	        // 경로가 유효하면 파일 다운로드 처리
	        String filePath = basepath + filePathFromDb;
	        System.out.println("Checking file path: " + filePath);

	        File file = new File(filePath);
	        if (!file.exists()) {
	            System.out.println("파일이 존재하지 않음: " + filePath);
	            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("파일이 존재하지 않습니다.");
	        }

	        // 파일 경로가 유효하면 파일 다운로드 처리
	        Path path = Paths.get(filePath);
	        Resource resource = new UrlResource(path.toUri());

	        if (resource.exists() && resource.isReadable()) {
	            String encodedFilename = URLEncoder.encode(resource.getFilename(), StandardCharsets.UTF_8);
	            String contentType = Files.probeContentType(path);
	            contentType = contentType != null ? contentType : "application/octet-stream";

	            return ResponseEntity.ok()
	                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedFilename + "\"")
	                    .header(HttpHeaders.CONTENT_TYPE, contentType)
	                    .body(resource);  // 파일 다운로드
	        } else {
	            System.out.println("파일을 읽을 수 없음: " + filePath);
	            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("파일을 읽을 수 없습니다.");
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류가 발생했습니다.");
	    }
	}

	//강의자료 다운로드 변경
	@GetMapping(value = "/api/files/ms/{conts_id}")
	public ResponseEntity<?> downloadGoGo(
	        @PathVariable("conts_id") String conts_id,
	        HttpServletRequest request) {  // HttpServletRequest 추가
	    System.out.println("다운로드 시작");

	    try {
	        // 파일 정보를 조회
	        File_Group file = HS.getFilegogo(conts_id);
	        System.out.println("msController downGoGo file->"+file);
	        // file이 null인 경우 처리
	        if (file == null) {
	            System.out.println("파일 정보가 존재하지 않습니다. conts_id: " + conts_id);
	            
	            // 파일이 없으면 alert 메시지 포함한 HTML 반환
	            String alertScript = "<script type='text/javascript'>"
	                    + "alert('첨부된 파일이 없습니다!');"
	                    + "window.history.back();"
	                    + "</script>";

	            return ResponseEntity.status(HttpStatus.OK)
	                    .header(HttpHeaders.CONTENT_TYPE, "text/html; charset=UTF-8")
	                    .body(alertScript);  // alert창 띄우기
	        }
	        
	        // 디버깅: file.getFile_path_nm()과 file.getFile_nm() 출력
	        System.out.println("File path: " + file.getFile_path_nm());
	        System.out.println("File name: " + file.getFile_nm());

	        // 파일 경로 디코딩 및 설정
	        String filePathStr = URLDecoder.decode(file.getFile_path_nm(), "UTF-8");

	        // 파일명과 확장자 결합
	        String fullFileName = file.getFile_nm() + "." + file.getFile_extn_nm(); // 파일명과 확장자를 결합

	        // 경로를 Path 객체로 변환 (경로 구분자 처리)
	        Path filePath = Paths.get(request.getSession().getServletContext().getRealPath(filePathStr)).normalize();

	        // 디버깅: 최종 경로 출력
	        System.out.println("File path (final): " + filePath);

	        // 파일이 존재하는지 확인
	        if (!Files.exists(filePath)) {
	            System.out.println("파일을 찾을 수 없습니다: " + filePath); // 디버깅 메시지 추가
	            return ResponseEntity.notFound().build();
	        }

	        // 파일 리소스 생성
	        Resource resource = new UrlResource(filePath.toUri());

	        // 파일명을 UTF-8로 인코딩하여 Content-Disposition 헤더에 사용
	        String encodedFileName = URLEncoder.encode(fullFileName, "UTF-8").replaceAll("\\+", "%20") // + 기호를 공백으로 변경
	                .replaceAll("%28", "(").replaceAll("%29", ")");

	        // 디버깅: 리소스 생성 확인
	        System.out.println("Resource created: " + resource.getFilename());

	        // 파일 다운로드를 위한 HTTP 응답 생성
	        return ResponseEntity.ok()
	                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename*=UTF-8''" + encodedFileName)
	                .body(resource);

	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.badRequest().build();
	    }
	}
	
	//북마크
	@GetMapping("/api/bookmarks/{conts_id}")
	public  ResponseEntity< List<Class_Bookmark>> getBookmark(@PathVariable("conts_id") String conts_id,Model model) {
		System.out.println("msController getBookmark start...");
		System.out.println("msController getBookmark conts_id..."+conts_id);
		List<Class_Bookmark> bookmark = HS.getBookmark(conts_id);
		System.out.println("msController getBookmark bookmark..."+bookmark);
		model.addAttribute("bookmark",bookmark);
		model.addAttribute("conts_id");
		if(bookmark !=null) {
			return ResponseEntity.ok(bookmark);
		}else {
			return ResponseEntity.notFound().build();
		}
	}
}
	

	
	
	

	
	


	

