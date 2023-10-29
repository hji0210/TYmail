package com.example.demo.receive.mapper;

import com.example.demo.receive.DTO.ReceiveResponseDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;


@Mapper
public interface ReceiveMapper {

    void saveReceiveMail(ReceiveResponseDTO receiveResponseDTO);

    // 받은메일함(내림차순)
    List<ReceiveResponseDTO> getReceiveMailListById(@Param("id") String id);

    // 필터
    List<ReceiveResponseDTO> getReceiveMailListByFilter(@Param("id") String id, @Param("filter") String filter);

    // 중요 메일 업데이트
    void updateLikeChecked(@Param("no") String no, @Param("likeChecked") String likeChecked);

    // 읽음, 안읽음 상태 업데이트
    void updateReadStatus(@Param("no") String no, @Param("readStatus") String readStatus);

    // 삭제 (휴지통으로 이동)
    void updateTrash(@Param("no") String no, @Param("trash") String trash);

    // 메일 세부 사항
    ReceiveResponseDTO getReceiveMailDetail(@Param("no") String no);

    // paging_게시물 총개수(받은메일함)
    int count(String id);

    // paging_받은메일함(내림차순)
    List<ReceiveResponseDTO> getReceiveMailListPageById(@Param("id") String id, @Param("firstRow")int firstRow, @Param("lastRow")int lastRow);

	List<ReceiveResponseDTO> selectSearchMail(HashMap<String, String> search);
}
