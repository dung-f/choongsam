package com.postgre.choongsam.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.hibernate.internal.build.AllowSysOut;
import org.springframework.stereotype.Repository;

import com.postgre.choongsam.dto.Class_Bookmark;
import com.postgre.choongsam.dto.Class_Schedule;
import com.postgre.choongsam.dto.File_Group;
import com.postgre.choongsam.dto.Lecture_Video;
import com.postgre.choongsam.dto.Syllabus;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class HmsDaoImpl implements HmsDao {
	
	public final SqlSession session;

	//postgre 모든 영상 불러오기
	@Override
	public List<Lecture_Video> findAllVideo() {
		System.out.println("msDao findAllVideo start..");
		List<Lecture_Video> videoList = null;
		try {
			videoList = session.selectList("com.postgre.choongsam.mapper.HMS.findAllVideo");
			System.out.println("msDao findAllVideo videoList->"+videoList);
		} catch (Exception e) {
			System.out.println("msDao findAllVideo error->"+e.getMessage());
		}
		return videoList;
	}

	//api data저장
	@Override
	public void APIdata(String videoId) {
		System.out.println("msDao APIdata start..");
		try {
			int result = session.update("com.postgre.choongsam.mapper.HMS.APIdata",videoId);
		} catch (Exception e) {
			System.out.println("msDao APIdata error->"+e.getMessage());
		}	
	}

	//class_schedule업데이트
	@Override
	public void saveWatchTime(Class_Schedule class_schedule) {
		System.out.println("msDao saveWatchTime start...");
		System.out.println("msDao saveWatchTime schedule->"+class_schedule);
		int result = 0 ;
		try {
			result = session.update("com.postgre.choongsam.mapper.HMS.saveWatchTime",class_schedule);
			System.out.println("msDao saveWatchTime result->"+result);
		} catch (Exception e) {
			System.out.println("msDao saveWatchTime error->"+e.getMessage());
		}	
	}
	//max값 빼고 없데이트
		@Override
		public void saveWatchTimeNoMaxUpdate(Class_Schedule class_schedule) {
			System.out.println("msDao saveWatchTimeNoMaxUpdate start...");
			System.out.println("msDao saveWatchTimeNoMaxUpdate schedule->"+class_schedule);
			int result = 0 ;
			try {
				result = session.update("com.postgre.choongsam.mapper.HMS.noMaxUpdate",class_schedule);
				System.out.println("msDao saveWatchTimeNoMaxUpdate result->"+result);
			} catch (Exception e) {
				System.out.println("msDao saveWatchTimeNoMaxUpdate error->"+e.getMessage());
			}
			
		}

	//syllabus테이블에서 videoId로 lctr_정보
	@Override
	public Syllabus findLctrInfo(String videoId, int lctr_no) {
		System.out.println("msDao findLctrInfo start...");
		System.out.println("msDao findLctrInfo videoId..."+videoId);
		Syllabus info = null;
		try {
			info = session.selectOne("com.postgre.choongsam.mapper.HMS.findLctrInfo", Map.of("videoId",videoId,"lctr_no",lctr_no));
		} catch (Exception e) {
			System.out.println("msDao findLctrInfo error->"+e.getMessage());
			e.printStackTrace();
		}
		return info;
	}

	//max값
	@Override
	public long findCurrentMax(String videoId, int user_seq, int lctr_no) {
		System.out.println("msDao findCurrentMax start..");
		int currentMax = 0;
		try {
			currentMax = session.selectOne("com.postgre.choongsam.mapper.HMS.CurrentMax",Map.of("videoId",videoId,"user_seq",user_seq,"lctr_no",lctr_no));
		} catch (Exception e) {
			System.out.println("msDao findCurrentMax error->"+e.getMessage());
			e.printStackTrace();
		}
		return currentMax;
	}

	//final
	@Override
	public int watchedFinalTime(String videoId, int user_seq, int lctr_no) {
		System.out.println("msDao watchedFinalTime start..");
		System.out.println("msDao watchedFinalTime videoId.."+videoId);
		int result = 0;
		try {
			result = session.selectOne("com.postgre.choongsam.mapper.HMS.finalTime",Map.of("videoId",videoId,"user_seq",user_seq,"lctr_no",lctr_no));
		} catch (Exception e) {
			System.out.println("msDao watchedFinalTime error->"+e.getMessage());
		}
		return result;
	}

	//파일 다운로드
	@Override
	public String getFilePath(String conts_id) {
	    System.out.println("msDao getFilePath start...");
	    System.out.println("msDao getFilePath filename..." + conts_id);
	    String result = null;
	    try {
	        System.out.println("filename: " + conts_id);  // filename 출력
	        result = session.selectOne("com.postgre.choongsam.mapper.HMS.FileDown", conts_id);
	        
	        if (result == null || result.trim().isEmpty()) {
	            System.out.println("No file path found for filename: " + conts_id);  // 경로가 없을 경우 로그
	        } else {
	            System.out.println("File path retrieved: " + result);  // 경로가 있을 경우 로그
	        }
	    } catch (Exception e) {
	        System.out.println("msDao getFilePath error->" + e.getMessage());
	        e.printStackTrace();  // 예외의 전체 스택 트레이스를 출력
	    }	    
	    return result;
	}

	//주소가져오기
	@Override
	public String getURL(String videoId) {
		System.out.println("msDao getURL start..");
		String result = null;
		
		try {
			result = session.selectOne("com.postgre.choongsam.mapper.HMS.getURL",videoId);
			System.out.println("msDao getURL result->"+result);
		} catch (Exception e) {
			System.out.println("msDao getURL error->"+e.getMessage());
		}
		return result;	
	}

	@Override
	public List<Class_Bookmark> Bookmark(String conts_id) {
		System.out.println("msDao bookMark start..");
		List<Class_Bookmark> bookmark = null;
		try {
			bookmark = session.selectList("com.postgre.choongsam.mapper.HMS.bookmark",conts_id);
		} catch (Exception e) {
			System.out.println("msDao bookmark error->"+e.getMessage());
		}
		return bookmark;
	}

	//filename
	@Override
	public String getfilename(String conts_id) {
		System.out.println("msDao getfilename start..");
		System.out.println("msDao getfilename conts_id.."+conts_id);
		String filename = null;
		try {
			filename = session.selectOne("com.postgre.choongsam.mapper.HMS.getfilename",conts_id);
		} catch (Exception e) {
			System.out.println("msDao getfilename error->"+e.getMessage());
		}
		return filename;
	}

	@Override
	public List<Class_Bookmark> getBookmark(String conts_id) {
		System.out.println("maDao getBookmark start..");
		System.out.println("maDao getBookmark conts_id.."+conts_id);
		List<Class_Bookmark> bookmark = null;
		try {
			bookmark = session.selectList("com.postgre.choongsam.mapper.HMS.getBookmark",conts_id);
			System.out.println("maDao getBookmark bookmark.."+bookmark);
		} catch (Exception e) {
			System.out.println("msDao getBookmark error->"+e.getMessage());
		}
		return bookmark;
	}

	@Override
	public File_Group getfileGoGo(String conts_id) {
		System.out.println("msDao getfilegogo start..");
		System.out.println("msDao getfilegogo conts_id.."+conts_id);
		File_Group file = null;
		try {
			file = session.selectOne("com.postgre.choongsam.mapper.HMS.getfilegogo",conts_id);
		} catch (Exception e) {
			System.out.println("msDao getfilegogo error->"+e.getMessage());
		}
		return file;
	}
}
