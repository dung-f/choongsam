package com.postgre.choongsam.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.eclipse.tags.shaded.org.apache.bcel.generic.Select;
import org.springframework.stereotype.Repository;

import com.postgre.choongsam.dto.Class_Bookmark;
import com.postgre.choongsam.dto.Class_Schedule;
import com.postgre.choongsam.dto.Class_ScheduleAddVideo;

import lombok.RequiredArgsConstructor;


@Repository
@RequiredArgsConstructor
public class JshDaoImpl implements JshDao {

	private final SqlSession session;
	
	@Override
	public List<Class_ScheduleAddVideo> studentLecture(String lctr_id, int user_seq) {
		System.out.println("JshDao StudentLecture start...");
		List<Class_ScheduleAddVideo> contentList = null;
		
		Map<String, Object> infor = new HashMap<>();
		infor.put("lctr_id", lctr_id);
		infor.put("user_seq", user_seq);
		
		System.out.println("JshDao StudentLecture infor >> "+infor);
		
		try {
			contentList = session.selectList("com.postgre.choongsam.mapper.Sh_mapper.studentLecture", infor);
			System.out.println("JshDao StudentLecture contentList >> "+contentList);
		} catch (Exception e) {
			System.out.println("JshDao StudentLecture exception >> "+e.getMessage());
		}
		
		return contentList;
	}

	@Override
	public List<Class_ScheduleAddVideo> getStartDay(String lctr_id) {
		System.out.println("JshDao getStartDay start...");
		System.out.println("JshDao getStartDay lctr_id >> "+lctr_id);
		
		List<Class_ScheduleAddVideo> startday = null;

		try {
			startday = session.selectList("getStartDay",lctr_id);
			System.out.println("JshDao getStartDay startday 아니 왜 null인데 너가 나와>> " + startday);
			
			if (startday == null || startday.isEmpty()) {
	            startday = session.selectList("getStartDay1", lctr_id);
	        }
			
		} catch (Exception e) {
			System.out.println("JshDao getStartDay exception>> "+e.getMessage());
		}
		
		return startday;
	}

	@Override
	public int contsFileUpload(Class_ScheduleAddVideo info) {
		System.out.println("JshDao contsFileUpload start...");
		
		int result = 0;
		
		String fileName = info.getFile_nm();
		String fileSuffix= info.getFile_extn_nm();
		long file_sz = info.getFile_sz();
		String file_path = info.getFile_path_nm();
		String idntf_no = info.getIdntf_no();
		
		Map<String, Object> fileInfo = new HashMap<>();
		
		fileInfo.put("fileName", fileName);
		fileInfo.put("fileSuffix", fileSuffix);
		fileInfo.put("file_sz", file_sz);
		fileInfo.put("file_path", file_path);
		fileInfo.put("idntf_no", idntf_no);
		
		try {
			result = session.insert("contsFileUpload",fileInfo);
		} catch (Exception e) {
			System.out.println("JshDao contsFileUpload exception >> "+e.getMessage());
		}
		
		return result;
	}

	@Override
	public int fileLectureVideoUpload(Class_ScheduleAddVideo info, String update) {
		System.out.println("JshDao fileLectureVideoUpload start...");
		
		int result = 0;
		
		String conts_id = info.getConts_id();
		String title = info.getVdo_file_nm();
		String conts_url = info.getVdo_url_addr();
		String viewing_period = info.getViewing_period();
		Integer vdo_length = info.getVdo_length();
		int chashi = info.getLctr_no();
		int file_group = info.getFile_group();
		int lctr_no = info.getLctr_no();
		String lctr_id = info.getLctr_id();
		
		Map<String, Object> lectureInfo = new HashMap<>();
		
		lectureInfo.put("conts_id", conts_id);
		lectureInfo.put("title", title);
		lectureInfo.put("conts_url", conts_url);
		lectureInfo.put("viewing_period", viewing_period);
		lectureInfo.put("vdo_length", vdo_length);
		lectureInfo.put("chashi", chashi);
		lectureInfo.put("file_group", file_group);
		lectureInfo.put("lctr_no", lctr_no);
		lectureInfo.put("lctr_id", lctr_id);
		
		
		try {
			if(update == null) {
				result = session.insert("fileLectureVideoUpload", lectureInfo);
			}
			else {
				result= session.update("fileLectureVideoUpdate", lectureInfo);
			}
			
		} catch (Exception e) {
			System.out.println("JshDao lectureVideoUpload exception >> "+e.getMessage());
		}
		
		return result;
	}

