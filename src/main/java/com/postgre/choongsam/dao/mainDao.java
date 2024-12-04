package com.postgre.choongsam.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.postgre.choongsam.dto.Lecture;
import com.postgre.choongsam.dto.Notice;
import com.postgre.choongsam.dto.User_Info;

import lombok.RequiredArgsConstructor;


@Repository
@RequiredArgsConstructor
public class mainDao {
	
	private final SqlSession session;

	public User_Info test() {
		
		User_Info test = session.selectOne("com.postgre.choongsam.mapper.test.selectTest");
		
		return test;
	}

	public List<Lecture> getLectureList() {
		
		List<Lecture> lecture = session.selectList("com.postgre.choongsam.mapper.test.getLectureList");
		return lecture;
	}

	public List<Notice> getNotice() {
		List<Notice> notice = session.selectList("com.postgre.choongsam.mapper.test.getNotice");
		return notice;
	}

}
