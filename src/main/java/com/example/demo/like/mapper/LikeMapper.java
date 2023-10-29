package com.example.demo.like.mapper;

import com.example.demo.receive.DTO.ReceiveResponseDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface LikeMapper {

    // 즐겨찾기 목록 (받은메일함)
    List<ReceiveResponseDTO> selectAllByLike(@Param("id") String id);

    // 휴지통으로 이동
    void deleteItemInLike(@Param("no") String no, @Param("trash") String trash);

    // 휴지통, 즐겨찾기, 스팸메일 세부 사항
    ReceiveResponseDTO getAdditionDetail(@Param("no") String no);
}
