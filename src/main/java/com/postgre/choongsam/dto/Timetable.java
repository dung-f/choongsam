package com.postgre.choongsam.dto;

import lombok.Data;

@Data
public class Timetable { // 시간표
	private String lctr_id;		// 강의번호
	private String lctr_hr;		// 강의시간
	private String lctr_room;	// 강의실명
}
