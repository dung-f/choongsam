package com.postgre.choongsam.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.postgre.choongsam.dto.Attendance_Check;
import com.postgre.choongsam.dto.File_Group;
import com.postgre.choongsam.dto.Grade;
import com.postgre.choongsam.dto.Homework;
import com.postgre.choongsam.dto.Homework_Submission;
import com.postgre.choongsam.dto.Lecture;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class JheDaoImpl implements JheDao {

	@Autowired
	private final SqlSession session;

	@Override
	public List<Lecture> getLectureHomeworkList(int user_seq) {
		System.out.println("강사별 강의 과제 리스트 와따오");
		List<Lecture> lectureHomeworkList = null;
		try {
			lectureHomeworkList = session.selectList("getLectureHomeworkList", user_seq);
		} catch (Exception e) {
			System.out.println("getLectureHomeworkList error: " + e.getMessage());
		}
		return lectureHomeworkList;
	}

	@Override
	public List<Lecture> getProfLectureInfo(String lctr_id) {
		System.out.println("강의 메인보드 다오");
		List<Lecture> profLectureInfo = null;
		try {
			profLectureInfo = session.selectList("profLectureInfo", lctr_id);
			System.out.println("강의 메인보드 profLectureInfo: " + profLectureInfo);
		} catch (Exception e) {
			System.out.println("getProfLectureInfo error: " + e.getMessage());
		}
		return profLectureInfo;
	}

	@Override
	public List<Homework> getProfHomeworkList(String lctr_id) {
		System.out.println("강사 강의별 과제 리스트 와따오");
		List<Homework> profHomeworkList = null;
		try {
			profHomeworkList = session.selectList("getProfHomework", lctr_id);
			System.out.println("다오 LCTR_ID: " + lctr_id);
		} catch (Exception e) {
			System.out.println("getProfHomeworkList error: " + e.getMessage());
			System.out.println("다오 LCTR_ID: " + lctr_id);
			System.out.println("다오 profHomeworkList: " + profHomeworkList);
			e.printStackTrace();
		}
		return profHomeworkList;
	}

	@Override
	public Lecture findByLCTR(String lctr_id) {
		System.out.println("강사 강의 아이디 가지러 와따오");
		Lecture findByLCTR = null;
		try {
			findByLCTR = session.selectOne("findByLCTR", lctr_id);
			System.out.println("findByLCTR: " + findByLCTR);
		} catch (Exception e) {
			System.out.println("findByLCTR error: " + e.getMessage());
		}
		return findByLCTR;
	}

	@Override
	@Transactional
	public int insertHomework(Homework homework, List<File_Group> uploadFiles) {
	    // 파일 그룹 ID 생성
	    int fileGroupId = newFileGroup();

	    // 파일 정보가 있다면 저장
	    if (uploadFiles != null && !uploadFiles.isEmpty()) {
	        int fileResult = saveFiles(uploadFiles, fileGroupId); // 파일 저장 메소드 호출
	        if (fileResult <= 0) {
	            System.out.println("파일 업로드 실패");
	        }
	        homework.setFile_group(fileGroupId); // Homework 객체에 file_group 설정
	    }

	    System.out.println("과제등록 와따오");
	    int insHWList = 0;
	    try {
	        insHWList = session.insert("insertHomework", homework);
	        System.out.println("homework: " + homework);
	        System.out.println("insHWList: " + insHWList);
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("insertHomework error: " + e.getMessage());
	    }
	    return insHWList;
	}

	private int saveFiles(List<File_Group> uploadFiles, int fileGroupId) {
	    int result = 0;
	    for (File_Group fileUpload : uploadFiles) {
	        int fileSeq = newFileSeq(fileGroupId);

	        fileUpload.setFile_group(fileGroupId); // 파일 그룹 ID 설정
	        fileUpload.setFile_seq(fileSeq); // 파일 시퀀스 설정
	        System.out.println("filegroup ------ > " + fileUpload);

	        result = session.insert("com.postgre.choongsam.dto.jheMapper.fileUpload", fileUpload);
	        if (result > 0) {
	            System.out.println("파일 업로드 성공");
	        } else {
	            System.out.println("파일 업로드 실패");
	            break; // 실패 시 더 이상 진행하지 않음
	        }
	    }
	    return result;
	}

	@Override
	public int newFileGroup() {
		System.out.println("newFileGroup");
		return session.selectOne("com.postgre.choongsam.dto.jheMapper.getNextFileGroupId");
	}

	@Override
	public int newFileSeq(int fileGroupId) {
		System.out.println("newFileSeq");
		// file_seq는 파일 그룹에 대해 최대값을 가져오는 방법
		Integer maxFileSeq = session.selectOne("com.postgre.choongsam.dto.jheMapper.getMaxFileSeq", fileGroupId);
		return (maxFileSeq == null) ? 1 : maxFileSeq + 1; // maxFileSeq가 null이면 1을 반환
	}

	@Override
	public Homework findById(int asmt_no) {
		System.out.println("과제 수정 이따오");
		Homework findByASMT = null;
		try {
			findByASMT = session.selectOne("findById", asmt_no);
			System.out.println("findById 다오 asmt_no: " + asmt_no);
			System.out.println("findByASMT: " + findByASMT);
		} catch (Exception e) {
			System.out.println("findById error: " + e.getMessage());
		}
		return findByASMT;
	}

	@Override
	public File_Group getFileByGroup(int file_group) {
		System.out.println("과제에 등록된 파일그룹 다오");
		return session.selectOne("getFileGroup", file_group);
	}

	@Override
	public int deletefile(int file_group) {
		System.out.println("과제에 기존에 등록된 파일그룹 다오");
		return session.delete("deletefile", file_group);
	}

	@Override
	public int updateHomework(Homework homework) {
		System.out.println("과제 수정 해따오");
		int upHomeworkList = 0;
		try {
			upHomeworkList = session.update("updateHomework", homework);
		} catch (Exception e) {
			System.out.println("updateHomework error: " + e.getMessage());
		}
		return upHomeworkList;
	}

	@Override
	public void deleteHomeworkSubmission(int asmt_no) {
		System.out.println("학생에게 준 과제 삭제하러 와따오");
		session.delete("delHomeworkSubmission", asmt_no);
	}

	@Override
	public void deleteHomework(int asmt_no) {
		System.out.println("과제삭제 와따오");
		session.delete("delHomework", asmt_no);
	}

	public void deleteHomeworkList(List<Integer> asmtNoList) {
		System.out.println("과제삭제 리스트여따오");
		for (Integer asmt_no : asmtNoList) {
			deleteHomeworkSubmission(asmt_no);
			deleteHomework(asmt_no);
		}
	}

	@Override
	public List<Homework> getStudHomeworkList(int user_seq) {
		System.out.println("학생 강의별 과제 리스트 와따오");
		List<Homework> studHomeworkList = null;
		try {
			studHomeworkList = session.selectList("getStudHomeworkList", user_seq);
		} catch (Exception e) {
			System.out.println("getStudHomeworkList error: " + e.getMessage());
		}
		return studHomeworkList;
	}

	@Override
	public List<Homework> notifyStudents(String lctr_id) {
		System.out.println("과제 줄 학생 찾으러 와따오");
		System.out.println("notifyStudents lctr_ID: " + lctr_id);
		return session.selectList("notifyStudents", lctr_id);
	}

	@Override
	public int insSubmission(Homework_Submission homework_Submission) {
		System.out.println("등록된 과제 학생에게 주러 와따오");
		System.out.println("insSubmission homework_Submission : " + homework_Submission);
		return session.insert("insSubmission", homework_Submission);
	}

	@Override
	@Transactional
	public int updatesubmitHomework(Homework_Submission homework_Submission) {
		System.out.println("과제 제출 수정하러 와따오");
		System.out.println("updatesubmitHomework submission : " + homework_Submission);
		int upsubmitHomework = 0;
		try {
			upsubmitHomework = session.update("updatesubmitHomework", homework_Submission);
			System.out.println("updatesubmitHomework success : " + homework_Submission);
		} catch (Exception e) {
			System.out.println("updatesubmitHomework error: " + e.getMessage());
			System.out.println("updatesubmitHomework error : " + homework_Submission);
			e.printStackTrace();
			if (e.getCause() != null) {
	            System.out.println("Cause: " + e.getCause());
	        }
		}
		return upsubmitHomework;
	}

	@Override
	public int getTotStudInCourse(String lctr_id) {
		System.out.println("강의에 등록된 학생 수 구하러 와따오");
		System.out.println("등록된 학생 lctr_id: " + lctr_id);
		int totalStudents = 0;
		try {
			totalStudents = session.selectOne("getTotStudInCourse",lctr_id);
			System.out.println("getTotStudInCourse lctr_id: " + lctr_id);
		} catch (Exception e) {
			System.out.println("getTotStudInCourse error: " + e.getMessage());
		}
		return totalStudents;
	}

	@Override
	public int getSubmittedStuds(int asmt_no) {
		System.out.println("과제 제출한 학생 수 구하러 와따오");
		System.out.println("등록된 학생 ASMT_NO: " + asmt_no);
		int submittedStudents = 0;
		try {
			submittedStudents = session.selectOne("getSubmittedStuds",asmt_no);
			System.out.println("getSubmittedStuds ASMT_NO: " + asmt_no);
		} catch (Exception e) {
			System.out.println("getSubmittedStuds error: " + e.getMessage());
		}
		return submittedStudents;
	}

	@Override
	public List<Homework> getStudSubmitList(String lctr_id) {
		List<Homework> studSubmitList = null;
		try {
			studSubmitList = session.selectList("getStudSubmitList", lctr_id);
		} catch (Exception e) {
			System.out.println("getStudList error: " + e.getMessage());
		}
		return studSubmitList;
	}

	@Override
	public List<Attendance_Check> profAttMain(String lctr_id) {
		System.out.println("강사 출석 메인보드 와따오");
		List<Attendance_Check> profAttMainList = null;
		try {
			profAttMainList = session.selectList("profAttMain", lctr_id);
			System.out.println("다오 profAttMainList: " + profAttMainList);
		} catch (Exception e) {
			System.out.println("profAttMain error: " + e.getMessage());
		}
		return profAttMainList;
	}

	@Override
	public List<Integer> getLctrNoList(String lctr_id) {
		System.out.println("강의 차시 다오");
		List<Integer> lctrNoList = null;
		try {
			lctrNoList = session.selectList("getLctrNoList", lctr_id);
		} catch (Exception e) {
			System.out.println("getLctrNoList error: " + e.getMessage());
		}
		return lctrNoList;
	}

	@Override
	public List<Attendance_Check> getStudAtt(String lctr_id, int lctr_no) {
		System.out.println("오프라인 수강생 출석 부르러 와따오");
		List<Attendance_Check> getStudAttList = null;
		try {
			getStudAttList = session.selectList("getStudAtt", Map.of("LCTR_ID", lctr_id, "LCTR_NO", lctr_no));
			System.out.println("getStudAttList: " + getStudAttList);
		} catch (Exception e) {
			System.out.println("getStudAtt error: " + e.getMessage());
		}
		return getStudAttList;
	}

	@Override
	public List<Attendance_Check> getOnlineStudAtt(String lctr_id) {
		System.out.println("온라인 수강생 출석 부르러 와따오");
		System.out.println("lctr_id: " + lctr_id);
		List<Attendance_Check> onlineStudAttList = null;
		try {
			onlineStudAttList = session.selectList("getOnlineStudAtt", lctr_id);
			System.out.println("onlineStudAttList: " + onlineStudAttList);
		} catch (Exception e) {
			System.out.println("getOnlineStudAtt error: " + e.getMessage());
			System.out.println("onlineStudAttList: " + onlineStudAttList);
		}
		return onlineStudAttList;
	}

	@Override
	public int updateStudAtt(Attendance_Check attendance_Check) {
		System.out.println("오프라인 출석 넣으러 와따오");
		System.out.println("attendance_Check: " + attendance_Check);
		int upStudAtt = 0;
		try {
			upStudAtt = session.insert("updateStudAtt", attendance_Check);
		} catch (Exception e) {
			System.out.println("updateStudAtt error: " + e.getMessage());
		}
		return upStudAtt;
	}

	@Override
	public int upStudOnlineAtt(Attendance_Check attendance_Check) {
		System.out.println("온라인 출석 넣으러 와따오");
		System.out.println("attendance_Check: " + attendance_Check);
		int upStudOnAtt = 0;
		try {
			upStudOnAtt = session.insert("upStudOnlineAtt", attendance_Check);
			System.out.println("upStudOnAtt: " + upStudOnAtt);
		} catch (Exception e) {
			System.out.println("upStudOnlineAtt error: " + e.getMessage());
		}
		return upStudOnAtt;
	}

//	@Override
//	public LocalDate getViewingPeriod(String lctr_id, int lctr_no) {
//		System.out.println("getViewingPeriod 다오");
//		String viewingPeriod = null;
//		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
//		try {
//			viewingPeriod =session.selectOne("getViewingPeriod", Map.of("LCTR_ID", lctr_id, "LCTR_NO", lctr_no));
//		} catch (Exception e) {
//			System.out.println("getViewingPeriod error: " + e.getMessage());
//			System.out.println("다오 viewingPeriod: " + viewingPeriod);
//		}
//		return LocalDate.parse(viewingPeriod, formatter);
//	}

	@Override
	public List<Lecture> studLecture(int user_seq) {
		System.out.println("학생 강의 리스트");
		List<Lecture> studLecture = null;
		try {
			studLecture = session.selectList("studLecture", user_seq);
		} catch (Exception e) {
			System.out.println("studLecture error: " + e.getMessage());
		}
		return studLecture;
	}

	@Override
	public List<Lecture> studLectureMain(String lctr_id) {
		System.out.println("학생 강의 메인보드 다오");
		List<Lecture> studLectureMainList = null;
		try {
			studLectureMainList = session.selectList("studLectureMain", lctr_id);
			System.out.println("강의 메인보드 studLectureMain: " + studLectureMainList);
		} catch (Exception e) {
			System.out.println("getProfLectureInfo error: " + e.getMessage());
		}
		return studLectureMainList;
	}

	@Override
	public List<Attendance_Check> studAtt(Attendance_Check attendance_Check) {
		System.out.println("학생 출석 메인보드 와따오");
		List<Attendance_Check> studAttList = null;
		try {
			studAttList = session.selectList("studAtt", attendance_Check);
		} catch (Exception e) {
			System.out.println("studAtt error: " + e.getMessage());
		}
		return studAttList;
	}

	@Override
	public List<Attendance_Check> profAttDetail(Attendance_Check attendance_Check) {
		System.out.println("강사 차시별 수강생 출결 현황 와따오");
		List<Attendance_Check> profAttDetailList = null;
		try {
			profAttDetailList = session.selectList("profAttDetail", attendance_Check);
		} catch (Exception e) {
			System.out.println("profAttDetail error: " + e.getMessage());
		}
		return profAttDetailList;
	}

	@Override
	public Grade selectGrade(Grade grade) {
		System.out.println("selectGrade 다오");
		try {
			System.out.println("grade 다오: " + grade);
			return session.selectOne("selectGrade", grade);
		} catch (Exception e) {
			System.out.println("studScoresList error: " + e.getMessage());
			return null;
		}
	}

	@Override
	public List<Grade> profGrade(Grade grade) {
		System.out.println("강사 수강생 성적 다오");
		List<Grade> studScoresList = null;
		try {
			studScoresList = session.selectList("studScores", grade);
			System.out.println("grade: " + grade);
			System.out.println("dao studScoresList: " + studScoresList);
		} catch (Exception e) {
			System.out.println("studScoresList error: " + e.getMessage());
		}
		return studScoresList;
	}

	@Override
	public List<Integer> studUserSeq(String lctr_id) {
		System.out.println("강사 수강생 리스트 다오");
		List<Integer> studUserSeqList = null;
		try {
			studUserSeqList = session.selectList("studUserSeqList", lctr_id);
			System.out.println("studUserSeqList: " + studUserSeqList);
		} catch (Exception e) {
			System.out.println("studUserSeqList error: " + e.getMessage());
			System.out.println("lctr_id: " + lctr_id);
		}
		return studUserSeqList;
	}

	@Override
	public List<Attendance_Check> studAttList(Attendance_Check attendance_Check) {
		System.out.println("강사 수강생별 출석점수 리스트 다오");
		List<Attendance_Check> getStudAttList = null;
		try {
			getStudAttList = session.selectList("studAttList", attendance_Check);
		} catch (Exception e) {
			System.out.println("studAttList error: " + e.getMessage());
		}
		return getStudAttList;
	}

	@Override
	public List<Homework_Submission> StudHomework(Homework_Submission homework_Submission) {
		System.out.println("강사 수강생별 과제점수 리스트 다오");
		List<Homework_Submission> StudHomeworkList = null;
		try {
			StudHomeworkList = session.selectList("StudHomework", homework_Submission);
		} catch (Exception e) {
			System.out.println("StudHomework error: " + e.getMessage());
		}
		return StudHomeworkList;
	}

	@Override
	public String getEvalCriteria(String lctr_id) {
		System.out.println("평가 기준 다오");
		String evalCriteria = null;
		try {
			evalCriteria = session.selectOne("getEvalCriteria", lctr_id);
		} catch (Exception e) {
			System.out.println("getEvalCriteria error: " + e.getMessage());
		}
		return evalCriteria;
	}

	@Override
	public int getLctrCntschd(String lctr_id) {
		int LctrCntschd = 0;
		try {
			LctrCntschd = session.selectOne("getLctrCntschd", lctr_id);
		} catch (Exception e) {
			System.out.println("getLctrCntschd error: " + e.getMessage());
		}
		return LctrCntschd;
	}

	@Override
	public int getTotalAsmts(String lctr_id) {
		int totAsmt = 0;
		try {
			totAsmt = session.selectOne("getTotalAsmts", lctr_id);
		} catch (Exception e) {
			System.out.println("getTotalAsmts error: " + e.getMessage());
		}
		return totAsmt;
	}

	@Override
	public int getLctrState(String lctr_id) {
		int lctrState = 0;
		try {
			lctrState = session.selectOne("getLctrState", lctr_id);
			System.out.println("lctrState: " + lctrState);
		} catch (Exception e) {
			System.out.println("getLctrState error: " + e.getMessage());
		}
		return lctrState;
	}

	@Override
	public void insertGrade(Grade grade) {
		System.out.println("강사 수강생 성적 입력 다오");
		try {
			session.insert("insertGrade", grade);
		} catch (Exception e) {
			System.out.println("insertGrade error: " + e.getMessage());
			System.out.println("grade: " + grade);
		}
	}

	@Override
	public Grade getupdateGrade(Grade grade) {
		System.out.println("수강생 성적 수정할 정보 다오");
		Grade updateGradeList = null;
		try {
			updateGradeList = session.selectOne("getupdateGrade", grade);
		} catch (Exception e) {
			System.out.println("getupdateGrade error: " + e.getMessage());
			System.out.println("grade: " + grade);
		}
		return updateGradeList;
	}

	@Override
	public void updateGrade(Grade grade) {
		System.out.println("수강생 성적 수정 다오");
		try {
			session.selectOne("updateGrade", grade);
		} catch (Exception e) {
			System.out.println("updateGrade error: " + e.getMessage());
			System.out.println("grade: " + grade);
		}
	}

	@Override
	public List<Grade> studGrade(Grade grade) {
		System.out.println("수강생 내 성적 다오");
		List<Grade> myGradeList = null;
		try {
			myGradeList = session.selectList("studGrade", grade);
		} catch (Exception e) {
			System.out.println("studGrade error: " + e.getMessage());
		}
		return myGradeList;
	}

	@Override
	public List<Grade> studGradeDetail(Grade grade) {
		System.out.println("수강생 내 성적 상세 다오");
		List<Grade> myGradeDetailList = null;
		try {
			myGradeDetailList = session.selectList("studGradeDetail", grade);
		} catch (Exception e) {
			System.out.println("studGradeDetail error: " + e.getMessage());
		}
		return myGradeDetailList;
	}

	@Override
	public Homework checkHomework(Homework homework) {
		System.out.println("checkHomeworkList 다오");
		Homework checkHomeworkList = null;
		try {
			checkHomeworkList = session.selectOne("checkHomework", homework);
		} catch (Exception e) {
			System.out.println("checkHomework error: " + e.getMessage());
		}
		return checkHomeworkList;
	}
}