	@Override
	public int lectureVideoUpload(Class_ScheduleAddVideo info, String update) {
		System.out.println("JshDao lectureVideoUpload start...");
		
		int result = 0;
		
		String conts_id = info.getConts_id();
		String title = info.getVdo_file_nm();
		String conts_url = info.getVdo_url_addr();
		String viewing_period = info.getViewing_period();
		Integer vdo_length = info.getVdo_length();
		int chashi = info.getLctr_no();
		int lctr_no = info.getLctr_no();
		String lctr_id = info.getLctr_id();
		
		Map<String, Object> lectureInfo = new HashMap<>();
		
		lectureInfo.put("conts_id", conts_id);
		lectureInfo.put("title", title);
		lectureInfo.put("conts_url", conts_url);
		lectureInfo.put("viewing_period", viewing_period);
		lectureInfo.put("vdo_length", vdo_length);
		lectureInfo.put("chashi", chashi);
		lectureInfo.put("lctr_no", lctr_no);
		lectureInfo.put("lctr_id", lctr_id);
		
		try {
			if(update == null) {
				result = session.insert("lectureVideoUpload", lectureInfo);
			}
			else {
				result = session.update("lectureVideoUpdate", lectureInfo);
			}
		} catch (Exception e) {
			System.out.println("JshDao lectureVideoUpload exception >> "+e.getMessage());
		}
		
		return result;
	}

	@Override
	public int syllabusUpload(Class_ScheduleAddVideo info, String update) {
		System.out.println("JshDao lectureVideoUpload start...");
		int result = 0;
		
		int lctr_no = info.getLctr_no();
		String lctr_id = info.getLctr_id();
		String conts_id = info.getConts_id();
		int user_seq = info.getUser_seq();
		String lctr_otln = info.getLctr_otln();
		
		Map<String, Object> syllabusInfo = new HashMap<>();
		
		syllabusInfo.put("lctr_no", lctr_no);
		syllabusInfo.put("lctr_id", lctr_id);
		syllabusInfo.put("conts_id", conts_id);
		//syllabusInfo.put("user_seq", user_seq);
		//syllabusInfo.put("lctr_otln", lctr_otln);
		
		System.out.println("lctr_no >> "+lctr_no);
		System.out.println("lctr_id >> "+lctr_id);
		System.out.println("conts_id >> "+conts_id);
		
		try {
			if(update==null) {
				result = session.update("syllabusUpload", syllabusInfo);
			}
			else {
				result = session.update("syllabusUpdate", syllabusInfo);
			}
		} catch (Exception e) {
			System.out.println("JshDao syllabusUpload exception >> "+e.getMessage());
		}
		
		
		return result;
	}

	@Override
	public int chpTimeUpload(Class_ScheduleAddVideo info, String update) {
		System.out.println("JshDao chpTimeUpload start...");
		int result = 0;
		
		String conts_id = info.getConts_id();
		Integer chp_time = info.getConts_chptime();
		String cap_ttl = info.getConts_chpttl();
		Integer chp_time2 = info.getConts_chptime2();
		String cap_ttl2 = info.getConts_chpttl2();
		Integer chp_time3 = info.getConts_chptime3();
		String cap_ttl3 = info.getConts_chpttl3();
		
		System.out.println("dao >> "+chp_time);
		System.out.println("dao >> "+chp_time2);
		System.out.println("dao >> "+chp_time3);
		
		Map<String, Object> chpInfo = new HashMap<>();
		chpInfo.put("conts_id", conts_id);
		chpInfo.put("chp_time", chp_time);
		chpInfo.put("cap_ttl", cap_ttl);
		
		int value = 1;
		chpInfo.put("value", value);
		
		try {
			if(update == null) {
				result = session.insert("chpTimeUpload", chpInfo);
				
				if(chp_time2!=null&&chp_time2!=0) {
					result = 0;
					value = 2;
					chpInfo.put("value", value);
					chpInfo.put("chp_time", chp_time2);
					chpInfo.put("cap_ttl", cap_ttl2);
					
					result = session.insert("chpTimeUpload", chpInfo);
				}
				else if(chp_time3!=null&&chp_time3!=0) {
					result=0;
					value = 3;
					chpInfo.put("value", value);
					chpInfo.put("chp_time", chp_time3);
					chpInfo.put("cap_ttl", cap_ttl3);
					
					result = session.insert("chpTimeUpload", chpInfo);
				}
			}
			else {
					result = session.update("chpTimeUpdate", chpInfo);
					
					if(chp_time2!=null&&chp_time2!=0) {
						value = 2;
						chpInfo.put("value", value);
						result = 0;
						chpInfo.put("chp_time", chp_time2);
						chpInfo.put("cap_ttl", cap_ttl2);
						
						result = session.update("chpTimeUpdate", chpInfo);
					}
					else if(chp_time3!=null&&chp_time3!=0) {
						value = 3;
						chpInfo.put("value", value);
						result=0;
						chpInfo.put("chp_time", chp_time3);
						chpInfo.put("cap_ttl", cap_ttl3);
						
						result = session.update("chpTimeUpdate", chpInfo);
				}
			}
		} catch (Exception e) {
			System.out.println("JshDao chpTimeUpload exception >> "+e.getMessage());
		}
		return result;
	}

