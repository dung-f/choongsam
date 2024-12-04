package com.postgre.choongsam.dto;

import lombok.Data;

@Data
public class Syllabus { // 강의 계획서 상세(차시)
	
	private int 		lctr_no;				// 차시
	private String 	lctr_id;					// 강의번호
	private String 	conts_id;				// 영상번호
	private int user_seq;
	private String 	lctr_otln;				// 강의개요

}