package com.postgre.choongsam.dto;

import lombok.Data;

@Data
public class Class_Schedule {	// 차시 진행 현황

	private	int			lctr_no;		// 차시
	private	String		lctr_id;			// 강의 번호
	private	String		conts_id;		// 영상 번호
	private int			user_seq;		// 학생 번호
	private	long		conts_final;	// FINAL 위치
	private	long		conts_max;	// MAX 위치
	private long		conts_prgrt;	// 강의진행율

}
