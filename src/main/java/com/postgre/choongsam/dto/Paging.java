package com.postgre.choongsam.dto;

import lombok.Data;

// NOTE : 페이징을 위한 DTO
@Data
public class Paging {
    private int currentPage;            // 현재 페이지
    private int rowPage;                  // 한 페이지에 보여줄 데이터 수
    private int pageBlock;               // 한 번에 보여줄 페이지 블록 수
    private int start;                         // 데이터 시작 번호
    private int end;                          // 데이터 끝 번호
    private int startPage;               // 페이지 블록의 시작 페이지
    private int endPage;                // 페이지 블록의 끝 페이지
    private int total;                        // 전체 데이터 개수
    private int totalPage;               // 전체 페이지 수
    //private boolean prev;              // 이전 페이지 블록 존재 여부
    //private boolean next;              // 다음 페이지 블록 존재 여부

    // 기본 생성자
    public Paging() {
        this.rowPage = 10;              // 기본값 설정 (페이지당 데이터 수)
        this.pageBlock = 5;             // 기본값 설정 (한 번에 보여줄 페이지 블록 수)
        this.currentPage = 1;           // 기본값 설정 (첫 페이지)
    }

    public Paging(int total, String currentPage1) {
        this.total = total; // 전체 데이터 개수 설정
    
        if (currentPage1 != null) {
            this.currentPage = Integer.parseInt(currentPage1);
        } else {
            this.currentPage = 1; // 기본값 설정
        }
    
        // 기본값을 보장하기 위해 rowPage가 0인지 확인
        if (rowPage == 0) {
            rowPage = 10; // 기본 페이지당 데이터 수 설정
        }
    
        // 기본값을 보장하기 위해 pageBlock이 0인지 확인
        if (pageBlock == 0) {
            pageBlock = 5; // 기본 페이지 블록 수 설정
        }
    
        start = (currentPage - 1) * rowPage;
        end = start + rowPage;
    
        // 전체 페이지 수 계산 (rowPage가 0이 아님을 확인했으므로 안전)
        totalPage = (int) Math.ceil((double) total / rowPage);
    
        startPage = currentPage - (currentPage - 1) % pageBlock;
        endPage = startPage + pageBlock - 1;
    
        // 페이지 블록의 끝이 totalPage를 넘지 않도록 조정
        if (endPage > totalPage) {
            endPage = totalPage;
        }
    }
    

  
}
