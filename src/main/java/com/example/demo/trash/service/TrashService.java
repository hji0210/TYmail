package com.example.demo.trash.service;

import com.example.demo.receive.DTO.ReceiveResponseDTO;

import java.util.List;

public interface TrashService {

    // 휴지통 목록 (받은메일함)
    List<ReceiveResponseDTO> selectAll(String id);

    // 수동으로 받은메일함 영구 삭제 (체크박스)
    void deleteFromReceive(String[] no);

    // 메일 세부 사항 영구 삭제 (수동)
    void deleteOneFromReceive(String no);

    // 받은메일함으로 이동
    void moveToReceive(String[] no);

    // 받은메일함으로 이동 (메일 세부 사항)
    void moveOneToReceive(String no);

    // 중요 메일 업데이트
    void updateLikeChecked(String no, String likeChecked);

    // 읽음, 안읽음 상태 업데이트
    void updateReadStatus(String no, String readStatus);

}
