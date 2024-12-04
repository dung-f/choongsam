package com.postgre.choongsam.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.postgre.choongsam.dto.Course_Registration;
import com.postgre.choongsam.dto.Lecture;
import com.postgre.choongsam.dto.Login_Info;
import com.postgre.choongsam.dto.User_Info;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class HjhDaoImpl implements HjhDao {
	private final SqlSession session;

	@Override
	public List<User_Info> teastdlist(Map<String, Object> params) {
		List<User_Info> listteastd = null;
		try {
			listteastd = session.selectList("teastdlist",params);
		} catch (Exception e) {
		System.out.println("다오왔냐");
		}
		return listteastd;
	}

	@Override
	public int totaluser(String keyword) {
		int totalusercount = 0;
		try {
			totalusercount = session.selectOne("totalusercount",keyword);
		} catch (Exception e) {
			System.out.println("error"+e.getMessage());
		}
		return totalusercount;
	}

	@Override
	public User_Info detailProfile(String user_id) {
	    User_Info detailProfile = null;
	    Map<String, Object> params = new HashMap<>();
	    params.put("USER_ID", user_id); // 키를 수정했습니다.
	    detailProfile = session.selectOne("detailProfile", params);
	    
	    return detailProfile;
	}

	@Override
	public int userProfile1(User_Info info) {
		System.out.println("info"+info);
		int userProfile1 = 0;
		try {
			userProfile1 = session.update("userProfile1",info);
		} catch (Exception e) {
			System.out.println("error"+e.getMessage());
			System.out.println("userProfile1"+info);
		}
		return userProfile1;
	}

	@Override
	public List<User_Info> profileupdate(String user_id) {
		System.out.println("user_id"+user_id);
		List<User_Info> profileupdate = null;
		try {
			profileupdate = session.selectOne("profileupdate",user_id);
		} catch (Exception e) {
			System.out.println("error"+e.getMessage());
		}
		return profileupdate;
	}

	@Override
	public User_Info detailProfileuser(String userId) {
	    User_Info detailProfileuser = null;
	    System.out.println("userId: " + userId); // userId 확인
	    
	    try {
	        // SQL 쿼리 실행
	        detailProfileuser = session.selectOne("detailProfileuser", userId);
	        
	        // 결과 확인
	        if (detailProfileuser != null) {
	            System.out.println("User Info retrieved: " + detailProfileuser);
	        } else {
	            System.out.println("No user info found for userId: " + userId);
	        }
	    } catch (Exception e) {
	        System.out.println("Error occurred: " + e.getMessage());
	    }
	    
	    return detailProfileuser;
	}

	@Override
	public int deleteStd1(String user_id, String password) {
	    int deleteStd1 = 0;
	    Map<String, Object> params = new HashMap<>();
	    params.put("user_id", user_id);
	    params.put("password", password);  // 비밀번호는 이미 검증되었으므로 그대로 전달

	    try {
	        deleteStd1 = session.update("deleteStd1", params);
	    } catch (Exception e) {
	        e.printStackTrace();  // 예외 발생 시 출력하여 문제를 추적
	    }

	    return deleteStd1;
	}

	@Override
	public Login_Info getLoginInfo(String userId) {
	    Login_Info getLoginInfo = null;
	    try {
	        // userId를 파라미터로 전달하여 쿼리 실행
	        getLoginInfo = session.selectOne("getLoginInfo", userId);
	    } catch (Exception e) {
	        e.printStackTrace();  // 예외 발생 시 스택 트레이스를 출력하여 원인 파악
	    }
	    return getLoginInfo;
	}

	@Override
	public int updateCountAdmin(User_Info info) {
		System.out.println("info"+info);
		int updateCountAdmin = 0;
		try {
			updateCountAdmin = session.update("updateCountAdmin",info);
		} catch (Exception e) {
			System.out.println("error"+e.getMessage());
			System.out.println("userProfile1"+info);
		}
		return updateCountAdmin;
	}

	@Override
	public int changePW(String hashedNewPassword, String user_id) {
	    int changePW = 0;

	    // DB 업데이트를 위한 파라미터 맵 생성
	    Map<String, Object> params = new HashMap<>();
	    params.put("user_id", user_id);  // 사용자 ID
	    params.put("new_password", hashedNewPassword);  // 암호화된 새 비밀번호

	    
	    try {
	        // MyBatis session을 통해 update 쿼리 실행
	        changePW = session.update("changePW", params);  // "changePW"는 MyBatis에서 사용할 쿼리 ID
	    } catch (Exception e) {
	        // 예외 처리
	        System.out.println("비밀번호 변경 중 오류 발생: " + e.getMessage());
	    }
	    	System.out.println("changePW"+changePW);
	    return changePW;  // 비밀번호 변경 성공 여부 반환 (성공 시 1, 실패 시 0)
	}

	@Override
	public Login_Info changepassword(String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Lecture> lectureList(Map<String, Object> params) {
	    List<Lecture> lectureList = null;
	    try {
	        // MyBatis 매퍼에서 userSeq를 사용하여 강의 목록을 조회
	        lectureList = session.selectList("lectureList", params);
	    } catch (Exception e) {
	        e.printStackTrace();  // 예외 처리
	    }
	    return lectureList;
	}

	@Override
	public List<Course_Registration> sugangStu(Map<String, Object> params) {
	    List<Course_Registration> sugangStu = null;
	    try {
	        // userSeq 값 확인
	        System.out.println("DAO에서 받은 userSeq: " + params);
	        sugangStu = session.selectList("sugangStu", params);
	        System.out.println("DAO에서 받은 sugangStu: " + sugangStu);  // 이 부분에서 null 확인
	    } catch (Exception e) {
	        System.out.println("DAO 에러: " + e.getMessage());
	    }
	    return sugangStu;
	}

	@Override
	public int updatePayState(int userSeq, String lctrId,int class_count) {
	    int updatePayState = 0;
	    Map<String, Object> params = new HashMap<>();
	    params.put("user_seq", userSeq);
	    params.put("lctr_id", lctrId); 
	   
	    
	    System.out.println("userSeq: " + userSeq);
	    System.out.println("lctrId: " + lctrId);
	    
	    try {
	        // 수정된 부분: session.update() 호출 시, "updatePayState"와 params를 두 번째 인자로 전달
	        updatePayState = session.update("updatePayState", params);
	        for (int i = 1;
	        		i <= class_count; i++) {
	        	params.put("cnt", i); 
	        	session.insert("jhattendance", params);
	        }
	        session.insert("jhattendance", params);
	    } catch (Exception e) {
	        System.out.println("Error during updatePayState: " + e.getMessage());
	        System.out.println("params: " + params);
	    }
	    return updatePayState;
	}

	@Override
	public int sugangStuTotalCount(int userSeq, String keyword) {
		int sugangStuTotalCount = 0;
	    Map<String, Object> params = new HashMap<>();
	    params.put("user_seq", userSeq);
	    params.put("keyword", keyword); 
	    
	    System.out.println("userSeq"+userSeq);
		try {
			sugangStuTotalCount = session.selectOne("sugangStuTotalCount",params);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return sugangStuTotalCount;
	}

	@Override
	public int totalLectureCount(int userSeq, String keyword) {
		int totalLectureCount = 0;
	    Map<String, Object> params = new HashMap<>();
	    params.put("user_seq", userSeq);
	    params.put("keyword", keyword); 
	    System.out.println("userSeq"+userSeq);
	    try {
	    	totalLectureCount = session.selectOne("totalLectureCount",params);
		} catch (Exception e) {
			
		}
		return totalLectureCount;
	}




}
