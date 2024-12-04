package com.postgre.choongsam.dao;

import com.postgre.choongsam.dto.Login_Info;
import com.postgre.choongsam.dto.User_Info;

public interface LjmDao {

	Login_Info login(String user_id);

	int signup(Login_Info login_Info, User_Info user_info);

	int confirmId(String user_id);

	String findId(User_Info user_info);

	String getUserName(int user_seq);

	String getUserEmail(String user_id);

	User_Info findPw(User_Info user_info);

	void updateTempPw(String user_id, String hashedTempPw);

	Login_Info adminLogin(String user_id);

	User_Info getUserInfo(String user_id);
	
}
