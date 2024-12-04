package com.postgre.choongsam.service;

import java.util.List;
import java.util.Map;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.postgre.choongsam.dao.HjhDao;
import com.postgre.choongsam.dto.Course_Registration;
import com.postgre.choongsam.dto.Lecture;
import com.postgre.choongsam.dto.Login_Info;
import com.postgre.choongsam.dto.User_Info;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HjhServiceImpl implements HjhService {
	private final HjhDao hjhdao;
	private final BCryptPasswordEncoder passwordEncoder;


	@Override
	public List<User_Info> userList(Map<String, Object> params) {
		List<User_Info> listteastd = hjhdao.teastdlist(params);
		return listteastd;
	}

	@Override
	public int totaluser(String keyword) {
		int totaluser = hjhdao.totaluser(keyword);
		return totaluser;
	}

	@Override
	public User_Info detailProfile(String user_id) {
		User_Info detailProfile = hjhdao.detailProfile(user_id);
		return detailProfile;
	}

	@Override
	public int userProfile1(User_Info info) {
		int userProfile1 = hjhdao.userProfile1(info);
		return userProfile1;
	}

	@Override
	public List<User_Info> profileupdate(String user_id) {
		List<User_Info> profileupdate = hjhdao.profileupdate(user_id);
		return profileupdate;
	}

	@Override
	public User_Info detailProfileuser(String userId) {
		User_Info detailProfileuser = hjhdao.detailProfileuser(userId);
		System.out.println("detailProfileuser service: " + detailProfileuser);
		return detailProfileuser;
	}

	@Override
	public int deleteStd1(String user_id, String password) {
	    int result = 0;

	    // 로그인 정보 조회
	    Login_Info loginInfo = hjhdao.getLoginInfo(user_id);
	    System.out.println("로그인 정보: " + loginInfo);
	    if (loginInfo != null) {
	        // 비밀번호 검증
	        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	        if (passwordEncoder.matches(password, loginInfo.getPassword())) {
	            // 비밀번호가 일치하면 삭제 (UPDATE 쿼리 실행)
	            result = hjhdao.deleteStd1(user_id, password);
	        } else {
	            // 비밀번호 불일치 시 처리
	            System.out.println("비밀번호가 일치하지 않습니다.");
	        }
	    } else {
	        // 로그인 정보가 없을 때 처리
	        System.out.println("로그인 정보가 없습니다.");
	    }

	    return result;
	}


	@Override
	public Login_Info getLoginInfo(String userId) {
		Login_Info getLoginInfo = hjhdao.getLoginInfo(userId);
		System.out.println("서비스"+getLoginInfo);
		return getLoginInfo;
	}

	@Override
	public int updateCountAdmin(User_Info info) {
		int updateCountAdmin = hjhdao.updateCountAdmin(info);
		return updateCountAdmin;
	}
	@Override
	public int changePW(String password, String user_id, String new_password) {
	    int changePW = 0;

	    // 로그인 정보 조회 (사용자의 비밀번호를 가져옴)
	    Login_Info loginInfo = hjhdao.getLoginInfo(user_id);  // 사용자 ID로 DB에서 로그인 정보 조회
	    
	    System.out.println("로그인 정보: " + loginInfo);
	    System.out.println("입력한 비밀번호"+password);


	    if (loginInfo != null) {
	        
	        
	        // 입력된 비밀번호와 DB에 저장된 비밀번호를 비교
	        if (passwordEncoder.matches(password, loginInfo.getPassword())) {
	        	System.out.println("비밀번호일치");

	            // 비밀번호가 일치하면 새 비밀번호를 암호화
	            String hashedNewPassword = passwordEncoder.encode(new_password);  // 새 비밀번호 암호화

	            // 새 비밀번호를 DB에 업데이트
	            changePW = hjhdao.changePW(hashedNewPassword, user_id);  // DB 업데이트
	            System.out.println("changePW"+changePW);
	            System.out.println("changePW"+changePW);
	        } else {
	            // 비밀번호가 일치하지 않으면 0 반환
	            System.out.println("비밀번호가 일치하지 않습니다.");
	            changePW = 0;  // 실패
	        }
	    } else {
	        // 로그인 정보가 없을 때 처리
	        System.out.println("로그인 정보가 없습니다.");
	        changePW = 0;  // 실패
	    }

	    return changePW;  // 비밀번호 변경 결과 (성공이면 1, 실패면 0)
	}

	@Override
	public Login_Info changepassword(String userId) {
		Login_Info changepassword = hjhdao.changepassword(userId);
		return changepassword;
	}

	@Override
	public List<Lecture> lectureList(Map<String, Object> params) {
		List<Lecture> lectureList = hjhdao.lectureList(params);
		return lectureList;
	}

	@Override
	public List<Course_Registration> sugangStu(Map<String, Object> params) {
		List<Course_Registration> sugangStu = hjhdao.sugangStu(params);
		System.out.println("서비스"+sugangStu);
		return sugangStu;
	}

	@Override
	public int updatePayState(int userSeq,String lctrId,int class_count) {
		int updatePayState = hjhdao.updatePayState(userSeq,lctrId,class_count);
		System.out.println("updatePayState 서비스"+updatePayState);
		System.out.println("userSeq"+userSeq);
		System.out.println("lctrId"+lctrId);
		return updatePayState;
	}

	@Override
	public int sugangStuTotalCount(int userSeq, String keyword) {
		int sugangStuTotalCount = hjhdao.sugangStuTotalCount(userSeq,keyword);
		return sugangStuTotalCount;
	}

	@Override
	public int totalLectureCount(int userSeq, String keyword) {
		int totalLectureCount = hjhdao.totalLectureCount(userSeq,keyword);
		return totalLectureCount;
	}




}
