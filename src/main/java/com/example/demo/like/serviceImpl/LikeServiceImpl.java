package com.example.demo.like.serviceImpl;

import com.example.demo.like.mapper.LikeMapper;
import com.example.demo.like.service.LikeService;
import com.example.demo.receive.DTO.ReceiveResponseDTO;
import com.example.demo.spam.service.SpamService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;

@Service
public class LikeServiceImpl implements LikeService {

    @Autowired
    private LikeMapper likeMapper;

    @Autowired
    private SpamService spamService;

    // 즐겨찾기 목록 (받은메일함)
    @Override
    public List<ReceiveResponseDTO> selectAllByLike(String id) {
        List<ReceiveResponseDTO> receiveResponseDTOList = likeMapper.selectAllByLike(id);
        receiveResponseDTOList.removeAll(spamService.getSpamMailList(id));
        return receiveResponseDTOList;
    }

    // 휴지통으로 이동 (체크박스)
    @Override
    public void deleteItemsInLike(String[] no) {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd.HH:mm:ss");

        Arrays.stream(no).forEach(it -> {
            String index = it;
            String trash = now.format(formatter);
            likeMapper.deleteItemInLike(index, trash);
        });
    }

    // 휴지통으로 이동 (메일 세부 사항)
    @Override
    public void deleteItemInLike(String no) {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd.HH:mm:ss");

        String trash = now.format(formatter);
        likeMapper.deleteItemInLike(no, trash);
    }

    // 휴지통, 즐겨찾기, 스팸메일 세부 사항
    @Override
    public ReceiveResponseDTO getAdditionDetail(String no) {
        return likeMapper.getAdditionDetail(no);
    }
}
