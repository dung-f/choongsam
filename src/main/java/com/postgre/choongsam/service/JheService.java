package com.postgre.choongsam.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.postgre.choongsam.dto.Attendance_Check;
import com.postgre.choongsam.dto.File_Group;
import com.postgre.choongsam.dto.Grade;
import com.postgre.choongsam.dto.Homework;
import com.postgre.choongsam.dto.Lecture;

import jakarta.servlet.http.HttpServletRequest;


public interface JheService {
	List<Lecture>	getLectureHomeworkList(int user_seq);
	List<Lecture>	getProfLectureInfo(String lctr_id);
	List<Homework>	getProfHomeworkList(String lctr_id);
	List<Homework>	getStudSubmitList(String lctr_id);
	Lecture			findByLCTR(String lctr_id);
	File_Group		uploadFile(MultipartFile file, HttpServletRequest request) throws IOException;
	int				insertHomework(Homework homework, MultipartFile[] files, HttpServletRequest request);
	Homework		findById(int asmt_no);
	int				updateHomework(Homework homework, MultipartFile file, HttpServletRequest request);
	void			deleteHomeworkList(List<Integer> delCheck);
	List<Homework>	getStudHomeworkList(int user_seq);
	void			notifyStudents(String lctr_id);
	List<Attendance_Check> profAttMain(String lctr_id);
	List<Attendance_Check> getStudAtt(String lctr_id, int lctr_no);
	List<Attendance_Check> getOnlineStudAtt(String lctr_id);
	int				updatesubmitHomework(int user_seq, int asmt_no, MultipartFile file, HttpServletRequest request);
	void			updateStudAtt(String lctr_id, int lctr_no, List<Integer> user_seq, Map<String, String> att_status, int onoff);
	List<Lecture>	studLecture(int user_seq);
	List<Lecture>	studLectureMain(String lctr_id);
	List<Attendance_Check> studAtt(String lctr_id, int user_seq);
	List<Attendance_Check> profAttDetail(String lctr_id, int lctr_no);
	List<Grade>		profGrade(String lctr_id, int user_seq);
	Grade			getupdateGrade(Integer userSeq, String lctr_id);
	void			updateGrade(Integer userSeq, String lctr_id, int atndcScr, int asmtScr, int lastScr);
	List<Grade>		studGrade(String lctr_id, int user_seq);
	List<Grade>		studGradeDetail(String lctr_id, int user_seq);
	Homework		checkHomework(int asmt_no, int user_seq);
}
