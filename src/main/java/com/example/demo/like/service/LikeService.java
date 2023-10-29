package com.example.demo.like.service;

import com.example.demo.receive.DTO.ReceiveResponseDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LikeService {

    // 즐겨찾기 목록 (받은메일함)
    List<ReceiveResponseDTO> selectAllByLike(String id);

    // 휴지통으로 이동 (체크박스)
    void deleteItemsInLike(String[] no);

    // 휴지통으로 이동 (메일 세부 사항)
    void deleteItemInLike(String no);

    // 휴지통, 즐겨찾기, 스팸메일 세부 사항
    ReceiveResponseDTO getAdditionDetail(@Param("no") String no);
}
