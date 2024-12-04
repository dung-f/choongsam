package com.postgre.choongsam.dto;

import lombok.Data;

@Data
public class Attendance_Check {
	private	int		lctr_no;			// 차시
	private	String	lctr_id;			// 강의 번호
	private int		user_seq;			// 회원 번호 (학생)
	private	int		att_status;			// 출석 상태
	private String	lctr_name;			// 강의명
	private int		reg_count;			// 수강인원
	private int		lctr_cntschd;		// 총 차시
	private int		present_count;		// 출석 수
	private int		late_count;			// 지각 수
	private int		absent_count;		// 결석 수
	private int		attendance_rate;	// 출석률
	private String	user_name;			// 회원 이름
	private String	stud_name;			// 학생 이름
	private int		onoff;				// 온오프라인 여부
	private int		atndc_scr;			// 출석 점수
	private int		asmt_scr;			// 과제 점수
	private int		last_scr;			// 최종 성적
	private String	fnsh_yn;			// 수료 여부
	private String	sbmsn_Yn;			// 과제 제출 여부
}
