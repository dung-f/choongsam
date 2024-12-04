package com.postgre.choongsam.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.postgre.choongsam.dao.mainDao;
import com.postgre.choongsam.dto.Lecture;
import com.postgre.choongsam.dto.Notice;
import com.postgre.choongsam.dto.User_Info;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class mainService {

	private final mainDao md;
	
	public User_Info test() {
		User_Info test = md.test();
		
		return test;
		
	}

	public List<Lecture> getLectureList() {
		
		List<Lecture> lecture = md.getLectureList();
		
		return lecture;
	}

	public List<Notice> getNotice() {
		List<Notice> notice = md.getNotice();
		return notice;
	}
}
