package com.postgre.choongsam.dto;

import lombok.Data;

@Data
public class Ask { // 문의사항
	private int	dscsn_sn;			// 문의 번호
	private int		user_seq;			// 회원 번호 (문의자)
	private String	dscsn_ttl;			// 문의 제목
	private	String	dscsn_cn;			// 문의 내용
	private String	dscsn_reg_dt;		// 문의 등록 일시
	private int		dscsn_ans_seq;	// 회원 번호 (답변자)
	private	String	dscsn_ans_cn;	// 답변 내용
	private String	dscsn_ans_dt;	// 답변 등록 일시
	private	String	dscsn_ans_yn;	// 답변 완료 여부
}
