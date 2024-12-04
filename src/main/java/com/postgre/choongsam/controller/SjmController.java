package com.postgre.choongsam.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.postgre.choongsam.dto.Ask;
import com.postgre.choongsam.dto.File_Group;
import com.postgre.choongsam.dto.Lecture;
import com.postgre.choongsam.dto.Note;
import com.postgre.choongsam.dto.Notice;
import com.postgre.choongsam.dto.Paging;
import com.postgre.choongsam.service.SjmService;

import org.springframework.core.io.Resource;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class SjmController {
	private final SjmService ss;

	// 공지사항 ------------------------------------------------------------------

	// NOTE - 공지사항 목록
	@GetMapping(value = "/api/notice")
	public String notice(Model model, @RequestParam(value = "currentPage", defaultValue = "1") String currentPage,
			@RequestParam(value = "keyword", required = false) String keyword,HttpSession session) {

		
		int total = 0;
		Paging page = new Paging();	
		Map<String, Object> params = new HashMap<>();
		List<Notice> noticeList = new ArrayList<>();
				
		params.put("keyword", keyword);
		
		Integer user_status = (Integer) session.getAttribute("usertype");
		
		if (user_status != null && user_status == 1003) {
		    // user_status가 1003일 경우
		    total = ss.countNoticeAll(params);  // 전체 공지사항의 개수를 가져옴
		    page = new Paging(total, currentPage);  // 페이지 객체 생성
		    params.put("start", page.getStart());  // 페이지 시작 인덱스
		    params.put("rowPage", page.getRowPage());  // 페이지당 행 개수
		    noticeList = ss.selectNoticeListAll(params);  // 공지사항 리스트 가져옴
		} else {
		    // user_status가 1003이 아닌 경우
		    total = ss.countNotice(keyword);  // 조건에 맞는 공지사항 개수를 가져옴
		    page = new Paging(total, currentPage);  // 페이지 객체 생성
		    params.put("start", page.getStart());  // 페이지 시작 인덱스
		    params.put("rowPage", page.getRowPage());  // 페이지당 행 개수
		    noticeList = ss.selectNoticeList(params);  // 공지사항 리스트 가져옴
		}
		

		model.addAttribute("keyword", keyword);
		model.addAttribute("page", page);
		model.addAttribute("total", total);
		model.addAttribute("noticeList", noticeList);

		return "view_Sjm/noticeList";

	}

	// NOTE - 공지사항 작성화면
	@GetMapping(value = "/api/notice/new")
	public String noticeCreateForm() {

		System.out.println("SjmController.noticeCreate start .....");

		return "view_Sjm/noticeCreate";
	}
	
	
	// NOTE - 공지사항 수정화면
	@GetMapping(value = "/api/notice/edit")
	public String noticeEdit(@RequestParam("ntc_mttr_sn") int ntc_mttr_sn,Model model) {
		
		System.out.println("SjmController.noticeEdit start .....");
		Notice notice = ss.noticeDetail(ntc_mttr_sn);
		
		model.addAttribute("notice", notice);
		
		return "view_Sjm/noticeEdit";
	}

	// NOTE - 공지사항 작성
	@PostMapping(value = "/api/notice/new")
	public ResponseEntity<String> noticeCreate(Notice notice, @RequestParam("files") MultipartFile[] files,
			HttpServletRequest request) {
		System.out.println("작성 시작");
		System.out.println("받은 파일 수: " + files.length); // 파일 수 출력

		System.out.println("notice-->" + notice);
		
		System.out.println("수정 파라메터 --->" +notice.getNtc_mttr_sn());
		
		int result = ss.noticeCreate(notice, files, request);


		if (result > 0) {
			// 답변 작성이 성공했을 때
			String alertScript = "<script type='text/javascript'>"
					+ "alert('공지사항 작성이 완료되었습니다!');"
					+ "window.location.href = '/api/notice'" 
					+ "</script>";
			return ResponseEntity.status(HttpStatus.OK)
					.header(HttpHeaders.CONTENT_TYPE, "text/html; charset=UTF-8")
					.body(alertScript);
		} else {
			// 실패 시 메시지와 리디렉션
			String alertScript = "<script type='text/javascript'>"
					+ "alert('공지사항 작성에 실패했습니다!');"
					+ "window.location.href = '/api/notice'" 
					+ "</script>";
			return ResponseEntity.status(HttpStatus.OK)
					.header(HttpHeaders.CONTENT_TYPE, "text/html; charset=UTF-8")
					.body(alertScript);
		}


		//return ResponseEntity.ok(result);
	}

	// NOTE - 공지사항 상세 화면
	@GetMapping(value = "/view_Sjm/noticeDetail")
	public String noticeDetailForm(@RequestParam("ntc_mttr_sn") int ntc_mttr_sn, Model model) {
		model.addAttribute("ntc_mttr_sn", ntc_mttr_sn);
		return "view_Sjm/noticeDetail"; // view_Sjm/noticeDetail.jsp로 이동
	}

	// NOTE - 공지사항 상세
	@GetMapping(value = "/api/notice/{ntc_mttr_sn}")
	@ResponseBody
	public Notice noticeDetail(@PathVariable("ntc_mttr_sn") int ntc_mttr_sn) {

		System.out.println("SjmController.noticeDetailForm() start...");

		Notice notice = ss.noticeDetail(ntc_mttr_sn);

		return notice;
	}

	// NOTE - 파일 리스트 가져오기
	@GetMapping(value = "/api/files/{file_group}")
	@ResponseBody
	public List<File_Group> getFilesByGroup(@PathVariable int file_group) {
		// 파일 그룹 ID에 해당하는 파일 리스트를 가져옴
		System.out.println("파일 리스트 가져오기");
		List<File_Group> files = ss.getFilesByGroup(file_group);
		System.out.println("file--->" + files);
		return files;
	}

	@GetMapping(value = "/api/files/{fileGroup}/{fileSeq}")
	public ResponseEntity<Resource> downloadFile(@PathVariable("fileGroup") int fileGroup,
			@PathVariable("fileSeq") int fileSeq, HttpServletRequest request) { // HttpServletRequest 추가
		System.out.println("다운로드 시작");

		try {
			// 파일 정보를 조회
			File_Group file = ss.getFile(fileGroup, fileSeq);

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
	
	// NOTE - 공지사항 노출 여부
	@PostMapping(value = "/api/notice/delete")
	@ResponseBody
	public ResponseEntity<String> updateNoticeYn(@RequestParam List<Integer> deleteIds, HttpSession session){

		System.out.println("deleteIds--->"+deleteIds);
		
		int result = 0;
		
		for(int noticeId : deleteIds) {
			Notice notice = new Notice();
			notice.setNtc_mttr_sn(noticeId);
			notice.setNtc_mttr_yn("N");
			result += ss.updateNoticeYn(notice); // 각 업데이트 결과를 result에 누적
		}
		
		
		
		if (result > 0) {
			// 답변 작성이 성공했을 때
			String alertScript = "<script type='text/javascript'>"
					+ "alert('공지사항 삭제 완료되었습니다!');"
					+ "window.location.href = '/api/notice'" 
					+ "</script>";
			return ResponseEntity.status(HttpStatus.OK)
					.header(HttpHeaders.CONTENT_TYPE, "text/html; charset=UTF-8")
					.body(alertScript);
		} else {
			// 실패 시 메시지와 리디렉션
			String alertScript = "<script type='text/javascript'>"
					+ "alert('공지사항 삭제 실패했습니다!');"
					+ "window.location.href = '/api/notice'" 
					+ "</script>";
			return ResponseEntity.status(HttpStatus.OK)
					.header(HttpHeaders.CONTENT_TYPE, "text/html; charset=UTF-8")
					.body(alertScript);
		}
	}
	
	
	// ##################
	// ##################
	// ##################
	// ##################
	// 쪽지 ------------------------------------------------------------------
	// ##################
	// ##################
	// ##################
	// ##################

	// 받은 쪽지 화면
	@GetMapping(value = "/notes/received")
	public String ShowNoteReceived(HttpSession session) {
		System.out.println("SjmController.ShowNoteSend() start.....");
		System.out.println("SjmController.ShowNoteSend() 받은 쪽지 화면 ---> " + session.getAttribute("user_seq"));

		return "view_Sjm/noteReceived";
	}

	// 보낸 쪽지 화면
	@GetMapping(value = "/notes/sent")
	public String ShowNoteSend(HttpSession session) {
		System.out.println("SjmController.ShowNoteSend() start.....");
		System.out.println("SjmController.ShowNoteSend() 보낸 쪽지 화면 ---> " + session.getAttribute("user_seq"));

		return "view_Sjm/noteSent";
	}

	// NOTE - 받은 쪽지 목록
	@GetMapping(value = "/api/notes/received")
	@ResponseBody
	public Map<String, Object> getNotesReceived(Model model,
			@RequestParam(value = "currentPage", defaultValue = "1") String currentPage,
			@RequestParam(value = "keyword", required = false) String keyword, HttpSession session) {

		System.out.println("SjmController.rcvrnoteList() ");
		// System.out.println("text is of type: " +
		// session.getAttribute("user_seq").getClass().getSimpleName());

		Map<String, Object> params = new HashMap<>();
		params.put("user_seq", session.getAttribute("user_seq"));
		params.put("keyword", keyword);
		
		
		int total = ss.getNoteRcvrTotal(params);

		Paging page = new Paging(total, currentPage);
		// Map 객체 생성하여 파라미터 설정

		params.put("start", page.getStart());
		params.put("rowPage", page.getRowPage());
		List<Note> noteList = ss.getNotesReceived(params);

		Map<String, Object> response = new HashMap<>();
		response.put("total", total); // 전체 데이터의 수
		response.put("notes", noteList); // 쪽지 목록
		response.put("paging", page); // 페이징 정보 (현재 페이지, 전체 페이지 등)

		return response;
	}

	// NOTE - 보낸 쪽지 목록
	@GetMapping(value = "/api/notes/sent")
	@ResponseBody
	public Map<String, Object> getNotesSend(Model model,
			@RequestParam(value = "currentPage", defaultValue = "1") String currentPage,
			@RequestParam(value = "keyword", required = false) String keyword, HttpSession session) {
		
		Map<String, Object> params = new HashMap<>();
		params.put("user_seq", session.getAttribute("user_seq"));
		params.put("keyword", keyword);
		
		int total = ss.getNoteSendTotal(params);
				
		System.out.println("SjmController.getNotesSend() keyword-->" +keyword);
		Paging page = new Paging(total, currentPage);
		// Map 객체 생성하여 파라미터 설정

		params.put("start", page.getStart());
		params.put("rowPage", page.getRowPage());
		List<Note> noteList = ss.getNotesSend(params);

		Map<String, Object> response = new HashMap<>();
		response.put("total", total); // 전체 데이터의 수
		response.put("notes", noteList); // 쪽지 목록
		response.put("paging", page); // 페이징 정보 (현재 페이지, 전체 페이지 등)

		return response;
	}

	// 쪽지 상세 화면
	@GetMapping(value = "/note/{note_sn}")
	public String noteDetailForm(@PathVariable("note_sn") int note_sn, Model model, HttpSession session) {
		System.out.println("쪽지 디테일 화면");
		
		Note note = ss.getNote(note_sn);
		
		int userSeq = (int) session.getAttribute("user_seq");
		
		// 수신자일 경우 수신 일시 업데이트
	    if (note.getRcvr_seq() == userSeq && note.getRcptn_dt() == null) {
	        int result = ss.updateReceiveDate(note_sn);  // 쪽지 수신 일시 업데이트
	    }
		
		
		model.addAttribute("note_sn", note_sn);
		return "view_Sjm/noteDetail"; // view_Sjm/noticeDetail.jsp로 이동
	}

	// NOTE - 쪽지 상세정보 조회
	@GetMapping(value = "/api/notes/{note_sn}")
	@ResponseBody
	public Note getNote(@PathVariable("note_sn") int note_sn) {
		System.out.println("상세 쪽지 시작");

		Note note = ss.getNote(note_sn);
		return note;
	}

	// 쪽지 전송 화면
	@GetMapping(value = "/notes/new")
	public String CreateNoteForm(@RequestParam(value = "note_sn", required = false) Integer note_sn,
			@RequestParam(value = "sndpty_seq", required = false) Integer sndpty_seq,
			@RequestParam(value = "sender_name", required = false) String sender_name, Model model) {

		System.out.println("쪽지전송화면");

		// note_sn이 존재하면 모델에 추가
		if (note_sn != null && sndpty_seq != null && sender_name != null) {
			model.addAttribute("bfr_note_sn", note_sn);
			model.addAttribute("rcvr_seq", sndpty_seq);
			model.addAttribute("receiver_name", sender_name);
		}

		return "view_Sjm/noteCreate";
	}

	@RequestMapping(value = "/api/notes", method = RequestMethod.POST)
	@ResponseBody
	public int createNote(@RequestBody Map<String, Object> noteData, HttpSession session) {
		System.out.println(noteData);

		// 수신자 배열 받아오기
		Object rcvrSeqObj = noteData.get("rcvr_seq");

		List<Integer> receiverSeqs = null;

		// rcvr_seq가 배열 형태로 넘어온다면 List<Integer>로 변환
		if (rcvrSeqObj instanceof List) {
			receiverSeqs = (List<Integer>) rcvrSeqObj; // rcvr_seq를 List<Integer>로 변환
		} else if (rcvrSeqObj instanceof String) {
			// 만약 String 형태로 넘어온다면, ','로 구분된 숫자들이 있을 수 있음
			String[] seqArray = ((String) rcvrSeqObj).split(",");
			receiverSeqs = new ArrayList<>();
			for (String seq : seqArray) {
				try {
					receiverSeqs.add(Integer.parseInt(seq.trim())); // 각 값을 Integer로 변환 후 추가
				} catch (NumberFormatException e) {
					// 만약 변환 실패하면 예외 처리
					continue;
				}
			}
		}

		// 수신자가 비어있다면 실패 처리
		if (receiverSeqs == null || receiverSeqs.isEmpty()) {
			return 0;
		}

		Note note = new Note();
		note.setNote_ttl((String) noteData.get("note_ttl"));
		note.setNote_cn((String) noteData.get("note_cn"));
		note.setSndpty_note_yn((String) noteData.get("sndpty_note_yn"));
		note.setRcvr_note_yn((String) noteData.get("rcvr_note_yn"));

		// bfr_note_sn이 null일 수 있으므로 기본값 0 처리
		Object bfrNoteSnObj = noteData.get("bfr_note_sn");
		int bfrNoteSn = (bfrNoteSnObj != null) ? Integer.parseInt(bfrNoteSnObj.toString()) : 0; // Integer로 안전하게 변환
		note.setBfr_note_sn(bfrNoteSn);

		// sndpty_seq는 String에서 Integer로 변환
		try {
			Object sndptySeqObj = noteData.get("sndpty_seq");
			if (sndptySeqObj != null) {
				note.setSndpty_seq(Integer.parseInt(sndptySeqObj.toString())); // String -> Integer 변환
			} else {
				note.setSndpty_seq(0); // 기본값 0 설정
			}
		} catch (NumberFormatException e) {
			// 변환 실패 시 기본값 0 설정
			note.setSndpty_seq(0);
		}

		// 각 수신자에 대해 쪽지 삽입
		for (int receiverSeq : receiverSeqs) {
			note.setRcvr_seq(receiverSeq);
			// 직접 쪽지 생성하는 로직
			int result = ss.createNote(note);
			if (result == 0) {
				return 0; // 실패 시 종료
			}
		}

		return 1; // 성공 시
	}

	// NOTE - 내가 듣는 강의 목록
	@GetMapping(value = "/api/lectures/my")
	@ResponseBody
	public ResponseEntity<?> getMyLectures(@RequestParam(value = "user_seq", required = false) Integer userSeq ) {
		if (userSeq == null) {
			return ResponseEntity.badRequest().body("user_seq is required");
		}
		System.out.println("내가 듣는 강의 목록 불러오기 ");
		
	
		
		List<Lecture> lectures = ss.getMyLectures(userSeq);
		return ResponseEntity.ok(lectures);
	}
	
	
	
	
	// NOTE - 같이 듣는 사람들 
	@GetMapping(value = "/api/lectures/recipients")
	@ResponseBody
	public ResponseEntity<?> getSameLeceture(@RequestParam("lctr_id") String lctr_id, HttpSession session) {
		System.out.println("내가 듣는 강의 목록 불러오기 같은 강의를 듣는 사람들->" + lctr_id);
		// params 초기화
	    Map<String, Object> params = new HashMap<>();  
	    
		int user_seq = (Integer) session.getAttribute("user_seq");
		params.put("user_seq", user_seq);
		params.put("lctr_id", lctr_id);
		System.out.println("params--->" + params);
		List<Note> note = ss.getSameLeceture(params);
		return ResponseEntity.ok(note);
	}
	
	@PostMapping(value="/api/note/delete")
	@ResponseBody
	public ResponseEntity<String> updateNoteDelYn(@RequestParam List<Integer> deleteIds, HttpSession session){
		
		System.out.println("쪽지를 삭제해보자  --> " +deleteIds );
		
		
		 Integer userSeq = (Integer) session.getAttribute("user_seq");
		    
		    // 세션에 user_seq가 없으면 처리 중지
		    if (userSeq == null) {
		        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
		                .body("<script type='text/javascript'>alert('세션이 만료되었습니다. 로그인 해주세요.'); window.location.href='/login';</script>");
		    }
		
		int result = 0;
		// 받은 사람은 읽은 쪽지만 삭제 가능함 -> 이건 뷰에서 해줌 
		// 그럼 읽은 쪽지를 가져옴 
		// 받은 사람 이름과 로그인 세션이름이 같으면 수신자 쪽 삭제 여부
		for(int noteId  : deleteIds) {
			Note note = ss.getNote(noteId);
			
			
			
			// 받은 쪽지 삭제
			if( note.getRcvr_seq() == userSeq) {
	        	note.setNote_sn(noteId);
	        	note.setRcvr_note_yn("N");
				result = ss.updateNoteRcvrDelYn(note);
				if (result > 0) {
	                System.out.println("쪽지 ID " + noteId + "의 수신자 삭제 여부가 업데이트되었습니다.");
	            }
			}
			// 보낸 쪽지 삭제 (로그인한 사용자가 발신자일 경우)
	        else if (note.getSndpty_seq() == userSeq) {
	        	note.setNote_sn(noteId);
	        	note.setSndpty_note_yn("N");
	            result = ss.updateNoteSentDelYn(note);
	            if (result > 0) {
	                System.out.println("쪽지 ID " + noteId + "의 발신자 삭제 여부가 업데이트되었습니다.");
	            }
	        } else {
	            System.out.println("쪽지 ID " + noteId + "는 현재 사용자와 관련이 없습니다.");
	        }
			
			
			
	    }
		
		if (result > 0) {
			// 답변 작성이 성공했을 때
			String alertScript = "<script type='text/javascript'>"
					+ "alert('쪽지 삭제 완료되었습니다!');"
					+ "window.location.href = '/notes/sent'" 
					+ "</script>";
			return ResponseEntity.status(HttpStatus.OK)
					.header(HttpHeaders.CONTENT_TYPE, "text/html; charset=UTF-8")
					.body(alertScript);
		} else {
			// 실패 시 메시지와 리디렉션
			String alertScript = "<script type='text/javascript'>"
					+ "alert('쪽지 삭제 실패했습니다!');"
					+ "window.location.href = '/notes/sent'" 
					+ "</script>";
			return ResponseEntity.status(HttpStatus.OK)
					.header(HttpHeaders.CONTENT_TYPE, "text/html; charset=UTF-8")
					.body(alertScript);
		}

			
			
		}
		
	
		

	


	// ##################
	// ##################
	// ##################
	// ##################
	// 문의사항 ------------------------------------------------------------------
	// ##################
	// ##################
	// ##################
	// ##################

	// NOTE - 문의사항
	@GetMapping(value = "/asks/new")
	public String asksForm() {

		System.out.println("문의사항 페이지");

		return "view_Sjm/askCreate";
	}

	// NOTE - 문의사항 작성
	@PostMapping(value = "/api/asks/new")
	public ResponseEntity<String> postAsks(Ask ask, HttpSession session) {

		System.out.println("작성 시작");

		ask.setUser_seq((int) session.getAttribute("user_seq"));
		int result = ss.postAsks(ask);


		if (result > 0) {
			// 답변 작성이 성공했을 때
			String alertScript = "<script type='text/javascript'>"
					+ "alert('답변 작성이 완료되었습니다!');"
					+ "window.location.href = '/asks/my'"  // 리디렉션할 페이지
					+ "</script>";
			return ResponseEntity.status(HttpStatus.OK)
					.header(HttpHeaders.CONTENT_TYPE, "text/html; charset=UTF-8")
					.body(alertScript);
		} else {
			// 실패 시 메시지와 리디렉션
			String alertScript = "<script type='text/javascript'>"
					+ "alert('답변 작성에 실패했습니다!');"
					+ "window.location.href = '/asks/my'"  // 리디렉션할 페이지
					+ "</script>";
			return ResponseEntity.status(HttpStatus.OK)
					.header(HttpHeaders.CONTENT_TYPE, "text/html; charset=UTF-8")
					.body(alertScript);
		}


		//return ResponseEntity.ok(result);
	}

	// NOTE - 내 문의사항
	@GetMapping(value = "/asks/my")
	public String asksListForm() {

		System.out.println("문의사항 목록 페이지");

		return "view_Sjm/askMyList";
	}

	// 문의사항 리스트 
	@GetMapping(value = "/api/asks")
	@ResponseBody
	public Map<String, Object> getAsksMy(@RequestParam(value = "currentPage", defaultValue = "1") String currentPage,
	@RequestParam(value = "keyword", required = false) String keyword, HttpSession session) {
		System.out.println("컨트롤러 문의사항 리스트 시작");

		Map<String, Object> params = new HashMap<>();
		params.put("user_seq", (int)session.getAttribute("user_seq"));
		List<Ask> ask = null;
		
		params.put("keyword", keyword);


		int total = 0;
		Paging page = null;
		
		
		Integer user_status = (Integer) session.getAttribute("usertype");
		
		if (user_status != null && user_status == 1003) {
			System.out.println("관리자 리스트");
			total = ss.countAsk(params);
			page = new Paging(total, currentPage);
			params.put("start", page.getStart());
		params.put("rowPage", page.getRowPage());
			ask = ss.getAsks(params);
		}else {
			System.out.println("내리스트");
			total = ss.countAskMy(params);
			page = new Paging(total, currentPage);
			params.put("start", page.getStart());
			params.put("rowPage", page.getRowPage());
			ask = 	ss.getAsksMy(params);
			
		}
		
		Map<String, Object> response = new HashMap<>();
		response.put("total", total); // 전체 데이터의 수
		response.put("asks", ask); // 쪽지 목록
		response.put("paging", page); // 페이징 정보 (현재 페이지, 전체 페이지 등)

		return response;
	}

	// 문의사항 상세 페이지
	@GetMapping(value = "/asks/{dscsn_sn}")
	public String askDetailForm(@PathVariable("dscsn_sn") int dscsn_sn, Model model) {
		System.out.println("쪽지 디테일 화면");
		model.addAttribute("note_sn", dscsn_sn);
		return "view_Sjm/askDetail"; // view_Sjm/noticeDetail.jsp로 이동
	}

	// NOTE - 문의사항 상세정보 조회
	@GetMapping(value = "/api/asks/{dscsn_sn}")
	@ResponseBody
	public Ask getAsk(@PathVariable("dscsn_sn") int dscsn_sn) {
		System.out.println("문의사항 상세 시작");

		Ask ask = ss.getAsk(dscsn_sn);
		System.out.println("ask-->" + ask);
		return ask;
	}
	
	// NOTE - 문의사항 답변 작성 
	@PostMapping(value = "/api/asks/reply")
	public ResponseEntity<String> replyUpdateAsks(Ask ask, HttpSession session) {
		System.out.println("답변작성 시작 -->" + ask);
		int user_seq =(int) session.getAttribute("user_seq");
		ask.setDscsn_ans_seq(user_seq);
		int result = ss.replyUpdateAsks(ask);
	
    if (result > 0) {
        // 답변 작성이 성공했을 때
        String alertScript = "<script type='text/javascript'>"
                + "alert('답변 작성이 완료되었습니다!');"
                + "window.location.href = '/asks/" + ask.getDscsn_sn() + "';"  // 리디렉션할 페이지
                + "</script>";
        return ResponseEntity.status(HttpStatus.OK)
                .header(HttpHeaders.CONTENT_TYPE, "text/html; charset=UTF-8")
                .body(alertScript);
    } else {
        // 실패 시 메시지와 리디렉션
        String alertScript = "<script type='text/javascript'>"
                + "alert('답변 작성에 실패했습니다!');"
                + "window.location.href = '/asks/" + ask.getDscsn_sn() + "';"  // 리디렉션할 페이지
                + "</script>";
        return ResponseEntity.status(HttpStatus.OK)
                .header(HttpHeaders.CONTENT_TYPE, "text/html; charset=UTF-8")
                .body(alertScript);
    }


		//return ResponseEntity.ok(result);
	}
}
