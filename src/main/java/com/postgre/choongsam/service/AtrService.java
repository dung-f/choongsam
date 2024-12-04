package com.postgre.choongsam.service;

import java.util.List;

import com.postgre.choongsam.dto.Classroom;
import com.postgre.choongsam.dto.Lecture;
import com.postgre.choongsam.dto.Syllabus;

public interface AtrService {

	String registerCourse(Lecture lecture);

	void registerSyllabus(String courseDetail, String parameter, int i);

	List<Lecture> getAllLectureList();

	Lecture getLectureDetail(String lctr_id);

	

	boolean overlapCheck(String schd, String lctr_id);

	void addClassRoom(String parameter, String parameter2, String parameter3);

	List<Classroom> getAllClassRoom();

	void approveCourse(String parameter);

	List<Lecture> getRecruitLectureList();

	void applyCourse(String parameter, String parameter2);

	List<Syllabus> getSyllabus(String lctr_id);

	void changeLectureState(String parameter, String parameter2);


}
