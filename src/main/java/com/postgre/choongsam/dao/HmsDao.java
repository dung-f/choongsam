package com.postgre.choongsam.dao;

import java.util.List;

import com.postgre.choongsam.dto.Class_Bookmark;
import com.postgre.choongsam.dto.Class_Schedule;
import com.postgre.choongsam.dto.File_Group;
import com.postgre.choongsam.dto.Lecture_Video;
import com.postgre.choongsam.dto.Syllabus;

public interface HmsDao {
	List<Lecture_Video> findAllVideo();//모든 영상목록 가져오기
	void APIdata(String videoId);//youtubeAPI data저장
	void saveWatchTime(Class_Schedule class_schedule);
	Syllabus findLctrInfo(String videoId, int lctr_no);
	long findCurrentMax(String videoId, int user_seq, int lctr_no);
	void saveWatchTimeNoMaxUpdate(Class_Schedule class_schedule);
	int watchedFinalTime(String videoId, int user_seq, int lctr_no);
	String getFilePath(String conts_id);
	String getURL(String videoId);
	List<Class_Bookmark> Bookmark(String conts_id);
	String getfilename(String conts_id);
	List<Class_Bookmark> getBookmark(String conts_id);
	File_Group getfileGoGo(String conts_id);





}
