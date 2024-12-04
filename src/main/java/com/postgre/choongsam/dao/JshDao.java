package com.postgre.choongsam.dao;

import java.util.List;

import com.postgre.choongsam.dto.Class_Bookmark;
import com.postgre.choongsam.dto.Class_Schedule;
import com.postgre.choongsam.dto.Class_ScheduleAddVideo;

public interface JshDao {

	List<Class_ScheduleAddVideo> studentLecture(String lctr_id, int user_seq);

	List<Class_ScheduleAddVideo> getStartDay(String lctr_id);

	int contsFileUpload(Class_ScheduleAddVideo info);

	int lectureVideoUpload(Class_ScheduleAddVideo info, String update);

	int fileLectureVideoUpload(Class_ScheduleAddVideo info, String update);

	int syllabusUpload(Class_ScheduleAddVideo info, String update);

	int chpTimeUpload(Class_ScheduleAddVideo info, String update);

	int searchSche(String chashi, String conts_id, String user_seq);

	int insertSche(String chashi, String conts_id, String lctr_id, String user_seq);

	List<Class_ScheduleAddVideo> searchTeachConts(String lctr_id, int user_seq);

	List<Class_ScheduleAddVideo> LectureName(String lctr_id);

	List<Class_Schedule> classSchedule(String lctr_id, int user_seq);

	List<Class_ScheduleAddVideo> getcontsInfo(String conts_id);

	List<Class_Bookmark> getcontsChp(String conts_id);

}