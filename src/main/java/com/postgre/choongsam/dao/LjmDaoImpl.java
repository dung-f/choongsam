package com.postgre.choongsam.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.postgre.choongsam.dto.Login_Info;
import com.postgre.choongsam.dto.User_Info;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class LjmDaoImpl implements LjmDao {
	
	private final SqlSession session;
	private final PlatformTransactionManager transactionManager;
	
	// 로그인 처리
	@Override
	public Login_Info login(String user_id) {
		System.out.println("LjmDaoImpl login() start...");
		
		Login_Info login_info = new Login_Info();
		
		try {
			login_info.setUser_id(user_id);			
			login_info = session.selectOne("login", user_id);
			
		} catch (Exception e) {
			System.out.println("LjmDaoImpl login() Error ->" + e.getMessage() );
		}
		return login_info;
	}
	
	@Override
	public User_Info getUserInfo(String user_id) {
		System.out.println("LjmDaoImpl getUserInfo() start...");
        User_Info user_info = null;
        try {
            user_info = session.selectOne("getUserInfo", user_id);
            System.out.println(user_info);
        } catch (Exception e) {
            System.out.println("LjmDaoImpl getUserInfo() Error ->" + e.getMessage());
        }
        return user_info;
    }
	
	// 관리자 로그인 처리
	@Override
	public Login_Info adminLogin(String user_id) {
		System.out.println("LjmDaoImpl adminLogin() start...");
		
		Login_Info login_info = new Login_Info();
		
		try {
			login_info.setUser_id(user_id);			
			login_info = session.selectOne("adminLogin", user_id);
			
		} catch (Exception e) {
			System.out.println("LjmDaoImpl adminLogin() Error ->" + e.getMessage() );
		}
		return login_info;
	}

	// 회원가입
	@Override
	public int signup(Login_Info login_Info, User_Info user_info) {
		System.out.println("LjmDaoImpl signup() start...");
		TransactionStatus txStatus= transactionManager.getTransaction(new DefaultTransactionDefinition());
		int signupResult = 0;
		
		try {
			signupResult = session.insert("loginSignup", login_Info);
			signupResult = session.insert("userSignup", user_info);
			
			transactionManager.commit(txStatus);
			
		} catch (Exception e) {
			System.out.println("LjmDaoImpl signup() Error ->" + e.getMessage());
			transactionManager.rollback(txStatus);
		}
		
		
		return signupResult;
	}
	
	// 아이디 중복 체크
	@Override
	public int confirmId(String user_id) {
		System.out.println("LjmDaoImpl confirmId() start...");
		int result = session.selectOne("confirmId", user_id);
		return result;
	}
	
	// 아이디 찾기
	@Override
	public String findId(User_Info user_info) {
		System.out.println("LjmDaoImpl findId() start...");

		String user_id = session.selectOne("findId", user_info);

		System.out.println("LjmDaoImpl findId() user_id -> " + user_id);

		return user_id;
	}
	
	// 회원 번호를 갖고 회원 이름 가져오기
	@Override
	public String getUserName(int user_seq) {
		String user_name = session.selectOne("getUserName",user_seq);
		System.out.println("username--->"+user_name);
		return user_name;
	}
	
	// 비밀번호 찾기 1. 입력한 정보 토대로 사용자 정보 존재 여부 확인
	@Override
		public User_Info findPw(User_Info user_info) {
		System.out.println("LjmDaoImpl findPw() start...");
		User_Info user = new User_Info();
		System.out.println(user_info);
		user = session.selectOne("findPw", user_info);
		return user;
	}
	
	// 비밀번호 찾기 2. 랜덤 난수로 임시 비밀번호 생성, 암호화
	@Override
		public void updateTempPw(String user_id, String hashedTempPw) {
		System.out.println("LjmDaoImpl updateTempPw() start...");
		
		Login_Info login_info = new Login_Info();
		
		login_info.setUser_id(user_id);
		login_info.setPassword(hashedTempPw);
		
		int updateTempPw = session.update("updateTempPw", login_info);
		
		if (updateTempPw > 0) {
			System.out.println("LjmDaoImpl updateTempPw() 성공");
		} else {
			System.out.println("LjmDaoImpl updateTempPw() 실패");
		}
			
	}
	
	// 비밀번호 찾기 3. 생성한 임시 비밀번호를 메일로 전송
	@Override
	public String getUserEmail(String user_id) {
		System.out.println("LjmDaoImpl getUserEmail() start...");
		
		String user_email = session.selectOne("getUserEmail", user_id);
		System.out.println("LjmDaoImpl getUserEmail() user_email -> " + user_email);
		return user_email;
	}

}
