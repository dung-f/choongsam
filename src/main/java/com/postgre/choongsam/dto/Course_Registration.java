package com.postgre.choongsam.dto;

import lombok.Data;

@Data
public class Course_Registration {	// 수강신청
	private String 		lctr_id;		  	// 강의번호
	private int    		user_seq;	  	// 회원번호(학생)
	private String 		aply_date;	  	// 신청일
	private String 		reg_state;	  	// 수강상태명
	private String 		pay_date;	  	// 결제일
	private String 		pay_state;	  	// 결제상태명
	private String 		refund_date;	// 환불일
	private int	   		atndc_scr;	  	// 출석점수
	private int	   		asmt_scr;	  	// 과제점수합
	private int	   		total_scr;	  	// 총점수
	private int	   		lctr_schd_rt;  	// 차시진행율
	
	// 정민 추가 학생 이름 조회용 , 강의 강사 이름 조회용
	private String std_name;
	private String prof_name;
	
	
	private String 		ONOFF;
	private String 		LCTR_NAME;
	private int 	    CLASS_COUNT;
}
