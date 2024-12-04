package com.postgre.choongsam.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.postgre.choongsam.dto.Attendance_Check;
import com.postgre.choongsam.dto.File_Group;
import com.postgre.choongsam.dto.Grade;
import com.postgre.choongsam.dto.Homework;
import com.postgre.choongsam.dto.Lecture;
import com.postgre.choongsam.service.JheService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;



@Controller
@RequestMapping(value="/Jhe")
@RequiredArgsConstructor
public class JheController {

	@Autowired
	private final JheService hes;

	@GetMapping(value = "/myLecture")
	public String getLectureHomeworkList(HttpSession session, Model model) {
		System.out.println("내 강의 리스트 컨트롤러");
		int user_seq = (int) session.getAttribute("user_seq");
		int user_status = (int) session.getAttribute("usertype");
		System.out.println("user_status: " + user_status);

		/*
		 * if (user_status == 1002) { List<Lecture> profLectureList =
		 * hes.getLectureHomeworkList(user_seq); model.addAttribute("homeworkList",
		 * profLectureList); System.out.println("profLectureList: " + profLectureList);
		 * 
		 * int onOff = profLectureList.stream() .map(Lecture::getOnoff) .findFirst()
		 * .orElse(0);
		 * 
		 * model.addAttribute("onoff",onOff); } else if (user_status == 1001) {
		 * List<Lecture> studLectureList = hes.studLecture(user_seq);
		 * model.addAttribute("homeworkList", studLectureList);
		 * System.out.println("studLectureList: " + studLectureList);
		 * 
		 * int onOff = studLectureList.stream() .map(Lecture::getOnoff) .findFirst()
		 * .orElse(0);
		 * 
		 * model.addAttribute("onoff",onOff); }
		 */

		List<Lecture> studLectureList = hes.studLecture(user_seq);
		model.addAttribute("homeworkList", studLectureList);
		System.out.println("studLectureList: " + studLectureList);
		
		int onOff = studLectureList.stream()
				.map(Lecture::getOnoff)
				.findFirst()
				.orElse(0);
		
		model.addAttribute("onoff",onOff);
		return "view_Jhe/myLecture";
	}

	@GetMapping(value = "/profLectureMain")
	public String profLectureMain(@RequestParam("lctr_id") String lctr_id, Model model) {
		System.out.println("강의 메인보드 컨트롤러");
		List<Lecture> profLectureList = hes.getProfLectureInfo(lctr_id);
		System.out.println("profLectureList: " + profLectureList);
		List<Homework> profHomeworkList = hes.getProfHomeworkList(lctr_id);
		System.out.println("profHomeworkList: " + profHomeworkList);

		if (!profLectureList.isEmpty()) {
			Lecture lecture = profLectureList.get(0);
			model.addAttribute("onoff", lecture.getOnoff());
			model.addAttribute("lctr_name",lecture.getLctr_name());
		}

		model.addAttribute("lctr_id", lctr_id);
		model.addAttribute("profHomeworkList", profHomeworkList);
		return "view_Jhe/profLectureMain";
	}

	@GetMapping(value = "/profHomeworkList")
	public String getProfHomeworkList(@RequestParam("lctr_id") String lctr_id, HttpSession session, Model model) {
		System.out.println("강의 과제 리스트 컨트롤러");
		List<Homework> profHomeworkList = hes.getProfHomeworkList(lctr_id);
		System.out.println("profHomeworkList: " + profHomeworkList);
		List<Homework> studSubmitList = hes.getStudSubmitList(lctr_id);
		System.out.println("studSubmitList: " + studSubmitList);

		int onOff = profHomeworkList.stream()
				.map(Homework::getOnoff)
				.findFirst()
				.orElse(0);

		model.addAttribute("onoff", onOff);
		model.addAttribute("lctr_id", lctr_id);
		model.addAttribute("profHomeworkList", profHomeworkList);
		model.addAttribute("studList", studSubmitList);
		return "view_Jhe/profHomeworkList";
	}

	@GetMapping(value = "/insertHomework")
	public String getInsHomework(@RequestParam("lctr_id") String lctr_id, Model model) {
		System.out.println("과제 등록하러 가자");
		System.out.println("과제등록 lctr_id: " + lctr_id);
		Homework homework = new Homework();
		homework.setLctr_id(lctr_id);
		System.out.println("lcid: " + homework.getLctr_id());
		Lecture findByLctrName = hes.findByLCTR(lctr_id);
		model.addAttribute("homework", homework);
		model.addAttribute("findByLctrName", findByLctrName);
		return "view_Jhe/insertHomework";
	}

