package com.postgre.choongsam.service;

import com.postgre.choongsam.dto.Login_Info;
import com.postgre.choongsam.dto.User_Info;

public interface LjmService {

	Login_Info login(String user_id, String password);

	int signup(Login_Info login_Info, User_Info user_info);

	int confirmId(String user_id);

	String findId(User_Info user_info);

	String getUserName(int user_seq);

	User_Info findPw(User_Info user_info);

	String createTempPassword(String user_id);

	int sendTempPw(String user_id, String tempPassword);

	Login_Info adminLogin(String user_id, String password);

	User_Info getUserStatus(String user_id);
	
}
