package com.example.demo.receive.service;

import com.example.demo.receive.DTO.ReceiveResponseDTO;
import com.example.demo.receive.DTO.ReceiveUpdateTrashRequestDTO;

import java.util.HashMap;
import java.util.List;

public interface ReceiveService {

    void saveReceiveMail(ReceiveResponseDTO receiveResponseDTO);

    // 받은메일함(내림차순)
    List<ReceiveResponseDTO> getReceiveMailListById(String id);

    // 필터
    List<ReceiveResponseDTO> getReceiveMailListByFilterAndSort(String id, String filter, String sort);

    // 중요 메일 업데이트
    void updateLikeChecked(String no, String likeChecked);

    // 읽음, 안읽음 상태 업데이트
    void updateReadStatus(String no, String readStatus);

    // 삭제 (휴지통으로 이동)
    void updateTrash(ReceiveUpdateTrashRequestDTO receiveUpdateTrashRequestDTO);

    // 삭제 (휴지통으로 이동 / 메일 세부 사항)
    void updateTrashOne(String no);

    // 메일 세부 사항
    ReceiveResponseDTO getReceiveMailDetail(String no);

    // paging_게시물 총개수(받은메일함)
    int count(String id);

    // paging_받은메일함(내림차순)
    List<ReceiveResponseDTO> getReceiveMailListPageById(String id, int firstRow, int lastRow);

    // paging_필터
    List<ReceiveResponseDTO> getReceiveMailListPageByFilterAndSort(String id, String filter, String sort, int firstRow, int lastRow);
	
	List<ReceiveResponseDTO> selectSearchMail(HashMap<String, String> search);
}
