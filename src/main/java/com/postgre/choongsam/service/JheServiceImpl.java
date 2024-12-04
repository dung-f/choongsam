package com.postgre.choongsam.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.postgre.choongsam.dao.JheDao;
import com.postgre.choongsam.dto.Attendance_Check;
import com.postgre.choongsam.dto.File_Group;
import com.postgre.choongsam.dto.Grade;
import com.postgre.choongsam.dto.Homework;
import com.postgre.choongsam.dto.Homework_Submission;
import com.postgre.choongsam.dto.Lecture;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JheServiceImpl implements JheService {

	@Autowired
	private final JheDao hed;

	@Autowired
	private final SqlSession session;

	@Override
	public List<Lecture> getLectureHomeworkList(int user_seq) {
		System.out.println("강사별 강의 리스트 서비스");
		List<Lecture> lectureHomeworkList = hed.getLectureHomeworkList(user_seq);
		return lectureHomeworkList;
	}

	@Override
	public List<Homework> getProfHomeworkList(String lctr_id) {
		System.out.println("강사 강의 리스트 서비스");
		List<Homework> profHomeworkList = hed.getProfHomeworkList(lctr_id);
		upAsmtStatus(profHomeworkList);
		return profHomeworkList;
	}

	private void upAsmtStatus(List<Homework> homeworkList) {
		LocalDate currentDate = LocalDate.now();

		for (Homework homework : homeworkList) {
			 LocalDate startDate = LocalDate.parse(homework.getSbmsn_bgng_ymd(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			 LocalDate endDate = LocalDate.parse(homework.getSbmsn_end_ymd(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));

			if (currentDate.isBefore(startDate)) {
					homework.setAsmtStatus("미등록");
			} else if (currentDate.isAfter(endDate)) {
				homework.setAsmtStatus("종료");
			} else {
				homework.setAsmtStatus("진행중");
			}

			int submissionRate = getSubmissionRate(homework.getLctr_id(), homework.getAsmt_no());
			homework.setSubmissionRate(submissionRate);
			System.out.println("submissionRate: " + submissionRate);
		}
	}

	private int getSubmissionRate(String lctr_id, int asmt_no) {
		int totalStudents = hed.getTotStudInCourse(lctr_id);
		System.out.println("getSubmissionRate lctr_id: " + lctr_id);
		System.out.println("totalStudents: " + totalStudents);
		System.out.println("getSubmissionRate asmt_no: " + asmt_no);
		int submittedStudents = hed.getSubmittedStuds(asmt_no);
		return (totalStudents == 0) ? 0 : (submittedStudents * 100) / totalStudents;
	}

	@Override
	public List<Homework> getStudSubmitList(String lctr_id) {
		List<Homework> studSubmitList = hed.getStudSubmitList(lctr_id);
		return studSubmitList;
	}

	@Override
	public Lecture findByLCTR(String lctr_id) {
		System.out.println("강의 아이디 찾기 서비스");
		Lecture findByLCTR = hed.findByLCTR(lctr_id);
		return findByLCTR;
	}

	@Override
	@Transactional
	public int insertHomework(Homework homework, MultipartFile[] files, HttpServletRequest request) {
		System.out.println("과제 등록 서비스");

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

		// 과제 정보 저장
		int insHWList = hed.insertHomework(homework, uploadFiles);
		return insHWList;
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

				InputStream inputStream = file.getInputStream();

				// 파일이 저장될 경로
				String uploadPath = request.getSession().getServletContext().getRealPath("/chFile/Homework");

				// 경로가 없으면 생성
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) {
					boolean dirCreated = uploadDir.mkdirs(); // 디렉토리 생성
					if (!dirCreated) {
						throw new IOException("업로드 디렉토리를 생성할 수 없습니다: " + uploadPath);
					}
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

	@Override
	public Homework findById(int asmt_no) {
		System.out.println("수정할 과제 불러오는 서비스");
		Homework findByASMT = hed.findById(asmt_no);
		return findByASMT;
	}

	@Override
	@Transactional
	public int updateHomework(Homework homework , MultipartFile file, HttpServletRequest request) {
		System.out.println("과제 수정 서비스");

		// 기존 파일 삭제 처리 (옵션 체크)
		if ("true".equals(request.getParameter("deleteFile"))) {
			System.out.println("삭제할 파일 그룹: " + homework.getFile_group());
			if (homework.getFile_group() != 0) {
				File_Group fileGroup = hed.getFileByGroup(homework.getFile_group());
				System.out.println("deleteFile 파라미터 값: " + request.getParameter("deleteFile"));

				// 기존 파일이 있으면 삭제
				if (fileGroup != null) {
					System.out.println("기존 파일 경로: " + fileGroup.getFile_path_nm());
					String filePath = request.getSession().getServletContext().getRealPath(fileGroup.getFile_path_nm());
					File oldFile = new File(filePath);

					if (oldFile.exists() && oldFile.delete()) {
						System.out.println("기존 파일이 삭제되었습니다.");
					} else {
						System.out.println("기존 파일 삭제에 실패했습니다.");
					}

					int delFile = hed.deletefile(homework.getFile_group());
					if (delFile > 0) {
						System.out.println("파일 그룹이 DB에서 삭제되었습니다.");
					} else {
						System.out.println("파일 그룹 삭제에 실패했습니다.");
					}
				}
			} else {
				System.out.println("삭제할 파일이 없습니다. (file_group == 0)");
			}
			homework.setFile_group(0);
		}

		// 파일이 업로드된 경우 새 파일 업로드
		if (file != null && !file.isEmpty()) {
			// 새 파일 업로드 처리
			File_Group uploadedFile = null;
			try {
				uploadedFile = uploadFile(file, request);
			} catch (IOException e) {
				e.printStackTrace();
			}

			if (uploadedFile != null) {
				// 새 파일의 file_group을 과제에 설정
				int newFileGroupId = hed.newFileGroup();
				System.out.println("newFileGroupId: " + newFileGroupId);
				uploadedFile.setFile_group(newFileGroupId);
	
				// file_seq 설정
				int fileSeq = hed.newFileSeq(newFileGroupId);
				System.out.println("fileSeq: " + fileSeq);
				uploadedFile.setFile_seq(fileSeq);
	
				// 새 파일의 file_group을 과제에 설정
	
				// 파일 정보 저장
				int fileResult = session.insert("com.postgre.choongsam.dto.jheMapper.fileUpload", uploadedFile);
				if (fileResult <= 0) {
					System.out.println("파일 업로드 실패");
				}
				homework.setFile_group(newFileGroupId);
			}
		}

		int upHomeworkList = hed.updateHomework(homework);
		return upHomeworkList;
	}

	private void deleteHomework(int asmt_no) {
		System.out.println("과제 삭제 서비스");
		hed.deleteHomeworkSubmission(asmt_no);
		hed.deleteHomework(asmt_no);
	}

	@Override
	public void deleteHomeworkList(List<Integer> delCheck) {
		System.out.println("과제 삭제리스트 서비스");
		for (Integer asmt_no : delCheck) {
			hed.deleteHomeworkSubmission(asmt_no);
			deleteHomework(asmt_no);
		}
	}

	@Override
	public List<Homework> getStudHomeworkList(int user_seq) {
		System.out.println("학생 강의 리스트 서비스");
		List<Homework> studHomeworkList = hed.getStudHomeworkList(user_seq);
		upAsmtStatus(studHomeworkList);
		return studHomeworkList;
	}

	@Override
	public void notifyStudents(String lctr_id) {
		System.out.println("강사가 등록한 과제 학생에게 등록 서비스");
		List<Homework> studHomeworkList = hed.notifyStudents(lctr_id);
		for (Homework homework : studHomeworkList) {
			int userSeq = homework.getUser_seq();
			int latestAsmtNo = homework.getAsmt_no();
			System.out.println("userSeq: " + userSeq);
			System.out.println("latestAsmtNo: " + latestAsmtNo);
			Homework_Submission submission = new Homework_Submission();
			submission.setUser_seq(userSeq);
			submission.setAsmt_no(latestAsmtNo);
			hed.insSubmission(submission);
		}
	}

	@Override
	public int updatesubmitHomework(int user_seq, int asmt_no, MultipartFile file, HttpServletRequest request) {
		System.out.println("학생 과제 제출 수정 서비스");

		File_Group uploadedFile = null;
		try {
			uploadedFile = uploadFile(file, request);
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (uploadedFile != null) {
			int fileGroupId = hed.newFileGroup();
			saveFiles(Collections.singletonList(uploadedFile), fileGroupId);
			uploadedFile.setFile_group(fileGroupId);
		}
		
		Homework_Submission homework_Submission = new Homework_Submission();
		String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		homework_Submission.setUser_seq(user_seq);
		homework_Submission.setAsmt_no(asmt_no);
		homework_Submission.setSbmsn_yn("Y");
		homework_Submission.setSbmsn_ymd(today);
		homework_Submission.setAsmt_scr(10);

		if (uploadedFile != null) {
			homework_Submission.setFile_group(uploadedFile.getFile_group());
		} else {
			homework_Submission.setFile_group(0);
		}
		System.out.println("Sbmsn_yn: " + homework_Submission.getSbmsn_yn());
		int upSubmitHomework = hed.updatesubmitHomework(homework_Submission);
		return upSubmitHomework;
	}

	private int saveFiles(List<File_Group> uploadFiles, int fileGroupId) {
		int result = 0;
		for (File_Group fileUpload : uploadFiles) {
			int fileSeq = hed.newFileSeq(fileGroupId);
			fileUpload.setFile_group(fileGroupId);
			fileUpload.setFile_seq(fileSeq);

			result = session.insert("com.postgre.choongsam.dto.jheMapper.fileUpload", fileUpload);
			if (result > 0) {
				System.out.println("파일 업로드 성공");
			} else {
				System.out.println("파일 업로드 실패");
				break;
			}
		}
		return result;
	}

	@Override
	public List<Lecture> getProfLectureInfo(String lctr_id) {
		System.out.println("강의 메인보드 서비스");
		List<Lecture> profLectureInfo = hed.getProfLectureInfo(lctr_id);
		return profLectureInfo;
	}

	@Override
	public List<Attendance_Check> profAttMain(String lctr_id) {
		System.out.println("강사 출석 메인보드 서비스");
		List<Attendance_Check> profAttMainList = hed.profAttMain(lctr_id);
		return profAttMainList;
	}

	@Override
	public List<Attendance_Check> getStudAtt(String lctr_id, int lctr_no) {
		System.out.println("차시별 수강생 출석 호출 서비스");
		List<Attendance_Check> getStudAttList = hed.getStudAtt(lctr_id, lctr_no);
		return getStudAttList;
	}

	@Override
	public List<Attendance_Check> getOnlineStudAtt(String lctr_id) {
		System.out.println("차시별 온라인 수강생 출석 호출 서비스");
		List<Attendance_Check> onlineStudAttList = hed.getOnlineStudAtt(lctr_id);

		for (Attendance_Check attendance : onlineStudAttList) {
			updateStudAtt(attendance.getLctr_id(), attendance.getLctr_no(),
						  Arrays.asList(attendance.getUser_seq()),
						  Map.of("att_status_" + attendance.getUser_seq(), String.valueOf(attendance.getAtt_status())),
						  7002);
		}
		return onlineStudAttList;
	}

	@Override
	public void updateStudAtt(String lctr_id, int lctr_no,
							  List<Integer> user_seq, Map<String, String> att_status, int onoff) {
		System.out.println("출석 update 서비스");

//		LocalDate today = LocalDate.now();

		for (int i = 0; i < user_seq.size(); i++) {
			Integer userSeq = user_seq.get(i);
			String  attStatus = att_status.get("att_status_" + userSeq);

			if (attStatus != null) {
				int attStatusValue = Integer.parseInt(attStatus);
				Attendance_Check attendance_Check = new Attendance_Check();
				attendance_Check.setLctr_id(lctr_id);
				attendance_Check.setLctr_no(lctr_no);
				attendance_Check.setUser_seq(userSeq);
				attendance_Check.setAtt_status(attStatusValue);

				if (onoff == 7001) {
					hed.updateStudAtt(attendance_Check);
				} else if (onoff == 7002) {
//					LocalDate viewingPeriod = hed.getViewingPeriod(lctr_id, lctr_no);
//					if (viewingPeriod != null && viewingPeriod.isBefore(today)) {
//						attendance_Check.setAtt_status(5003);
//					}
					hed.upStudOnlineAtt(attendance_Check);
				}
			}
		}
	}

	@Override
	public List<Lecture> studLecture(int user_seq) {
		System.out.println("학생 강의 리스트");
		List<Lecture> studLectureList = hed.studLecture(user_seq);
		return studLectureList;
	}

	@Override
	public List<Lecture> studLectureMain(String lctr_id) {
		System.out.println("학생 강의 메인보드 서비스");
		List<Lecture> studLectureMainList = hed.studLectureMain(lctr_id);
		return studLectureMainList;
	}

	@Override
	public List<Attendance_Check> studAtt(String lctr_id, int user_seq) {
		System.out.println("학생 출석 메인보드 서비스");
		Attendance_Check attendance_Check = new Attendance_Check();
		attendance_Check.setLctr_id(lctr_id);
		attendance_Check.setUser_seq(user_seq);
		List<Attendance_Check> studAttList = hed.studAtt(attendance_Check);
		return studAttList;
	}

	@Override
	public List<Attendance_Check> profAttDetail(String lctr_id, int lctr_no) {
		System.out.println("강사 차시별 수강생 출결 현황 서비스");
		Attendance_Check attendance_Check = new Attendance_Check();
		attendance_Check.setLctr_id(lctr_id);
		attendance_Check.setLctr_no(lctr_no);
		List<Attendance_Check> profAttDetailList = hed.profAttDetail(attendance_Check);
		return profAttDetailList;
	}

	@Override
	public List<Grade> profGrade(String lctr_id, int user_seq) {
		System.out.println("강사 수강생 성적 조회 서비스");

		int lctrState = hed.getLctrState(lctr_id);
		List<Grade> allGrades = new ArrayList<>();

			List<Integer> userSeqList = hed.studUserSeq(lctr_id);
			for (Integer userSeq : userSeqList) {
				if (lctrState == 4007) {
					Grade grade = new Grade();
					grade.setLctr_id(lctr_id);
					grade.setUser_seq(userSeq);
					Grade existingGrade = hed.selectGrade(grade);

					if (existingGrade == null) {
						insertGrade(lctr_id, userSeq);
					}
					List<Grade> studScoresList = hed.profGrade(grade);
					allGrades.addAll(studScoresList);
					System.out.println("service studScoresList: " + studScoresList);
				}
			}
		return allGrades;
		}

	private void insertGrade(String lctr_id, Integer userSeq) {
		System.out.println("강사 수강생 성적 등록 서비스");

		String evalCriteria = hed.getEvalCriteria(lctr_id);
		int attWeight = extractAttWeight(evalCriteria);
		int asmtWeight = extractAsmtWeight(evalCriteria);

		Attendance_Check attendance_Check = new Attendance_Check();
		attendance_Check.setLctr_id(lctr_id);
		attendance_Check.setUser_seq(userSeq);
		List<Attendance_Check> studAtt = hed.studAttList(attendance_Check);

		Homework_Submission homework_Submission = new Homework_Submission();
		homework_Submission.setLctr_id(lctr_id);
		homework_Submission.setUser_seq(userSeq);
		List<Homework_Submission> studHomework = hed.StudHomework(homework_Submission);

		if (studAtt != null && studHomework != null) {
			int attScore = calculateAttScore(studAtt, lctr_id);
			int asmtScore = calculateAsmtScore(studHomework, lctr_id);
			int lastScore = calculateLastScore(attScore, asmtScore, attWeight, asmtWeight);

			String finishYn = lastScore >= 70 ? "Y" : "N";

			Grade grade = new Grade();
			grade.setUser_seq(userSeq);
			grade.setLctr_id(lctr_id);
			grade.setAtndc_scr(attScore);
			grade.setAsmt_scr(asmtScore);
			grade.setLast_scr(lastScore);
			grade.setFnsh_yn(finishYn);

			hed.insertGrade(grade);
		}
	}

	private int calculateAttScore(List<Attendance_Check> studentAttendance, String lctr_id) {
		int totalAttScore = 0;
		int totalClasses = hed.getLctrCntschd(lctr_id);

		if (totalClasses == 0) {
			return 0;
		}

		int maxScorePerClass = 100 / totalClasses;
		int attScorePerClass = maxScorePerClass;
		int lateScorePerClass = maxScorePerClass / 2;
		int absentScorePerClass = 0;

		for (Attendance_Check attendance : studentAttendance) {
			switch (attendance.getAtt_status()) {
				case 5001:
					totalAttScore += attScorePerClass;
					break;
				case 5002:
					totalAttScore += lateScorePerClass;
					break;
				case 5003:
					totalAttScore += absentScorePerClass;
					break;
			}
		}
		 return Math.max(totalAttScore, 0);
	}

	private int calculateAsmtScore(List<Homework_Submission> studentHomework, String lctr_id) {
		int totalAsmtScore = 0;
		int totalAsmt = hed.getTotalAsmts(lctr_id);

		if (totalAsmt == 0) {
			return 0;
		}

		int maxScrPerAsmt = 100 / totalAsmt;
		int submittedAsmt = 0;
		for (Homework_Submission homework : studentHomework) {
			if (homework.getAsmt_scr() > 0) {
				submittedAsmt++;
			}
		}

		int missingAsmt = totalAsmt - submittedAsmt;
		int totalPenalty = missingAsmt * maxScrPerAsmt;
		totalAsmtScore = 100 - totalPenalty;
		return Math.max(totalAsmtScore, 0);
	}

	private int extractAttWeight(String evalCriteria) {
		return Integer.parseInt(evalCriteria.trim());
	}

	private int extractAsmtWeight(String evalCriteria) {
		int attendanceWeight = Integer.parseInt(evalCriteria.trim());
		return 100 - attendanceWeight;
	}

	private int calculateLastScore(int attScore, int asmtScore, int attWeight, int asmtWeight) {
		return (attScore * attWeight / 100) + (asmtScore * asmtWeight / 100);
	}

	@Override
	public Grade getupdateGrade(Integer userSeq, String lctr_id) {
		System.out.println("수강생 성적 수정할 정보 찾기 서비스");
		Grade grade = new Grade();
		grade.setUser_seq(userSeq);
		grade.setLctr_id(lctr_id);
		return hed.getupdateGrade(grade);
	}

	@Override
	public void updateGrade(Integer userSeq, String lctr_id, int atndcScr, int asmtScr, int lastScr) {
		System.out.println("수강생 성적 수정할 정보 찾기 서비스");
		Grade grade = new Grade();
		grade.setUser_seq(userSeq);
		grade.setLctr_id(lctr_id);
		grade.setAtndc_scr(atndcScr);
		grade.setAsmt_scr(asmtScr);
		grade.setLast_scr(lastScr);
		hed.getupdateGrade(grade);
	}

	@Override
	public List<Grade> studGrade(String lctr_id, int user_seq) {
		System.out.println("수강생 내 성적 조회 서비스");
		Grade grade = new Grade();
		grade.setLctr_id(lctr_id);
		grade.setUser_seq(user_seq);
		List<Grade> myGradeDetailList = hed.studGrade(grade);
		return myGradeDetailList;
	}

	@Override
	public List<Grade> studGradeDetail(String lctr_id, int user_seq) {
		System.out.println("수강생 내 성적 상세 조회 서비스");
		Grade grade = new Grade();
		grade.setLctr_id(lctr_id);
		grade.setUser_seq(user_seq);
		List<Grade> myGradeDetailList = hed.studGradeDetail(grade);
		return myGradeDetailList;
	}

	@Override
	public Homework checkHomework(int asmt_no, int user_seq) {
		System.out.println("checkHomework 서비스");
		Homework homework = new Homework();
		homework.setAsmt_no(asmt_no);
		homework.setUser_seq(user_seq);
		Homework checkHomeworkList = hed.checkHomework(homework);
		return checkHomeworkList;
	}
}
