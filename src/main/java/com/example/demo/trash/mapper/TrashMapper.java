package com.example.demo.trash.mapper;

import com.example.demo.receive.DTO.ReceiveResponseDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TrashMapper {

    // 휴지통 목록 (받은메일함)
    List<ReceiveResponseDTO> selectAll(@Param("id") String id);

    // 영구 삭제
    void deleteFromReceive(@Param("no") String no);

    // 받은메일함으로 이동
    void moveToReceive(@Param("no") String no);

    // 중요 메일 업데이트
    void updateLikeChecked(@Param("no") String no, @Param("likeChecked") String likeChecked);

    // 읽음, 안읽음 상태 업데이트
    void updateReadStatus(@Param("no") String no, @Param("readStatus") String readStatus);

    // DB 내 모든 목록 조회
    List<ReceiveResponseDTO> selectAllForCleanup();

}