	@Override
	public int searchSche(String chashi, String conts_id, String user_seq) {
		System.out.println("JshDao searchSche start...");
		int result = 0;
		
		Map<String, Object> info = new HashMap<>();
		info.put("lctr_no", chashi);
		info.put("conts_id", conts_id);
		info.put("user_seq", user_seq);
		
		try {
			result = session.selectOne("searchSche", info);
			System.out.println("JshDao searchSche result >> "+result);
		} catch (Exception e) {
			System.out.println("JshDao searchSche exception >> "+e.getMessage());
		}
		
		System.out.println("뭘 반환하는거야 "+result);
		return result;
	}

	@Override
	public int insertSche(String chashi, String conts_id, String lctr_id, String user_seq) {
		System.out.println("JshDao insertSche start...");
		int result = 0;
		
		Integer lctr_no = Integer.parseInt(chashi);
		Integer user_seqInt = Integer.parseInt(user_seq);
		
		Map<String, Object> info = new HashMap<>();
		info.put("lctr_no", lctr_no);
		info.put("conts_id", conts_id);
		info.put("user_seq", user_seqInt);
		info.put("lctr_id", lctr_id);
		
		System.out.println("------------------------------------lctr_id"+lctr_id);
		
		
		try {
			result = session.insert("insertSche", info);
			System.out.println("JshDao insertSche result >> "+result);
		} catch (Exception e) {
			System.out.println("JshDao searchSche exception >> "+e.getMessage());
		}
		
		return result;
	}

	@Override
	public List<Class_ScheduleAddVideo> searchTeachConts(String lctr_id, int user_seq) {
		System.out.println("JshDao searchTeachConts start...");
		
		List<Class_ScheduleAddVideo> info = null;
		Map<String, Object> value = new HashMap<>();
		
		value.put("lctr_id", lctr_id);
		value.put("user_seq", user_seq);
		
		try {
			info = session.selectList("searchTeachConts", value);
			
		} catch (Exception e) {
			System.out.println("JshDao searchTeachConts exception >> "+e.getMessage());
		}
		
		return info;
	}

	@Override
	public List<Class_ScheduleAddVideo> LectureName(String lctr_id) {
		//System.out.println("dddddddddddddddddd >> "+lctr_id);
		List<Class_ScheduleAddVideo> name = session.selectList("LectureName", lctr_id);
		//System.out.println("name >>>>>>>>>>>>>>>>>" +name);
		return name;
	}

	@Override
	public List<Class_Schedule> classSchedule(String lctr_id, int user_seq) {
		System.out.println("JshDao classSchedule start...");
		
		List<Class_Schedule> classSchedule = null;
		
		Map<String, Object> info = new HashMap<>();
		info.put("lctr_id", lctr_id);
		info.put("user_seq", user_seq);
		
		try {
			classSchedule = session.selectList("classSchedule", info);
			System.out.println("JshDao classSchedule inft >> "+info);
		} catch (Exception e) {
			System.out.println("JshDao classSchedule exception >> "+e.getMessage());
		}
		return classSchedule;
	}

	@Override
	public List<Class_ScheduleAddVideo> getcontsInfo(String conts_id) {
	    System.out.println("JshDao getcontsInfo start...");

	    List<Class_ScheduleAddVideo> info = null;

	    try {
	        info = session.selectList("getcontsInfo", conts_id);  // selectList로 수정
	        System.out.println("JshDao getcontsInfo info >> " + info);
	    } catch (Exception e) {
	        System.out.println("JshDao getcontsInfo exception >> " + e.getMessage());
	    }

	    return info;
	}


	@Override
	public List<Class_Bookmark> getcontsChp(String conts_id) {
		System.out.println("JshDao getcontsChp start...");
		
		List<Class_Bookmark> info = null;
		
		try {
			info = session.selectList("getcontsChp", conts_id);
			System.out.println("JshDao getcontsChp info >> "+info);
		} catch (Exception e) {
			System.out.println("JshDao getcontsChp exception >> "+e.getMessage());
		}
		
		return info;
	}

}