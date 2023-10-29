package com.example.demo.smartMail.service;

import com.example.demo.receive.DTO.ReceiveResponseDTO;

import java.util.List;

public interface SmartMailService {

    // 스마트 메일함 (프로모션)
    List<ReceiveResponseDTO> getMailListByPromotion(String id);

    // 스마트 메일함 (청구 및 결제)
    List<ReceiveResponseDTO> getMailListByCharge(String id);

    // 스마트 메일함 (SNS)
    List<ReceiveResponseDTO> getMailListBySns(String id);

    // 필터 와 정렬 (프로모션)
    List<ReceiveResponseDTO> getMailListByPromotionFilteredAndSorted(String id, String filter, String sort);

    // 필터 와 정렬 (청구 및 결제)
    List<ReceiveResponseDTO> getMailListByChargeFilteredAndSorted(String id, String filter, String sort);

    // 필터 와 정렬 (sns)
    List<ReceiveResponseDTO> getMailListBySnsFilteredAndSorted(String ID, String filter, String sort);


    // 디테일이요!!!!!!!!!!

    // 스마트 메일함 세부 사항 (프로모션)
    ReceiveResponseDTO getMailDetailByPromotion(String no, String id);

    // 스마트 메일함 세부 사항 (청구 및 결제)
    ReceiveResponseDTO getMailDetailByCharge(String no, String id);

    // 스마트 메일함 세부 사항 (SNS)
    ReceiveResponseDTO getMailDetailBySns(String no, String id);

    // 필터 와 정렬 세부 사항 (프로모션)
    ReceiveResponseDTO getMailDetailByPromotionFilteredAndSorted(String no, String id, String filter, String sort);

    // 필터 와 정렬 세부 사항 (청구 및 결제)
    ReceiveResponseDTO getMailDetailByChargeFilteredAndSorted(String no, String id, String filter, String sort);

    // 필터 와 정렬 세부 사항 (SNS)
    ReceiveResponseDTO getMailDetailBySnsFilteredAndSorted(String no, String id, String filter, String sort);

    // paging_스마트 메일함 (프로모션)
    List<ReceiveResponseDTO> getMailListPageByPromotion(String id, int firstRow, int lastRow);

    // paging_스마트 메일함 (청구 및 결제)
    List<ReceiveResponseDTO> getMailListPageByCharge(String id, int firstRow, int lastRow);

    // paging_스마트 메일함 (sns)
    List<ReceiveResponseDTO> getMailListPageBySns(String id, int firstRow, int lastRow);

    // paging_필터 와 정렬 (프로모션)
    List<ReceiveResponseDTO> getMailListPageByPromotionFilteredAndSorted(String id, String filter, String sort, int firstRow, int lastRow);

    // paging_필터 와 정렬 (청구 및 결제)
    List<ReceiveResponseDTO> getMailListPageByChargeFilteredAndSorted(String id, String filter, String sort, int firstRow, int lastRow);

    // paging_필터 와 정렬 (sns)
    List<ReceiveResponseDTO> getMailListPageBySnsFilteredAndSorted(String id, String filter, String sort, int firstRow, int lastRow);
    
    List<ReceiveResponseDTO> getMailListByPromotionForSpam(String id);
}
