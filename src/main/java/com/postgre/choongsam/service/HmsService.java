package com.postgre.choongsam.service;

import java.util.List;

import com.postgre.choongsam.dto.Class_Bookmark;
import com.postgre.choongsam.dto.Class_Schedule;
import com.postgre.choongsam.dto.File_Group;
import com.postgre.choongsam.dto.Lecture_Video;

public interface HmsService {

	String getVideoDetails(String videoId); //영상화면
	List<Lecture_Video> findAllVideo(); //모든 비디오 목록
	void saveWatchTime(Class_Schedule class_schedule);
	long findCurrentMax(String videoId, int user_seq, int lctr_no);
	void saveWatchTimeNoMaxUpdate(Class_Schedule class_schedule);
	int watchedFinalTime(String videoId, int user_seq, int lctr_no);
	String getFilePath(String conts_id);
	List<Class_Bookmark> getBookmarksByContsId(String conts_id);
	List<Class_Bookmark> getBookmark(String conts_id);
	String getfilename(String conts_id);
	File_Group getFilegogo(String conts_id);


}
