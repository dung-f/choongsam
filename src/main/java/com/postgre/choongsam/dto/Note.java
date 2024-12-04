package com.postgre.choongsam.dto;

import lombok.Data;

@Data
public class Note { // 쪽지
	private	int	note_sn;		// 쪽지 번호
	private	int	bfr_note_sn;	// 이전 쪽지 번호
	private	int		sndpty_seq;	// 회원 번호 (발신)
	private	int		rcvr_seq;		// 회원 번호 (수신)
	private	String	dsptch_dt;		// 쪽지 발신 일시
	private 	String	 rcptn_dt;		// 쪽지 수신 일시
	private	String	note_ttl;		// 쪽지 제목
	private	String	note_cn;		// 쪽지 내용
	private	String	sndpty_note_yn;	// 발신자 삭제 여부
	private	String	rcvr_note_yn;	// 수신자 삭제 여부
	
	private String sender_name; // 수신자 이름
	private String receiver_name; // 발신자 이름

	private int std_seq;
	private int inst_seq;
	private String std_name;
	private String inst_name;

}
