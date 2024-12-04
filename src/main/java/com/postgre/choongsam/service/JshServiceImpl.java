package com.postgre.choongsam.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;

import com.postgre.choongsam.dao.JshDao;
import com.postgre.choongsam.dto.Class_Bookmark;
import com.postgre.choongsam.dto.Class_Schedule;
import com.postgre.choongsam.dto.Class_ScheduleAddVideo;

import jakarta.mail.Session;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JshServiceImpl implements JshService {
	
	private final JshDao Dao;
	
	@Override
	public List<Class_ScheduleAddVideo> studentLecture(String lctr_id, int user_seq) {
		System.out.println("JshService StudentLecture start...");
		List<Class_ScheduleAddVideo> contentList = Dao.studentLecture(lctr_id, user_seq);
		System.out.println("JshService StudentLecture contentList >> "+contentList);
		
		return contentList;
	}

	@Override
	public List<Class_ScheduleAddVideo> getStartDay(String lctr_id) {
		System.out.println("JshService getStartDay start...");
		
		List<Class_ScheduleAddVideo> startDay = Dao.getStartDay(lctr_id);
		
		return startDay;
	}

	@Transactional
	@Override
	public void contsUpload(Class_ScheduleAddVideo info) {
		System.out.println("JshService contsUpload start...");
		int result=0;
		
		String fileName = info.getFile_nm();
		String fileSuffix= info.getFile_extn_nm();
		long file_sz = info.getFile_sz();
		String file_path = info.getFile_path_nm();
		
		String update = null;
		
		//첨부파일이 있는 경우 먼저 등록
		if(fileName!=null&&fileSuffix!=null&&file_path!=null) {
			result = Dao.contsFileUpload(info);
			
			if(result==0) {
				System.out.println("JshService contsUpload 첨부파일 등록 실패...");
			}
			else {
				System.out.println("JshService contsUpload 첨부파일 등록 성공");
			}
			
			
			result = 0;
			result = Dao.fileLectureVideoUpload(info, update);
			System.out.println("*************************************************************");
			if(result==0) {
				System.out.println("JshService fileLectureVideoUpload 강의영상 등록 실패...");
			}
			else {
				System.out.println("JshService fileLectureVideoUpload 강의영상 등록 성공");
			}
		}
		else {
			//첨부파일이 없는 경우 업로드
			result = 0;
			result = Dao.lectureVideoUpload(info,update);
			System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
			if(result==0) {
				System.out.println("JshService lectureVideoUpload 강의영상 등록 실패...");
			}
			else {
				System.out.println("JshService lectureVideoUpload 강의영상 등록 성공");
			}
		}
		
		//강의계획서상세(차시) 업로드
		result = 0;
		result = Dao.syllabusUpload(info, update);
		if(result==0) {
			System.out.println("JshService syllabusUpload 강의계획서 등록 실패...");
		}
		else {
			System.out.println("JshService syllabusUpload 강의계획서 등록 성공");
		}
		
		
		Integer chp_time1 = info.getConts_chptime();
		
		//영상챕터가 있다면 업로드
		if(chp_time1!=null&&chp_time1!=0) {
			result = 0;
			result = Dao.chpTimeUpload(info, update);
			if(result==0) {
				System.out.println("JshService chpTimeUpload 강의챕터 등록 실패...");
			}
			else {
				System.out.println("JshService chpTimeUpload 강의챕터 등록 성공");
			}
		}
		
	}

	@Override
	public int classScheChk(String chashi, String conts_id, String lctr_id, String user_seq) {
		System.out.println("JshService classScheChk start  차시 >> "+chashi+"강의번호 >> "+lctr_id+" 영상번호 >> "+conts_id+ " 유저번호 >> "+user_seq);
		
		int result = 0;
		Integer search = 0;
		
		search = Dao.searchSche(chashi, conts_id, user_seq);
		
		if(search!=null&&search!=0) {
			result = 1;
			System.out.println("리스트 존재");
		}
		else {
			System.out.println("리스트에 존재하지 않음");
			result = Dao.insertSche(chashi, conts_id, lctr_id ,user_seq);
		}
		
		return result;
	}

	@Override
	public List<Class_ScheduleAddVideo> searchTeachConts(String lctr_id, int user_seq) {
		System.out.println("JshService cassScheChk start  과목번호 >> "+lctr_id+" 강사번호 >> "+user_seq);
		List<Class_ScheduleAddVideo> info = Dao.searchTeachConts(lctr_id, user_seq);
		
		System.out.println("JshService cassScheChk start info >> "+info);
		
		return info;
	}

	@Override
	public List<Class_ScheduleAddVideo> LectureName(String lctr_id) {
		List<Class_ScheduleAddVideo> name = Dao.LectureName(lctr_id);
		return name;
	}

	@Override
	public List<Class_Schedule> classSchedule(String lctr_id, int user_seq) {
		System.out.println("JshService classSchedule start  과목번호 >> "+lctr_id+" 강사번호 >> "+user_seq);
		List<Class_Schedule> classSchedule = Dao.classSchedule(lctr_id, user_seq);
		return classSchedule;
	}

	@Override
	public List<Class_ScheduleAddVideo> getcontsInfo(String conts_id) {
		System.out.println("JshService getcontsInfo start  강사번호 >> "+conts_id);
		
		List<Class_ScheduleAddVideo> info = Dao.getcontsInfo(conts_id);
		System.out.println("JshService getcontsInfo info >> "+info);
		
		return info;
	}

	@Override
	public List<Class_Bookmark> getcontsChp(String conts_id) {
		System.out.println("JshService getcontsChp start  강사번호 >> "+conts_id);
		
		List<Class_Bookmark> info = Dao.getcontsChp(conts_id);
		System.out.println("JshService getcontsChp info >> "+info);
		
		return info;
	}

	//강의 업데이트
	@Transactional
	@Override
	public void contsUpdate(Class_ScheduleAddVideo info) {
		System.out.println("JshService contsUpdate start...");
		int result=0;
		
		//UUID 생성
		String timestamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
		String idntf_no = UUID.randomUUID().toString() + "_" + timestamp;
		
		String fileName = info.getFile_nm();
		String fileSuffix= info.getFile_extn_nm();
		long file_sz = info.getFile_sz();
		String file_path = info.getFile_path_nm();
		
		String update = "update";
		
		//첨부파일이 있는 경우 먼저 업데이트
		if(fileName!=null&&fileSuffix!=null&&file_path!=null) {
			//파일은 차피 업데이트가 아니라 새로 업데이트라 file_seq만 curr로 해서 사용하면 될 듯...
			result = Dao.contsFileUpload(info);
			
			if(result==0) {
				System.out.println("JshService contsUpdate 첨부파일 새로 등록 실패...");
			}
			else {
				System.out.println("JshService contsUpdate 첨부파일 새로 등록 성공");
			}
			
			result = 0;
			
			result = Dao.fileLectureVideoUpload(info, update);
			System.out.println("*************************************************************");
			if(result==0) {
				System.out.println("JshService contsUpdate fileLectureVideoUpload 강의영상 업데이트 실패...");
			}
			else {
				System.out.println("JshService contsUpdate fileLectureVideoUpload 강의영상 업데이트 성공");
			}
		}
		else {
			//첨부파일이 없는 경우 업데이트
			result = 0;
			result = Dao.lectureVideoUpload(info, update);
			System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
			if(result==0) {
				System.out.println("JshService contsUpdate lectureVideoUpload 강의영상 업데이트 실패...");
			}
			else {
				System.out.println("JshService contsUpdate lectureVideoUpload 강의영상 업데이트 성공");
			}
		}
		
		//강의계획서상세(차시) 업데이트
		result = 0;
		result = Dao.syllabusUpload(info, update);
		if(result==0) {
			System.out.println("JshService contsUpdate syllabusUpload 강의계획서 업데이트 실패...");
		}
		else {
			System.out.println("JshService contsUpdate syllabusUpload 강의계획서 업데이트 성공");
		}
		
		
		Integer chp_time1 = info.getConts_chptime();
		
		//영상챕터가 있다면 업데이트
		if(chp_time1!=null&&chp_time1!=0) {
			result = 0;
			result = Dao.chpTimeUpload(info, update);
			if(result==0) {
				System.out.println("JshService contsUpdate chpTimeUpload 강의챕터 업데이트 실패...");
			}
			else {
				System.out.println("JshService contsUpdate chpTimeUpload 강의챕터 업데이트 성공");
			}
		}
	}

}