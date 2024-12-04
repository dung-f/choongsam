package com.postgre.choongsam.service;

import java.util.List;

import com.postgre.choongsam.dto.Class_Bookmark;
import com.postgre.choongsam.dto.Class_Schedule;
import com.postgre.choongsam.dto.Class_ScheduleAddVideo;

public interface JshService {

	List<Class_ScheduleAddVideo> studentLecture(String lctr_id, int user_seq);

	List<Class_ScheduleAddVideo> getStartDay(String lctr_id);

	void contsUpload(Class_ScheduleAddVideo info);

	int classScheChk(String chashi, String conts_id, String lctr_id, String user_seq);

	List<Class_ScheduleAddVideo> searchTeachConts(String lctr_id, int user_seq);

	List<Class_ScheduleAddVideo> LectureName(String lctr_id);

	List<Class_Schedule> classSchedule(String lctr_id, int user_seq);

	List<Class_ScheduleAddVideo> getcontsInfo(String conts_id);

	List<Class_Bookmark> getcontsChp(String conts_id);

	void contsUpdate(Class_ScheduleAddVideo info);

}