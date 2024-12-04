package com.postgre.choongsam.dto;

import lombok.Data;

@Data
public class Class_Bookmark {	// 영상 북마크
	private	String		conts_id;			// 영상 번호
	private	Integer		conts_chptime;	// 챕터 시간
	private 	String			conts_chpttl;		// 챕터 내용
	
	//챕터 북마크 버퍼 추가 -성희
	private	Integer 	conts_chptime_sec1;	// 챕터 시간 (초)
	private	Integer 	conts_chptime_sec2;	// 챕터 시간 (초)
	private	String		conts_chpttl2;		// 챕터 내용
	private	Integer		conts_chptime_sec3;	// 챕터 시간 (초)
	private	String		conts_chpttl3;		// 챕터 내용
}
