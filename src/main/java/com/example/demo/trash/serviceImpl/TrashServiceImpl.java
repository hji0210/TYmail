package com.example.demo.trash.serviceImpl;

import com.example.demo.receive.DTO.ReceiveResponseDTO;
import com.example.demo.trash.service.TrashService;
import com.example.demo.trash.mapper.TrashMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;

@EnableScheduling
@Service
public class TrashServiceImpl implements TrashService {

    @Autowired
    private TrashMapper trashMapper;

    // 휴지통 목록 (받은메일함)
    @Override
    public List<ReceiveResponseDTO> selectAll(String id) {
        return trashMapper.selectAll(id);
    }

    // 수동으로 받은메일함 영구 삭제 (체크박스)
    @Override
    public void deleteFromReceive(String[] no) {
        Arrays.stream(no).forEach(it -> trashMapper.deleteFromReceive(it));
    }

    // 메일 세부 사항 영구 삭제 (수동)
    @Override
    public void deleteOneFromReceive(String no) {
        trashMapper.deleteFromReceive(no);
    }

    // 받은메일함으로 이동
    @Override
    public void moveToReceive(String[] no) {
        Arrays.stream(no).forEach(it -> trashMapper.moveToReceive(it));
    }

    // 받은메일함으로 이동 (메일 세부 사항)
    @Override
    public void moveOneToReceive(String no) {
        trashMapper.moveToReceive(no);
    }

    // 중요 메일 업데이트
    @Override
    public void updateLikeChecked(String no, String likeChecked) {
        trashMapper.updateLikeChecked(no, likeChecked);
    }

    // 읽음, 안읽음 상태 업데이트
    @Override
    public void updateReadStatus(String no, String readStatus) {
        trashMapper.updateReadStatus(no, readStatus);
    }

    // 휴지통에 있는 30일 이전 받은메일은 모두 삭제 진행
    @Scheduled(fixedRate = 60000)
    public void cleanupOldMails() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd.HH:mm:ss");
        LocalDateTime thirtyDaysAgo = LocalDateTime.now().minusDays(30);

        trashMapper.selectAllForCleanup().stream().forEach(it -> {
            LocalDateTime dateTime = LocalDateTime.parse(it.getTrash(), formatter);
            if (dateTime.isBefore(thirtyDaysAgo)) {
                trashMapper.deleteFromReceive(it.getNo());
            }
        });
        System.out.println("success");
    }
}
