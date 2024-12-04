package com.postgre.choongsam.dto;

import lombok.Data;

@Data
public class Login_Info {			// 로그인 정보
	private int	   	user_seq;       //회원번호
    private String 	user_id;		//아이디
    private String 	password;		//비밀번호
    private int    	pw_err_num;		//암호오류횟수
    private String 	last_login;		//최근접속일
    private int 	user_status;	// 회원분류

}
