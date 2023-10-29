package com.example.demo.smartMail.mapper;

import com.example.demo.receive.DTO.ReceiveResponseDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SmartMailMapper {
    List<ReceiveResponseDTO> getReceiveMailByNotMember(@Param("id") String id);
    List<ReceiveResponseDTO> getSmartReceiveMailListFiltered(@Param("id") String id, @Param("filter") String filter);

}
