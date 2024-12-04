package com.postgre.choongsam.service;

import java.util.Random;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.postgre.choongsam.dao.LjmDao;
import com.postgre.choongsam.dto.Login_Info;
import com.postgre.choongsam.dto.User_Info;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class LjmServiceImpl implements LjmService {
	
	private final LjmDao ljd;
	private final BCryptPasswordEncoder passwordEncoder;
	private final JavaMailSender mailSender;
	
	// 로그인 처리
    @Override
    public Login_Info login(String user_id, String password) {
        System.out.println("LjmServiceImpl login() start....");

        // 사용자 정보를 데이터베이스에서 조회
        Login_Info login_Info = ljd.login(user_id);
        
        // 로그인 실패 처리
        if (login_Info == null) {
            System.out.println("사용자를 찾을 수 없습니다.");
            return null; // 사용자 ID가 없으면 null 반환
        }
        
        // 사용자가 입력한 비밀번호를 SHA-256으로 암호화
        // String encodePassword = UserSha256.encrypt(password);
        
        // 비밀번호 확인
        if (passwordEncoder.matches(password, login_Info.getPassword())) {
            System.out.println(user_id + " 로그인 성공");
            return login_Info; // 로그인 성공
        } else {
            System.out.println("비밀번호가 일치하지 않습니다.");
            return null; // 비밀번호가 일치하지 않으면 null 반환
        }
    }    
    
    @Override
	public User_Info getUserStatus(String user_id) {
    	User_Info user_Info = ljd.getUserInfo(user_id);
    	System.out.println("www");
		return user_Info;
	}	
    
 // 관리자 로그인 처리
    @Override
	public Login_Info adminLogin(String user_id, String password) {
    	System.out.println("LjmServiceImpl adminLogin() start....");

        // 사용자 정보를 데이터베이스에서 조회
        Login_Info login_Info = ljd.adminLogin(user_id);
        
        // 로그인 실패 처리
        if (login_Info == null) {
            System.out.println("사용자를 찾을 수 없습니다.");
            return null; // 사용자 ID가 없으면 null 반환
        }
        
        if (login_Info.getUser_status() != 1003) {
        	 System.out.println("관리자만 로그인 가능합니다.");
             return null; // 회원 상태가 1003이 아니면 null 반환
        }
        
        // 사용자가 입력한 비밀번호를 SHA-256으로 암호화
        // String encodePassword = UserSha256.encrypt(password);
        
        // 비밀번호 확인
        if (passwordEncoder.matches(password, login_Info.getPassword())) {// 암호화된 패스워드로 로그인 정보 조회
            System.out.println(user_id + " 로그인 성공");
            return login_Info; // 로그인 성공
        } else {
            System.out.println("비밀번호가 일치하지 않습니다.");
            return null; // 비밀번호가 일치하지 않으면 null 반환
        }
	}
    
 // 회원가입
 	@Override
 	public int signup(Login_Info login_Info, User_Info user_info) {
 		System.out.println("LjmServiceImpl signup() start....");
 		
 		// 비밀번호 SHA-256 암호화
 		// String encodePassword = UserSha256.encrypt(login_Info.getPassword());
 		
 		String encodePassword = passwordEncoder.encode(login_Info.getPassword());
 		login_Info.setPassword(encodePassword);
 		int signupResult = ljd.signup(login_Info, user_info);
 		System.out.println("LjmServiceImpl signupResult -> " + signupResult);
 		
 		return signupResult;
 	}
	
	// 아이디 중복 체크
	@Override
	public int confirmId(String user_id) {
		System.out.println("LjmServiceImpl confirmId() start....");
		int result = ljd.confirmId(user_id);
		System.out.println("LjmServiceImpl confirmId() result -> " + result);
		return result;
	}
	
	// 아이디 찾기
	@Override
	public String findId(User_Info user_info) {
		System.out.println("LjmServiceImpl findId() start...");
		System.out.println("LjmServiceImpl findId() user_name -> " + user_info.getUser_name());
		System.out.println("LjmServiceImpl findId() user_email -> " + user_info.getEmail());

		String user_id = ljd.findId(user_info);

		System.out.println("LjmServiceImpl findId() user_id -> " + user_id);

		return user_id;
	}
	
	// 회원 번호를 갖고 회원 이름 가져오기
	@Override
	public String getUserName(int user_seq) {
		String user_name = ljd.getUserName(user_seq);
		return user_name;
	}
	
	// 비밀번호 찾기 1. 입력한 정보 토대로 사용자 정보 존재 여부 확인
	@Override
	public User_Info findPw(User_Info user_info) {
		System.out.println("LjmServiceImpl findPw() start...");
		User_Info user = ljd.findPw(user_info);
		return user;
	}
	
	// 비밀번호 찾기 2. 랜덤 난수로 임시 비밀번호 생성, 암호화
	@Override
	public String createTempPassword(String user_id) {
		String tempPassword = createRandomPw();

		// 비밀번호 해시화
		String hashedTempPw = passwordEncoder.encode(tempPassword);

		// 비밀번호 DB 업데이트
		ljd.updateTempPw(user_id, hashedTempPw);

		return tempPassword;
	}
	
	// 랜덤 비밀번호 생성
	private String createRandomPw() {
		// 비밀번호 길이 : 8
		int length = 8;
		
		String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		
		Random random = new Random();
		
		StringBuilder password = new StringBuilder(length);

		// length 만큼 비밀번호 생성
		for (int i = 0; i < length; i++) {
			// chars에서 랜덤으로 하나의 문자를 선택하여 password에 추가
			password.append(chars.charAt(random.nextInt(chars.length())));
		}
		return password.toString();
	}
	
	// 비밀번호 찾기 3. 생성한 임시 비밀번호를 메일로 전송
	@Override
	public int sendTempPw(String user_id, String tempPassword) {
		System.out.println("EmailServiceImpl.sendTempPw start....");

    	String user_email = ljd.getUserEmail(user_id);

    	SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("jxxxmxxn@gmail.com");
    	message.setTo(user_email);
    	message.setSubject("중삼대학교 HiVE 임시 비밀번호 발급");
    	message.setText("회원님의 임시 비밀번호는 " + tempPassword + " 입니다.\n로그인 후 꼭 비밀번호를 변경해주세요.");
    	 	
    	int result = 0;
        
        try {
            mailSender.send(message); // 이메일 전송
            System.out.println("임시 비밀번호가 발송되었습니다.");
            result = 1;
            
        } catch (Exception e) {
            System.err.println("이메일 전송 실패: " + e.getMessage());
            result = 0;
        }
        return result;
	}

	

}
