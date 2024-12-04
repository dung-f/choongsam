package com.postgre.choongsam.dto;

import lombok.Data;

@Data
public class Comm { // 공통코드
	private int 		group_cd;		// 구분
	private int 		cd;				// 코드
	private String 	cd_nm;		// 코드명
}