	@PostMapping(value = "/insertHomework")
	public String insertHomework(@RequestParam("lctr_id") String lctr_id,
								 @RequestParam("asmt_nm") String asmtNm,
								 @RequestParam("sbmsn_bgng_ymd") String sbmsnBgngYmd,
								 @RequestParam("sbmsn_end_ymd") String sbmsnEndYmd,
								 @RequestParam("asmt_cn") String asmtCn,
								 @RequestParam("files") MultipartFile[] files,
								 @ModelAttribute Homework homework,
								 RedirectAttributes redirectAttributes,
								 HttpServletRequest request, Model model) {
		System.out.println("과제 등록 포오스트");
		System.out.println("강의 ID: " + lctr_id);

		homework.setLctr_id(lctr_id);
		int insHomeworkList = hes.insertHomework(homework, files, request);
		System.out.println("insHWList: " + insHomeworkList);

		if (insHomeworkList > 0) {
			hes.notifyStudents(lctr_id);
		}
		redirectAttributes.addFlashAttribute("status", insHomeworkList > 0 ? "success" : "failure");
		return insHomeworkList > 0 ? "redirect:/Jhe/profHomeworkList?lctr_id=" + lctr_id : "redirect:/Jhe/insertHomework";
	}

	@GetMapping(value = "/updateHomework")
	public String getUpdateHomework(@RequestParam int asmt_no, Model model) {
		System.out.println("과제 수정 겟");
		System.out.println("updateHomework 컨트롤러 asmt_no: " + asmt_no);
		Homework findByASMT = hes.findById(asmt_no);
		System.out.println("컨트롤러 findByASMT: " + findByASMT);
		model.addAttribute("upHomework", findByASMT);
		return "view_Jhe/updateHomework";
	}

	@PostMapping(value = "/updateHomework")
	public String updateHomework(@RequestParam("lctr_id") String lctr_id,
								 @RequestParam(value = "file", required = false) MultipartFile file,
								 @ModelAttribute Homework homework,
								 RedirectAttributes redirectAttributes, 
								 HttpServletRequest request) throws IOException {
		System.out.println("과제 수정 포오스트");

		// 파일이 업로드된 경우
		if (file != null && !file.isEmpty()) {
			File_Group uploadedFile = hes.uploadFile(file, request);
			// 업로드된 파일 정보로 file_nm 설정
			System.out.println(uploadedFile.getFile_nm());
			homework.setFile_nm(uploadedFile.getFile_nm());
		}
		int upHomeworkList = hes.updateHomework(homework, file, request);
		redirectAttributes.addFlashAttribute("status", upHomeworkList > 0 ? "success" : "failure");
		return "redirect:/Jhe/profHomeworkList?lctr_id=" + lctr_id;
	}

	@PostMapping("/deleteHomework")
	public String deleteHomework(@RequestParam("lctr_id") String lctr_id, @RequestParam List<Integer> delCheck, RedirectAttributes redirectAttributes) {
		System.out.println("과제 삭제를 해보까나");
		System.out.println("lctr_id: " + lctr_id);
		hes.deleteHomeworkList(delCheck);
		return "redirect:/Jhe/profHomeworkList?lctr_id=" + lctr_id;
	}

	@GetMapping(value = "/studHomeworkList")
	public String getStudHomeworkList(@RequestParam(value = "lctr_id", defaultValue = "0") String lctr_id, HttpSession session, Model model) {
		System.out.println("학생 강의 과제 리스트 깐따삐아");
		int user_seq = (int) session.getAttribute("user_seq");
		List<Homework> studHomeworkList = hes.getStudHomeworkList(user_seq);
		System.out.println(studHomeworkList);
		String lctrId = studHomeworkList.stream()
                .map(Homework::getLctr_id)
                .findFirst()
                .orElse("");
		int onOff = studHomeworkList.stream()
                .map(Homework::getOnoff)
                .findFirst()
                .orElse(0);
		
		model.addAttribute("onoff", onOff);
		model.addAttribute("lctr_id", lctrId);
		model.addAttribute("studHomeworkList", studHomeworkList);
		return "view_Jhe/studHomeworkList";
	}

	@GetMapping(value = "/submitHomework")
	public String getsubmitHomework(@RequestParam int asmt_no, Model model) {
		System.out.println("과제 제출 겟");
		Homework findByASMT = hes.findById(asmt_no);
		System.out.println("findByASMT: " + findByASMT);
		model.addAttribute("upHomework", findByASMT);
		return "view_Jhe/submitHomework";
	}

