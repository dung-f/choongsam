package com.postgre.choongsam.dto;

import lombok.Data;

@Data
public class File_Group { // 첨부파일
	private int 		file_group; 			// 파일 그룹(일련번호)
	private int 		file_seq; 				// 소일련번호
	private String 	idntf_no; 				// 식별번호
	private String 	file_nm; 				// 실제파일명
	private String 	file_extn_nm; 			// 확장자
	private int 		file_sz; 				// 파일 크기
	private String 	file_path_nm; 			// 파일 경로
}
