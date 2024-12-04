package com.postgre.choongsam.dto;

import lombok.Data;

@Data
public class Homework_Submission {
	private int		user_seq;		// 회원 번호 (학생)
	private	int		asmt_no;		// 과제 번호
	private int		asmt_scr;		// 과제 점수
	private	String	sbmsn_yn;		// 제출 여부
	private	String	sbmsn_ymd;		// 제출 일시
	private int		file_group;		// 파일 그룹
	private String	lctr_id;		// 강의 번호
}
