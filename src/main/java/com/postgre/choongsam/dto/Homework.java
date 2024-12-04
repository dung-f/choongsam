package com.postgre.choongsam.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class Homework  { // 과제 
    private int        asmt_no;        // 과제 번호
    private String    lctr_id;        // 강의 번호
    private String    asmt_nm;        // 과제 제목
    private    String    asmt_cn;        // 과제 내용
    private    String    sbmsn_bgng_ymd;    // 과제 제출 시작일
    private String    sbmsn_end_ymd;    // 과제 제출 마감일
    private int        file_group;        // 파일 그룹

    private String    prof_name;        // 강사명
    private String    stud_name;        // 학생명
	private int		  onoff;			// 대면 여부
    private String	  lctr_name;		// 과제명
    private int        user_status;    // 회원 분류
    private String    asmtStatus;        // 과제 등록 상태
    private String     user_id;        // 회원 아이디
    private int        user_seq;        // 회원 번호
    private String    sbmsn_yn;        // 과제 제출 여부
    private int        submissionRate; // 제출률
    private MultipartFile file;
    private String    file_nm;        // 파일명
    private int		  assigned_file_group;	// 강사 첨부파일 그룹
    private String	  assigned_file;		// 강사 첨부파일명
    private int		  submitted_file_group;	// 학생 첨부파일 그룹
    private String	  submitted_file;		// 학생 첨부파일명
}