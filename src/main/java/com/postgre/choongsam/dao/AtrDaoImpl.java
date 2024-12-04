package com.postgre.choongsam.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.postgre.choongsam.dto.Classroom;
import com.postgre.choongsam.dto.Lecture;
import com.postgre.choongsam.dto.Syllabus;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AtrDaoImpl implements AtrDao {

	public final SqlSession session;
	private final PlatformTransactionManager transactionManager;

	@Override
	public String registerCourse(Lecture lecture) {
		System.out.println("AtrDao register Course");
		String courseId = "";
		try {
			session.insert("trRegisterCourse", lecture);
			courseId = lecture.getLctr_id();
			System.out.println("AtrDaoImpl registerCourse lecture->" + lecture);
		} catch (Exception e) {
			System.out.println("trRegisterCourse" + e.getMessage());
		}
		return courseId;
	}

	@Override
	public void registerSyllabus(String courseDetail, String parameter, int lctr_no) {
		try {
			session.insert("trRegisterSyllabus",
					Map.of("courseDetail", courseDetail, "parameter", parameter, "lctr_no", lctr_no));
		} catch (Exception e) {
			System.out.println("trRegisterSyllabus" + e.getMessage());
		}

	}

	@Override
	public List<Lecture> getAllLectureList() {
		List<Lecture> lectureList = null;
		try {
			lectureList = session.selectList("trGetAllLectureList");
		} catch (Exception e) {
			System.out.println("trGetAllLectureList" + e.getMessage());
		}
		return lectureList;
	}

	@Override
	public Lecture getLectureDetail(String lctr_id) {
		Lecture lecture = new Lecture();
		try {
			lecture = session.selectOne("trGetLectureDetail", lctr_id);
		} catch (Exception e) {
			System.out.println("trGetLectureDetail" + e.getMessage());
		}
		return lecture;
	}

	@Override
	public boolean overlapCheck(String schd, String lctr_room) {
		boolean result = true;
		try {
			System.out.println(schd + "aa" + lctr_room);
			int aa = 0;
			aa = session.selectOne("trOverlapCheck", Map.of("schd", schd, "lctr_room", lctr_room));
			System.out.println("ㅇㅇ" + aa);
			if (aa != 0) {
				System.out.println("ㅇㅇㅇ");
				result = false;
			}
		} catch (Exception e) {
			System.out.println("trGetLectureDetail" + e.getMessage());
		}

		return result;
	}

	@Override
	public void addClassRoom(String parameter, String parameter2, String parameter3) {
		try {
			session.insert("trAddClassRoom", Map.of("lctr_id", parameter, "schd", parameter2, "lctr_room", parameter3));
		} catch (Exception e) {
			System.out.println("trAddClassRoom" + e.getMessage());
		}

	}

	@Override
	public List<Classroom> getAllClassRoom() {
		List<Classroom> classroomList = new ArrayList<>();
		try {
			classroomList = session.selectList("trGetAllClassRoom");
			System.out.println(classroomList);
		} catch (Exception e) {
			System.out.println("trGetAllClassRoom" + e.getMessage());
		}
		return classroomList;
	}

	@Override
	public void approveCourse(String parameter) {
		try {
			session.update("trApproveCourse", parameter);
		} catch (Exception e) {
			System.out.println("trApproveCourse" + e.getMessage());
		}

	}

	@Override
	public List<Lecture> getRecruitLectureList() {
		List<Lecture> lectureList = null;
		try {
			lectureList = session.selectList("trGetRecruitLectureList");
		} catch (Exception e) {
			System.out.println("trGetAllLectureList" + e.getMessage());
		}
		return lectureList;
	}

	@Override
	public void applyCourse(String lctr_id, String student_id) {
		TransactionStatus txStatus= transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			session.insert("trApplyCourse", Map.of("lctr_id", lctr_id, "student_id", Integer.parseInt(student_id)));
			session.update("trRaiseRegisterCount", lctr_id);
			transactionManager.commit(txStatus);	
		} catch (Exception e) {
			System.out.println(e.getMessage());
			transactionManager.rollback(txStatus);
		}
	}

	@Override
	public List<Syllabus> getSyllabus(String lctr_id) {
		List<Syllabus> syllabusList = null;
	 try {
		 syllabusList=session.selectList("trGetSyllabus",lctr_id);
	} catch (Exception e) {
		System.out.println(e.getMessage());
	}
		return syllabusList;
	}

	@Override
	public void changeLectureState(String parameter, String parameter2) {
		try {
			session.update("trChangeLectureState", Map.of("lctr_id", parameter, "lctr_state", Integer.parseInt(parameter2)));
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
	}

}
