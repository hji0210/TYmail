package com.example.demo.spam.service;

import com.example.demo.receive.DTO.ReceiveResponseDTO;

import java.util.List;

public interface SpamService {

    // 스팸 메일 목록
    List<ReceiveResponseDTO> getSpamMailList(String id);

    // 휴지통으로 이동 (체크박스)
    void deleteItemsInSpam(String[] no);

    // 휴지통으로 이동 (메일 세부 사항)
    void deleteItemInSpam(String no);
}
