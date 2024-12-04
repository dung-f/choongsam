package com.postgre.choongsam.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.postgre.choongsam.dto.Classroom;
import com.postgre.choongsam.dto.Lecture;
import com.postgre.choongsam.dto.Paging;
import com.postgre.choongsam.dto.Syllabus;
import com.postgre.choongsam.service.AtrService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AtrController {

	private final AtrService as;

	@RequestMapping(value = "/registerCourseForm")
	public String registerCourseForm() {

		return "view_Atr/registerCourseForm";
	}

	@RequestMapping(value = "/registerCourse")
	public String registerCourse(HttpServletRequest request, Lecture lecture, Model model) {
		System.out.println("Tr Service registerCourse Start");

		String CourseId = as.registerCourse(lecture);
		System.out.println(lecture.getLctr_cntschd());
		model.addAttribute("classCount", lecture.getLctr_cntschd());
		model.addAttribute("CourseId", CourseId);

		return "view_Atr/registerCourseForm2";
	}

	@RequestMapping(value = "/registerCourse2")
	public String registerCourse2(HttpServletRequest request, Model model) {
		System.out.println("Tr Service registerCourse Start");

		for (int i = 0; i <= Integer.parseInt(request.getParameter("classCount")); i++) {
			String courseDetail = request.getParameter("course" + i);
			if (courseDetail != null && !courseDetail.isEmpty()) {
				as.registerSyllabus(courseDetail, request.getParameter("lctrId"), i);
			}
		}

		return "main";
	}

	@RequestMapping(value = "/courseApproveList")
	public String courseApproveList(@RequestParam(value = "page", required = false) String currentPage, Model model) {
		List<Lecture> lectureList = as.getAllLectureList();
		int total = lectureList.size(	); // 전체 강의 수

		// 페이징 객체 생성
		Paging paging = new Paging(total, currentPage);
		List<Lecture> paginatedLectureList = lectureList.subList(Math.min(paging.getStart(), total),
				Math.min(paging.getEnd(), total));

		model.addAttribute("lectureList", paginatedLectureList);
		model.addAttribute("paging", paging);
		return "view_Atr/courseApproveList";
	}
	@RequestMapping(value = "/courseApplyList")
	public String courseApplyList(@RequestParam(value = "page", required = false) String currentPage, Model model) {
		List<Lecture> lectureList = as.getRecruitLectureList();
		int total = lectureList.size(	); // 전체 강의 수
		
		// 페이징 객체 생성
		Paging paging = new Paging(total, currentPage);
		List<Lecture> paginatedLectureList = lectureList.subList(Math.min(paging.getStart(), total),
				Math.min(paging.getEnd(), total));
		
		model.addAttribute("lectureList", paginatedLectureList);
		model.addAttribute("paging", paging);
		return "view_Atr/courseApplyList";
	}

	@RequestMapping(value = "/lectureDetail")
	public String lectureDetail(HttpServletRequest request, Model model, String lctr_id) {
		System.out.println("TrlectureDetail Start");

		Lecture lecture = new Lecture();
		lecture = as.getLectureDetail(lctr_id);
		List<Syllabus> syllabusList= as.getSyllabus(lctr_id);
		model.addAttribute("syllabusList", syllabusList);
		if(!lecture.getLctr_state().equals("개설 허가 대기중")) {
			model.addAttribute("lecture", lecture);
			return "view_Atr/courseDetailAdmin";
		}
		

		if(lecture.getOnoff_tr().equals("대면")) {

			List<Classroom> classroomList=as.getAllClassRoom();
			String schdTGemp = "";
			System.out.println("addClassRoomForm schd->" + lecture.getLctr_schd());
			List<String> schdList = new ArrayList<>();
			StringTokenizer st = new StringTokenizer(lecture.getLctr_schd(), ", ");
			while (st.hasMoreTokens()) {
				schdTGemp = st.nextToken();
				System.out.println(schdTGemp);
				schdList.add(schdTGemp);
			}
			model.addAttribute("lecture", lecture);
			model.addAttribute("classroomList", classroomList);
			model.addAttribute("lctr_id", lctr_id);
			model.addAttribute("schdList", schdList);
			return "view_Atr/offCourseApprove";
		}
		else{
			model.addAttribute("lecture", lecture);
			System.out.println("비대면");
			return "view_Atr/onCourseApprove";
		}
		
	}
	@RequestMapping(value = "/courseApplyDetail")
	public String courseApplyDetail(HttpServletRequest request, Model model, String lctr_id) {
		
		
		Lecture lecture = new Lecture();
		lecture = as.getLectureDetail(lctr_id);
		List<Syllabus> syllabusList= as.getSyllabus(lctr_id);
		model.addAttribute("syllabusList", syllabusList);
		model.addAttribute("lecture", lecture);
		return "view_Atr/courseApplyDetail";
		
	}

	@RequestMapping(value = "/approveOfflineCourse")
	public String addClassRoom(HttpServletRequest request, Model model) {
		System.out.println("www");
		System.out.println(request.getParameter("count"));
		for(int i=0; i <Integer.parseInt(request.getParameter("count")); i++) {
			as.addClassRoom(request.getParameter("lctr_id"),request.getParameter("schd"+i),request.getParameter("lctr_room"+i));
		}
		as.approveCourse(request.getParameter("lctr_id"));
		return "redirect:courseApproveList";
	}
	@RequestMapping(value = "/approveOnlineCourse")
	public String approveOnlineCourse(HttpServletRequest request, Model model) {
		as.approveCourse(request.getParameter("lctr_id"));
		return "redirect:courseApproveList";
	}
	@RequestMapping(value = "/applyCourse")
	public String applyCourse(HttpServletRequest request, Model model) {
		as.applyCourse(request.getParameter("lctr_id"),request.getParameter("student_id"));
		return "redirect:courseApplyList";
	}
	@RequestMapping(value = "/changeLectureState")
	public String changeLectureState(HttpServletRequest request, Model model) {
		as.changeLectureState(request.getParameter("lctr_id"),request.getParameter("lctr_state"));
		return "redirect:lectureDetail?lctr_id="+request.getParameter("lctr_id");
	}

	@GetMapping(value = "/overlapCheck")
     @ResponseBody 
     public boolean confirmId(@RequestParam("schd") String schd,@RequestParam("lctr_room") String lctr_room) {
         System.out.println("LjmController confirmId() start...");
         boolean result =as.overlapCheck(schd, lctr_room);
         return result;
     }

}
