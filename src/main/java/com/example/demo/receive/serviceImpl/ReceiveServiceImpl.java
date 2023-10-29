package com.example.demo.receive.serviceImpl;

import com.example.demo.receive.DTO.ReceiveResponseDTO;
import com.example.demo.receive.DTO.ReceiveUpdateTrashRequestDTO;
import com.example.demo.receive.mapper.ReceiveMapper;
import com.example.demo.receive.service.ReceiveService;
import com.example.demo.spam.service.SpamService;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Service
public class ReceiveServiceImpl implements ReceiveService {

    private final ReceiveMapper receiveMapper;

    private final SpamService spamService;

    public ReceiveServiceImpl(ReceiveMapper receiveMapper, SpamService spamService) {
        this.receiveMapper = receiveMapper;
        this.spamService = spamService;
    }

    @Override
    public void saveReceiveMail(ReceiveResponseDTO receiveResponseDTO) {
        receiveMapper.saveReceiveMail(receiveResponseDTO);
    }

    // 받은메일함(내림차순)
    @Override
    public List<ReceiveResponseDTO> getReceiveMailListById(String id) {
        List<ReceiveResponseDTO> receiveResponseDTOList = receiveMapper.getReceiveMailListById(id).stream()
                .sorted(Comparator.comparing(ReceiveResponseDTO::getCreateAtLocalDateTime).reversed())
                .collect(Collectors.toList());

        // 스팸 메일 제거
        receiveResponseDTOList.removeAll(spamService.getSpamMailList(id));
        return receiveResponseDTOList;
    }

    // 필터
    @Override
    public List<ReceiveResponseDTO> getReceiveMailListByFilterAndSort(String id, String filter, String sort) {
        Comparator<ReceiveResponseDTO> comparator = Comparator.comparing(ReceiveResponseDTO::getCreateAtLocalDateTime);

        if (sort.equals("0")) {
            comparator = comparator.reversed();
        }

        List<ReceiveResponseDTO> receiveResponseDTOList = receiveMapper.getReceiveMailListByFilter(id, filter).stream()
                .sorted(comparator)
                .collect(Collectors.toList());

        // 스팸 메일 제거
        receiveResponseDTOList.removeAll(spamService.getSpamMailList(id));
        return receiveResponseDTOList;

    }

    // 중요 메일 업데이트
    @Override
    public void updateLikeChecked(String no, String likeChecked) {
        receiveMapper.updateLikeChecked(no, likeChecked);
    }

    // 읽음, 안읽음 상태 업데이트
    @Override
    public void updateReadStatus(String no, String readStatus) {
        receiveMapper.updateReadStatus(no, readStatus);
    }

    // 삭제 (휴지통으로 이동)
    @Override
    public void updateTrash(ReceiveUpdateTrashRequestDTO receiveUpdateTrashRequestDTO) {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd.HH:mm:ss");

        Map<String, String> map = new HashMap<>();
        Arrays.stream(receiveUpdateTrashRequestDTO.getSelectedItems()).forEach(it -> {
            String no = it;
            String trash = now.format(formatter);
            receiveMapper.updateTrash(no, trash);
        });
    }

    // 삭제 (휴지통으로 이동 / 메일 세부 사항)
    @Override
    public void updateTrashOne(String no) {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd.HH:mm:ss");

        String trash = now.format(formatter);
        receiveMapper.updateTrash(no, trash);
    }

    // 메일 세부 사항
    @Override
    public ReceiveResponseDTO getReceiveMailDetail(String no) {
        return receiveMapper.getReceiveMailDetail(no);
    }

    // paging_게시물 총개수(받은메일함)
    @Override
    public int count(String id) {
        if (spamService.getSpamMailList(id).isEmpty()) {
            return receiveMapper.count(id);
        }
        return (receiveMapper.count(id) - spamService.getSpamMailList(id).size());
    }

    // paging_받은메일함(내림차순)
    @Override
    public List<ReceiveResponseDTO> getReceiveMailListPageById(String id, int firstRow, int lastRow) {
        Comparator<ReceiveResponseDTO> comparator = Comparator.comparing(ReceiveResponseDTO::getCreateAtLocalDateTime).reversed();
        // 전체 메일
        List<ReceiveResponseDTO> receiveResponseDTOList = receiveMapper.getReceiveMailListById(id).stream().sorted(comparator).collect(Collectors.toList());

        // 스팸 메일 제거
        receiveResponseDTOList.removeAll(spamService.getSpamMailList(id));
        return IntStream.rangeClosed((firstRow - 1), (lastRow - 1))
                .mapToObj(it -> receiveResponseDTOList.get(it))
                .collect(Collectors.toList());
    }

    // Paging_필터
    @Override
    public List<ReceiveResponseDTO> getReceiveMailListPageByFilterAndSort(String id, String filter, String sort, int firstRow, int lastRow) {
        Comparator<ReceiveResponseDTO> comparator = Comparator.comparing(ReceiveResponseDTO::getCreateAtLocalDateTime);

        if (sort.equals("0")) {
            comparator = comparator.reversed();
        }

        List<ReceiveResponseDTO> receiveResponseDTOList = receiveMapper.getReceiveMailListByFilter(id, filter).stream()
                .sorted(comparator)
                .collect(Collectors.toList());

        // 스팸 메일 제거
        receiveResponseDTOList.removeAll(spamService.getSpamMailList(id));
        return IntStream.rangeClosed((firstRow - 1), (lastRow - 1))
                .mapToObj(it -> receiveResponseDTOList.get(it))
                .collect(Collectors.toList());
    }

    @Override
    public List<ReceiveResponseDTO> selectSearchMail(HashMap<String, String> search) {
       // TODO Auto-generated method stub
       return receiveMapper.selectSearchMail(search); //수정
    } 
	
	
}