	@PostMapping(value = "/submitHomework")
	public String updatesubmitHomework(@RequestParam(value = "lctr_id", defaultValue = "0") String lctr_id,
									   @RequestParam int asmt_no, 
									   @RequestParam("files") MultipartFile file,
									   HttpSession session,
									   HttpServletRequest request) throws IOException {
		System.out.println("과제 제출 포오스트");
		System.out.println("ASMT_NO: " + asmt_no);
		int user_seq = (int) session.getAttribute("user_seq");
		int upsubmitHomework = hes.updatesubmitHomework(user_seq, asmt_no, file, request);
		System.out.println("upsubmitHomework: " + upsubmitHomework);
		return "redirect:/Jhe/studHomeworkList";
	}

	@GetMapping(value = "/checkHomework")
	public String checkHomework(@RequestParam int asmt_no, HttpSession session, Model model) {
		System.out.println("컨트롤러 checkHomework");
		int user_seq = (int) session.getAttribute("user_seq");
		Homework checkHomeworkList = hes.checkHomework(asmt_no, user_seq);
		System.out.println("checkHomework: " + checkHomeworkList);
		model.addAttribute("checkHomework", checkHomeworkList);
		return "view_Jhe/checkHomework";
	}

	@GetMapping("/profAttMain")
	public String profAttMain(@RequestParam("lctr_id") String lctr_id,
							  @RequestParam(value = "onoff", defaultValue = "0") int onoff, Model model) {
		System.out.println("컨트롤러 profAttMain onoff: " + onoff);
		if (onoff == 7002) {
			System.out.println("온라인 차시별 출석 현황 컨트롤러");
			List<Attendance_Check> profAttMainList = hes.getOnlineStudAtt(lctr_id);
			System.out.println("컨트롤러 온라인 출석 현황 profAttMainList: " + profAttMainList);
			int onOff = profAttMainList.stream()
					.map(Attendance_Check::getOnoff)
					.findFirst()
					.orElse(0);
			
			model.addAttribute("onoff", onOff);
			model.addAttribute("lctr_id", lctr_id);
			model.addAttribute("profAttMainList", profAttMainList);
		}

		System.out.println("오프라인 차시별 출석 현황 컨트롤러");
		List<Attendance_Check> profAttMainList = hes.profAttMain(lctr_id);
		System.out.println("컨트롤러 오프라인 출석 현황 profAttMainList: " + profAttMainList);
		int onOff = profAttMainList.stream()
				.map(Attendance_Check::getOnoff)
				.findFirst()
				.orElse(0);
		
		model.addAttribute("onoff", onOff);
		model.addAttribute("lctr_id", lctr_id);
		model.addAttribute("profAttMainList", profAttMainList);
		return "view_Jhe/profAttMain";
	}

	@GetMapping(value = "/insertStudAtt")
	public String getStudAtt(@RequestParam("lctr_id") String lctr_id,
							 @RequestParam int LCTR_NO,
							 @RequestParam int onoff, Model model) {
		System.out.println("차시별 수강생 출석 호출 컨트롤러");
		List<Attendance_Check> getStudAttList = hes.getStudAtt(lctr_id, LCTR_NO);
		System.out.println("getStudAttList: " + getStudAttList);
		model.addAttribute("getStudAttList", getStudAttList);
		model.addAttribute("lctr_id", lctr_id);
		model.addAttribute("LCTR_NO", LCTR_NO);
		model.addAttribute("onoff", onoff);
		return "view_Jhe/insertStudAtt";
	}

	@PostMapping(value = "/insertStudAtt")
	public String insertStudAtt(@RequestParam("lctr_id") String lctr_id,
								@RequestParam int LCTR_NO, @RequestParam int onoff,
								@RequestParam List<Integer> user_seq,
								@RequestParam Map<String, String> att_status, Model model) {
		System.out.println("차시별 출석 입력 컨트롤러");
		System.out.println("lctr_id: " + lctr_id);
		System.out.println("LCTR_NO: " + LCTR_NO);

		hes.updateStudAtt(lctr_id, LCTR_NO, user_seq, att_status, onoff);
		return "redirect:/Jhe/profAttMain?lctr_id=" + lctr_id + "&onoff=" + onoff;
	}

	@GetMapping(value = "/studLectureMain")
	public String studLectureMain(@RequestParam("lctr_id") String lctr_id, Model model) {
		System.out.println("학생 강의 메인보드 컨트롤러");
		List<Lecture> studLectureMainList = hes.studLectureMain(lctr_id);
		System.out.println("studLectureMainList: " + studLectureMainList);

		if (!studLectureMainList.isEmpty()) {
			Lecture lecture = studLectureMainList.get(0);
			model.addAttribute("onoff", lecture.getOnoff());
		}

		model.addAttribute("studLectureMain", studLectureMainList);
		model.addAttribute("lctr_id", lctr_id);
		return "view_Jhe/studLectureMain";
	}

