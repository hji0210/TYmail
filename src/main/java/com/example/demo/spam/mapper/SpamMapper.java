package com.example.demo.spam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SpamMapper {

    // 휴지통으로 이동
    void deleteItemInSpam(@Param("no") String no, @Param("trash") String trash);

}
