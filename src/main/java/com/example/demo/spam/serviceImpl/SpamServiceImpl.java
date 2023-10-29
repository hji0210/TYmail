package com.example.demo.spam.serviceImpl;

import com.example.demo.receive.DTO.ReceiveResponseDTO;
import com.example.demo.smartMail.service.SmartMailService;
import com.example.demo.spam.enums.KeywordSpam;
import com.example.demo.spam.mapper.SpamMapper;
import com.example.demo.spam.service.SpamService;
import kr.co.shineware.nlp.komoran.constant.DEFAULT_MODEL;
import kr.co.shineware.nlp.komoran.core.Komoran;
import kr.co.shineware.nlp.komoran.model.KomoranResult;
import kr.co.shineware.nlp.komoran.model.Token;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Service
public class SpamServiceImpl implements SpamService {

    private static final Komoran KOMORAN = new Komoran(DEFAULT_MODEL.FULL);

    private final SmartMailService smartMailService;
    private final SpamMapper spamMapper;

    public SpamServiceImpl(SmartMailService smartMailService, SpamMapper spamMapper) {
        this.smartMailService = smartMailService;
        this.spamMapper = spamMapper;
    }

    // 스팸 메일 목록
    @Override
    public List<ReceiveResponseDTO> getSpamMailList(String id) {
        List<ReceiveResponseDTO> receiveResponseDTOList = smartMailService
                .getMailListByPromotionForSpam(id)
                .stream().filter(it -> !(it.getTitle().contains("광고")))
                .collect(Collectors.toList());

        return receiveResponseDTOList.stream()
                .filter(this::containsKeywordSpam)
                .collect(Collectors.toList());
    }

    // 휴지통으로 이동 (체크박스)
    @Override
    public void deleteItemsInSpam(String[] no) {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd.HH:mm:ss");

        Arrays.stream(no).forEach(it -> {
            String index = it;
            String trash = now.format(formatter);
            spamMapper.deleteItemInSpam(index, trash);
        });
    }

    // 휴지통으로 이동 (메일 세부 사항)
    @Override
    public void deleteItemInSpam(String no) {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd.HH:mm:ss");

        String trash = now.format(formatter);
        spamMapper.deleteItemInSpam(no, trash);
    }

    private boolean containsKeywordSpam(ReceiveResponseDTO receiveResponseDTO) {
        String[] splitArr = receiveResponseDTO.getTitle().split(" ");

        return Arrays.stream(splitArr)
                .anyMatch(this::containsKeywordSpam);
    }

    private boolean containsKeywordSpam(String data) {
        KomoranResult komoranResult = KOMORAN.analyze(data);
        int lastIndex = komoranResult.getTokenList().size() - 1;

        return IntStream.range(1, lastIndex)
                .anyMatch(index -> {
                    Token token = komoranResult.getTokenList().get(index);
                    return KeywordSpam.containsKeywordSpam(token.getPos());
                });
    }

}