	@GetMapping("/studAtt")
	public String studAtt(@RequestParam("lctr_id") String lctr_id, HttpSession session, Model model) {
		System.out.println("차시별 출석 현황");
		int user_seq = (int) session.getAttribute("user_seq");
		System.out.println("user_seq: " + user_seq);
		List<Attendance_Check> studAttList = hes.studAtt(lctr_id, user_seq);
		System.out.println("컨트롤러 studAttList: " + studAttList);

		int onOff = studAttList.stream()
                .map(Attendance_Check::getOnoff)
                .findFirst()
                .orElse(0);

		model.addAttribute("onoff", onOff);
		System.out.println("onoff: " +onOff);
		model.addAttribute("lctr_id", lctr_id);
		model.addAttribute("studAttList", studAttList);
		return "view_Jhe/studAtt";
	}

	@GetMapping("/profAttDetail")
	public String profAttDetail(@RequestParam("lctr_id") String lctr_id,
								@RequestParam int LCTR_NO, @RequestParam int onoff, Model model) {
		System.out.println("강사 차시별 수강생 출결 현황");
		List<Attendance_Check> profAttDetailList = hes.profAttDetail(lctr_id, LCTR_NO);
		model.addAttribute("onoff", onoff);
		model.addAttribute("lctr_id", lctr_id);
		model.addAttribute("profAttDetailList", profAttDetailList);
		return "view_Jhe/profAttDetail";
	}

	@GetMapping("/profGrade")
	public String profGrade(@RequestParam("lctr_id") String lctr_id, HttpSession session, Model model) {
		System.out.println("강사 수강생 성적 조회 컨트롤러");
		int user_seq = (int) session.getAttribute("user_seq");
		List<Grade> studentScoreList = hes.profGrade(lctr_id, user_seq);
		System.out.println("controller studentScoreList: " + studentScoreList);
		int onOff = studentScoreList.stream()
				.map(Grade::getOnoff)
				.findFirst()
				.orElse(0);

		model.addAttribute("onoff", onOff);
		model.addAttribute("lctr_id", lctr_id);
		model.addAttribute("studentScoreList", studentScoreList);
		return "view_Jhe/profGrade";
	}

	@GetMapping("/updateStudGrade/{userSeq}/{lctr_id}")
	public String updateStudGrade(@PathVariable Integer userSeq,
								  @PathVariable String lctr_id, Model model) {
		System.out.println("강사 수강생 성적 수정폼 컨트롤러");
		Grade updateGrade = hes.getupdateGrade(userSeq, lctr_id);
		model.addAttribute("upGrade", updateGrade);
		return "view_Jhe/updateStudGrade";
	}

	@PostMapping(value = "/updateStudGrade")
	public String updateGrade(@RequestParam("userSeq") Integer userSeq,
							  @RequestParam("lctr_id") String lctr_id,
							  @RequestParam("atndc_scr") int atndcScr,
							  @RequestParam("asmt_scr") int asmtScr,
							  @RequestParam("last_scr") int lastScr) {
		System.out.println("강사 수강생 성적 수정 컨트롤러");
		hes.updateGrade(userSeq, lctr_id, atndcScr, asmtScr, lastScr);
		return "redirect:/Jhe/profGrade?lctr_id=" + lctr_id;
	}

	@GetMapping("/studGrade")
	public String studGrade(@RequestParam(value = "lctr_id", defaultValue = "0") String lctr_id, HttpSession session, Model model) {
		System.out.println("수강생 내 성적 조회 컨트롤러");
		int user_seq = (int) session.getAttribute("user_seq");
		List<Grade> myGradeList = hes.studGrade(lctr_id, user_seq);
		int onOff = myGradeList.stream()
				.map(Grade::getOnoff)
				.findFirst()
				.orElse(0);

		model.addAttribute("onoff", onOff);
		model.addAttribute("lctr_id", lctr_id);
		model.addAttribute("myGradeList", myGradeList);
		return "view_Jhe/studGrade";
	}

	@GetMapping("/studGradeDetail")
	public String studGradeDetail(@RequestParam("lctr_id") String lctr_id, HttpSession session, Model model) {
		System.out.println("수강생 내 성적 상세 조회 컨트롤러");
		int user_seq = (int) session.getAttribute("user_seq");
		List<Grade> myGradeDetailList = hes.studGradeDetail(lctr_id, user_seq);
		model.addAttribute("myGradeDetailList", myGradeDetailList);
		return "view_Jhe/studGradeDetail";
	}
}
