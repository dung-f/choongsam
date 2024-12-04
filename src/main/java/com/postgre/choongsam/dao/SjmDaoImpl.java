package com.postgre.choongsam.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.postgre.choongsam.dto.Ask;
import com.postgre.choongsam.dto.File_Group;
import com.postgre.choongsam.dto.Lecture;
import com.postgre.choongsam.dto.Note;
import com.postgre.choongsam.dto.Notice;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class SjmDaoImpl implements SjmDao {
	private final SqlSession session;

	public List<Notice> selectNoticeList(Map<String, Object> params) {
		List<Notice> noticeList = session.selectList("com.postgre.choongsam.mapper.sjm.selectNoticeList", params);

		System.out.println("SjmDaoImpl selectNoticeList noticeList" + noticeList);

		return noticeList;
	}

	@Override
	public int countNotice(String keyword) {
		System.out.println("다오 도착 ");
		int total = session.selectOne("com.postgre.choongsam.mapper.sjm.countNoticeUser", keyword);

		System.out.println("-------->" + total);

		return total;
	}

	@Override
	public Notice noticeDetail(int ntc_mttr_sn) {

		Notice notice = session.selectOne("com.postgre.choongsam.mapper.sjm.noticeDetail", ntc_mttr_sn);

		System.out.println("SjmDaoImpl.noticeDetail() notice >>" + notice);
		return notice;
	}

	// NOTE - 공지사항 작성
	@Override
	public int noticeCreate(Notice notice, List<File_Group> uploadFiles) {
		System.out.println("공지사항 작성");

		
		// 파일 그룹 ID 생성
		int fileGroupId = createNewFileGroupId();

		// 공지사항 먼저 저장

		// 파일 정보가 있다면 저장
		if (uploadFiles != null && !uploadFiles.isEmpty()) {
			for (File_Group fileUpload : uploadFiles) { // Filegroup 객체를 순회

				int fileSeq = createNewFileSeq(fileGroupId);

				fileUpload.setFile_group(fileGroupId); // 파일 그룹 ID 설정
				fileUpload.setFile_seq(fileSeq); // 파일 시퀀스 설정
				System.out.println("filegroup ------ > " + fileUpload);
				int fileResult = session.insert("com.postgre.choongsam.mapper.sjm.FileUpload", fileUpload);
				System.out.println("파일 업로드 임 ㅋ");
				notice.setFile_group(fileGroupId);
				if (fileResult <= 0) {
					// 파일 업로드 실패 처리
					System.out.println("파일 업로드 실패");
				}
			}
		}
		
		int noticeId = (Integer) notice.getNtc_mttr_sn();
		
		int result = 0;
		
		if(noticeId > 0) {
			result = session.update("com.postgre.choongsam.mapper.sjm.noticeUpdate",notice);
		}else {
			result = session.insert("com.postgre.choongsam.mapper.sjm.noticeCreate", notice);			
		}


		System.out.println("공지사항 업로드 result ---> " + result);
		return result;

	}

	private int createNewFileGroupId() {
		return session.selectOne("com.postgre.choongsam.mapper.sjm.getNextFileGroupId");
	}

	private int createNewFileSeq(int fileGroupId) {
		// file_seq는 파일 그룹에 대해 최대값을 가져오는 방법
		Integer maxFileSeq = session.selectOne("com.postgre.choongsam.mapper.sjm.getMaxFileSeq", fileGroupId);
		return (maxFileSeq == null) ? 1 : maxFileSeq + 1; // maxFileSeq가 null이면 1을 반환
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

		List<Note> noteList = session.selectList("com.postgre.choongsam.mapper.sjm.getNotesReceived", params);

		System.out.println("쪽지 리스트 다오임 " + noteList);
		return noteList;
	}

	// NOTE - 쪽지 갯수(페이징)
	@Override
	public int countNote(Map<String, Object> params) {

		System.out.println("쪽지갯수 다오");

		int total = session.selectOne("com.postgre.choongsam.mapper.sjm.countNote", params);

		System.out.println(total + "이거임");

		return 0;
	}

	@Override
	public List<Note> getNotesSend(Map<String, Object> params) {
		List<Note> noteList = session.selectList("com.postgre.choongsam.mapper.sjm.getNotesSend", params);

		System.out.println("쪽지 리스트 다오임 " + noteList);
		return noteList;
	}

	// NOTE - 쪽지 상세
	@Override
	public Note getNote(int note_sn) {

		Note note = session.selectOne("com.postgre.choongsam.mapper.sjm.getNote", note_sn);
		System.out.println("note ---> " + note);

		return note;
	}

	@Override
	public int createNote(Note note) {
		int result = 0;
		System.out.println("쪽지 작성 다오 시작 ");
		try {
			result = session.insert("com.postgre.choongsam.mapper.sjm.createNote", note);
			System.out.println(result + "이다");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Lecture> getMyLectures(int user_seq) {
		System.out.println("내가 듣는 강의 리스트 가져오기" + user_seq);
		List<Lecture> lectures = null;

		try {
			lectures = session.selectList("com.postgre.choongsam.mapper.sjm.getMyLectures", user_seq);
			System.out.println("내가 듣는 강의 : " + lectures);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lectures;
	}

	@Override
	public List<Note> getSameLeceture(Map<String, Object> params) {
		System.out.println("내가 듣는 강의 리스트 가져오기" + params);
		List<Note> note = null;

		try {
			note = session.selectList("com.postgre.choongsam.mapper.sjm.getSameLeceture", params);
			System.out.println("내가 듣는 강의 : " + note);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return note;
	}

	@Override
	public int postAsk(Ask ask) {

		System.out.println(" 문의사항 작성 다오");

		int result = 0;

		try {
			result = session.insert("com.postgre.choongsam.mapper.sjm.postAsk", ask);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public List<Ask> getAsksMy(Map<String, Object> params) {
		System.out.println("다오시작 문의사항");

		List<Ask> ask = null;
		try {
			System.out.println("시작 parameter-->" + params);
			ask = session.selectList("com.postgre.choongsam.mapper.sjm.getAsksMy", params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (ask != null) {
			System.out.println("리스트를 불러옴 -->" + ask.size());
		}
		return ask;
	}

	// 문의사항 상세
	@Override
	public Ask getAsk(int dscsn_sn) {
		System.out.println("상세 다오 시작");

		Ask ask = null;

		try {
			ask = session.selectOne("com.postgre.choongsam.mapper.sjm.getAsk", dscsn_sn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ask;
	}

	@Override
	public File_Group getFile(int fileGroup, int fileSeq) {
		System.out.println("파일 다운로드 진행");

		File_Group file = null;

		Map<String, Object> params = new HashMap<>();
		params.put("file_group", fileGroup);
		params.put("file_seq", fileSeq);

		try {
			file = session.selectOne("com.postgre.choongsam.mapper.sjm.getFile", params);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return file;
	}

	@Override
	public List<File_Group> getFilesByGroup(int file_group) {
		System.out.println("file 리스트 가져오기");

		List<File_Group> files = null;

		try {
			files = session.selectList("com.postgre.choongsam.mapper.sjm.getFilesByGroup", file_group);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return files;
	}

	@Override
	public int getNoteSendTotal(Map<String, Object> params) {
		System.out.println("params-->" + params);
		System.out.println("센드리스트 다오 시작");
		int total = 0;
		try {
			total = session.selectOne("com.postgre.choongsam.mapper.sjm.getNoteSendTotal", params);
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("total---->" + total);
		return total;
	}

	@Override
	public int getNoteRcvrTotal(Map<String, Object> params) {
		System.out.println("리시브리스트 다오 시작");
		int total = 0;
		try {
			total = session.selectOne("com.postgre.choongsam.mapper.sjm.getNoteRcvrTotal", params);
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("total---->" + total);

		return total;
	}

	@Override
	public int updateReceiveDate(int note_sn) {
		System.out.println("수신자 읽음 처리 다오 시작");
		int result = 0;
		try {
			result = session.update("com.postgre.choongsam.mapper.sjm.updateReceiveDate", note_sn);
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("result---->" + result);

		return result;
	}

	@Override
	public int replyUpdateAsks(Ask ask) {
		System.out.println(" 문의사항 답변작성 다오 시작");
		int result = 0;
		try {
			result = session.update("com.postgre.choongsam.mapper.sjm.replyUpdateAsks", ask);
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("result---->" + result);

		return result;
	}

	@Override
	public List<Ask> getAsks(Map<String, Object> params) {
		System.out.println(" 모든 문의사항 불러오기");
		List<Ask> askList = null;
		System.out.println(" all ask params-->" + params);
		try {
			askList = session.selectList("com.postgre.choongsam.mapper.sjm.getAsks", params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("askss ----> " + askList);
		return askList;
	}

	@Override
	public int countAsk(Map<String, Object> params) {
		System.out.println("모든 쪽지 리스트");

		int result = 0;
		try {
			result = session.selectOne("com.postgre.choongsam.mapper.sjm.countAsk", params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("SjmDaoImpl.countAsk() ===>" + result);
		return result;
	}

	@Override
	public int countAskMy(Map<String, Object> params) {
		System.out.println("countAskMy 쪽지 리스트");

		int result = 0;
		try {
			result = session.selectOne("com.postgre.choongsam.mapper.sjm.countAskMy", params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("SjmDaoImpl.countAskMy() ===>" + result);
		return result;
	}

	@Override
	public int updateNoticeYn(Notice notice) {
		System.out.println("공지사항 노출 여부 다오");

		int result = 0;

		try {
			result = session.update("com.postgre.choongsam.mapper.sjm.updateNoticeYn", notice);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("SjmDaoImpl.countAskMy() ===>" + result);
		return result;
	}

	@Override
	public int updateNoteRcvrDelYn(Note note) {
		System.out.println("받은쪽지 노출 여부 다오");

		int result = 0;

		try {
			result = session.update("com.postgre.choongsam.mapper.sjm.updateNoteRcvrDelYn", note);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("SjmDaoImpl.updateNoteRcvrDelYn() ===>" + result);
		return result;
	}

	@Override
	public int updateNoteSentDelYn(Note note) {
		System.out.println("보낸쪽지 노출 여부 다오");

		int result = 0;

		try {
			result = session.update("com.postgre.choongsam.mapper.sjm.updateNoteSentDelYn", note);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("SjmDaoImpl.updateNoteSentDelYn() ===>" + result);
		return result;
	}

	@Override
	public int countNoticeAll(Map<String, Object> params) {

		System.out.println("카운트 올 다오");
		int result =0;
		System.out.println("params--->" + params);
		try {
			result = session.selectOne("com.postgre.choongsam.mapper.sjm.countNoticeAll", params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("SjmDaoImpl.countNoticeAll() ===>" + result);
		return result;
	}

	@Override
	public List<Notice> selectNoticeListAll(Map<String, Object> params) {
		System.out.println("셀렉트 올 에스크 리스트 ");
		System.out.println("params--->" + params);
		List<Notice> noticeList = new ArrayList<>();
		System.out.println(" all ask params-->" + params);
		try {
			noticeList = session.selectList("com.postgre.choongsam.mapper.sjm.selectNoticeListAll", params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("askss ----> " + noticeList);
		return noticeList;
	}

}
