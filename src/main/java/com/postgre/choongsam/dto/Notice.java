package com.postgre.choongsam.dto;

import lombok.Data;

@Data
public class Notice { // 공지사항
	private	int		ntc_mttr_sn;		// 공지 번호
	private int		user_seq;			// 회원 번호 (작성자)
	private	String	ntc_mttr_gubun;	// 구분 타입
	private	String	ntc_mttr_ttl;		// 공지 제목
	private	String	ntc_mttr_cn;		// 공지 내용
	private	String	ntc_mttr_dt;		// 공지 등록 날짜
	private String	 	ntc_mttr_yn;		// 공지 여부
	private String		lctr_id;				// 강의 번호
	private int		 	file_group;			// 파일 그룹
}
