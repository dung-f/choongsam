package com.postgre.choongsam.dto;

import lombok.Data;

@Data
public class Lecture_Video {
	private	String	conts_id;		// 영상 번호
	private	String	vdo_file_nm;	// 영상 제목
	private	String	vdo_url_addr;	// 영상 URL 주소

	private String	viewing_period;	// 시청 가능 기간
	private	int	vdo_length;		// 영상 길이

	private	int		lctr_no;		// 차시
	private 	int		file_group;		// 파일 그룹
	
	private String file_data; //테스트용
}
