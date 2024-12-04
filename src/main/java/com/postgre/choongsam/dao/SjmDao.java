package com.postgre.choongsam.dao;

import java.util.List;
import java.util.Map;

import com.postgre.choongsam.dto.Ask;
import com.postgre.choongsam.dto.File_Group;
import com.postgre.choongsam.dto.Lecture;

import com.postgre.choongsam.dto.Note;
import com.postgre.choongsam.dto.Notice;

public interface SjmDao {

	List<Notice> selectNoticeList(Map<String, Object> params);

	int countNotice(String keyword);

    Notice noticeDetail(int ntc_mttr_sn);

	
	int noticeCreate(Notice notice,List<File_Group> uploadFiles);
	
	// ##################
	// ##################
	// ##################
	// ##################
	// 쪽지 ------------------------------------------------------------------
	// ##################
	// ##################
	// ##################
	// ##################
	
	List<Note> getNotesReceived(Map<String, Object> params);

	int countNote(Map<String, Object> params);

	List<Note> getNotesSend(Map<String, Object> params);

	Note getNote(int note_sn);

	int createNote(Note note);

	List<Lecture> getMyLectures(int user_seq);

	List<Note> getSameLeceture(Map<String, Object> params);

	int postAsk(Ask ask);

	List<Ask> getAsksMy(Map<String, Object> params);

	Ask getAsk(int dscsn_sn);

	File_Group getFile(int fileGroup, int fileSeq);

	List<File_Group> getFilesByGroup(int file_group);

	int getNoteSendTotal(Map<String, Object> params);

	int getNoteRcvrTotal(Map<String, Object> params);

	int updateReceiveDate(int note_sn);

	int replyUpdateAsks(Ask ask);

	List<Ask> getAsks(Map<String,Object> params);

    int countAsk(Map<String, Object> params);

	int countAskMy(Map<String, Object>params);

	int updateNoticeYn(Notice notice);

	int updateNoteRcvrDelYn(Note note);

	int updateNoteSentDelYn(Note note);

	int countNoticeAll(Map<String, Object> params);

	List<Notice> selectNoticeListAll(Map<String, Object> params);



}

