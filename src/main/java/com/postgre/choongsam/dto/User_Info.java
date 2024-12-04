package com.postgre.choongsam.dto;

import lombok.Data;

@Data
public class User_Info {	// 회원정보
	private int    	user_seq; 			//회원번호
	private String 	user_id;			//아이디
	private String 	user_name;			//이름
	private String 	birth;				//생년월일
	private String 	profile_name;		//증명사진명
	private String 	profile_addr;		//증명사진명로
	private String 	address;			//주소
	private String 	email;				//메일
	private String 	phone_num;			//전화번호
	private String 	del_state;			//삭제여부
	private int    	file_group;      	//파일그룹	
	private String  addr_detail;		//상세주소
	private int    	USER_STATUS;

}
