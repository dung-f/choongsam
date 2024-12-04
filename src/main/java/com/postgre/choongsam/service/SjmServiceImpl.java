package com.postgre.choongsam.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.postgre.choongsam.dao.SjmDao;
import com.postgre.choongsam.dto.Ask;
import com.postgre.choongsam.dto.File_Group;
import com.postgre.choongsam.dto.Lecture;
import com.postgre.choongsam.dto.Note;
import com.postgre.choongsam.dto.Notice;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SjmServiceImpl implements SjmService {
	private final SjmDao sd;

	// NOTE - 공지사항 목록
	@Override
	public List<Notice> selectNoticeList(Map<String, Object> params) {

		List<Notice> noticeList = sd.selectNoticeList(params);

		return noticeList;
	}

	// NOTE - 공지사항 갯수 (페이징)
	@Override
	public int countNotice(String keyword) {

		int total = sd.countNotice(keyword);

		return total;
	}

	@Override
	public Notice noticeDetail(int ntc_mttr_sn) {

		System.out.println("SjmServiceImpl.noticeDetail() start.....");

		Notice notice = sd.noticeDetail(ntc_mttr_sn);

		return notice;
	}





	@Override
	@Transactional
	public int noticeCreate(Notice notice,MultipartFile[] files, HttpServletRequest request) {
	   
		List<File_Group> uploadFiles = new ArrayList<>();

	    // 파일 리스트를 순회하며 업로드
	    for (MultipartFile file : files) {
	        if (file != null && !file.isEmpty()) {
	            try {
	                File_Group uploadFile = uploadFile(file, request);
	                if (uploadFile != null) {
	                    uploadFiles.add(uploadFile);
	                }
	            } catch (IOException e) {
	                e.printStackTrace();
	                return -1;
	            }
	        }
	    }

	    // 파일 정보를 공지사항과 함께 저장
	    int result = sd.noticeCreate(notice, uploadFiles);
	    return result;
	}

	// 업로드된 파일을 처리하는 메서드
	public File_Group uploadFile(MultipartFile file, HttpServletRequest request) throws IOException {
	    // 파일 정보 변수 선언
		String timestamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
		String idntf_no = UUID.randomUUID().toString() + "_" + timestamp;
	    String originFile = file.getOriginalFilename();
	    String file_nm = ""; // 실제 파일명
	    String file_extn_nm = ""; // 확장자
	    int file_sz = 0; // 파일 크기

	    // 파일이 있는 경우 처리
	    if (originFile != null && !originFile.isEmpty()) {
	        int lastIndex = originFile.lastIndexOf(".");
	        if (lastIndex != -1) {
	            file_nm = originFile.substring(0, lastIndex);
	            file_extn_nm = originFile.substring(lastIndex + 1);
	            file_sz = (int) file.getSize();

	            System.out.println("originFile >> " + file_nm);
	            System.out.println("fileSuffix >> " + file_extn_nm);
	            System.out.println("fileSize >> " + file_sz + "바이트");

	            InputStream inputStream = file.getInputStream();

	         // 파일이 저장될 경로
	            String uploadPath = request.getSession().getServletContext().getRealPath("/chFile/Homework");

	            // 경로가 없으면 생성
	            File uploadDir = new File(uploadPath);
	            if (!uploadDir.exists()) {
	                uploadDir.mkdirs(); // 디렉토리 생성
	            }
	            
	            // 파일 저장
	            File targetFile = new File(uploadPath, idntf_no + "." + file_extn_nm);
	            try (FileOutputStream outputStream = new FileOutputStream(targetFile)) {
	                byte[] buffer = new byte[1024];
	                int bytesRead;
	                while ((bytesRead = inputStream.read(buffer)) != -1) {
	                    outputStream.write(buffer, 0, bytesRead);
	                }
	            }
	            
	            String fileUrl = "/chFile/Homework/" +idntf_no +"."+ file_extn_nm ;

	            // 파일 객체 생성 및 반환
	            File_Group uploadFile = new File_Group(); // Filegroup 클래스 생성
	            uploadFile.setIdntf_no(idntf_no);
	            uploadFile.setFile_nm(file_nm);
	            uploadFile.setFile_extn_nm(file_extn_nm);
	            uploadFile.setFile_sz(file_sz);
	            uploadFile.setFile_path_nm(fileUrl);

	            return uploadFile; // 업로드된 파일 정보를 반환
	        } else {
	            System.out.println("파일에 확장자가 없습니다.");
	        }
	    } else {
	        System.out.println("업로드된 파일이 없습니다.");
	    }
	    return null; // 파일이 없는 경우 null 반환
	}
	
	
	// NOTE - 파일 다운로드 진행
	@Override
	public File_Group getFile(int fileGroup, int fileSeq) {
		return sd.getFile(fileGroup, fileSeq);
	}
	
	
	// NOTE - 파일 리스트 가져오기
	@Override
	public List<File_Group> getFilesByGroup(int file_group) {
		return sd.getFilesByGroup(file_group);
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
	
	@Override
	public List<Note> getNotesReceived(Map<String, Object> params) {
		List<Note> noteList = sd.getNotesReceived(params);
		return noteList;
	}


	@Override
	public int countNote(Map<String, Object> params) {

		int total = sd.countNote(params);

		return total;
	}

	@Override
	public List<Note> getNotesSend(Map<String, Object> params) {
		List<Note> noteList = sd.getNotesSend(params);
		return noteList;
	}

	
	// NOTE - 쪽지 상세 
	@Override
	public Note getNote(int note_sn) {
		Note note = sd.getNote(note_sn);
		
		return note;
	}

	@Override
	public int createNote(Note note) {
		
		int result = sd.createNote(note);
		return result;
	}

	@Override
	public List<Lecture> getMyLectures(int user_seq) {
		List<Lecture> lectures = sd.getMyLectures(user_seq);
		return lectures;
	}

	@Override

	public List<Note> getSameLeceture(Map<String, Object> params) {
		 List<Note> note = sd.getSameLeceture(params);
		return note;
	}

	
	// NOTE - 문의사항 작성
	@Override
	public int postAsks(Ask ask) {
		int result = sd.postAsk(ask);
		return result;
	}

	
	// NOTE - 문의사항 목록(마이페이지)
	@Override
	public List<Ask> getAsksMy(Map<String, Object> params) {
		List<Ask> ask = sd.getAsksMy(params);
		return ask;
	}

	// NOTE - 문의사항 상세
	@Override
	public Ask getAsk(int dscsn_sn) {
		Ask ask = sd.getAsk(dscsn_sn);
		return ask;
	}

	@Override
	public int getNoteSendTotal(Map<String, Object> params) {
		
		return sd.getNoteSendTotal(params);
	}

	@Override
	public int getNoteRcvrTotal(Map<String, Object> params) {
		
		return sd.getNoteRcvrTotal(params);
	}

	@Override
	public int updateReceiveDate(int note_sn) {
		
		return sd.updateReceiveDate(note_sn);
	}

	@Override
	public int replyUpdateAsks(Ask ask) {
		
		return sd.replyUpdateAsks(ask);
	}

	@Override
	public List<Ask> getAsks(Map<String,Object> params) {
		
		return sd.getAsks(params);
	}

	@Override
	public int countAsk(Map<String, Object> params) {
	
		return sd.countAsk(params);
	}

	@Override
	public int countAskMy(Map<String, Object> params) {
		return sd.countAskMy(params);
		}

	@Override
	public int updateNoticeYn(Notice notice) {
		
		return sd.updateNoticeYn(notice);
	}

	@Override
	public int updateNoteRcvrDelYn(Note note) {
		
		return sd.updateNoteRcvrDelYn(note);
	}

	@Override
	public int updateNoteSentDelYn(Note note) {
		return sd.updateNoteSentDelYn(note);
	}

	@Override
	public int countNoticeAll(Map<String, Object> params) {
		return sd.countNoticeAll(params);
	}

	@Override
	public List<Notice> selectNoticeListAll(Map<String, Object> params) {
		return sd.selectNoticeListAll(params);
	}



	




}