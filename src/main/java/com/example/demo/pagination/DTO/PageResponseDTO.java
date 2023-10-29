package com.example.demo.pagination.DTO;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class PageResponseDTO<T> {

    int page;              // 페이지 번호
    int size;              // 한 화면에 출력될 게시물 개수
    final int PAGE_LENGTH; // 한 화면에 출력될 페이지 개수
    int start;             // 페이지 시작 번호
    int end;               // 페이지 끝 번호

    int total;             // 전체 페이지 개수

    boolean prev;          // 이전
    boolean next;          // 다음

    List<T> dtoList;       // 게시물 목록

    public PageResponseDTO(int page,
                           int size,
                           int PAGE_LENGTH,
                           int total,
                           List<T> dtoList) {

        // 페이지 가장 마지막 번호
        int lastPage = (int) Math.ceil((double) total / size);

        this.page = page;
        this.size = size;
        this.total = total;
        this.PAGE_LENGTH = PAGE_LENGTH;
        this.dtoList = dtoList;

        this.start = (((page / PAGE_LENGTH) * PAGE_LENGTH) + 1);
        this.end = Math.min(lastPage, (start + (PAGE_LENGTH - 1)));
        this.prev = start != 1;
        this.next = lastPage > end;
    }

}
