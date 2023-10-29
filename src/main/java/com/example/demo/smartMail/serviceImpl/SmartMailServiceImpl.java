package com.example.demo.smartMail.serviceImpl;

import com.example.demo.receive.DTO.ReceiveResponseDTO;
import com.example.demo.smartMail.enums.EmailAddress;
import com.example.demo.smartMail.enums.KeywordCharge;
import com.example.demo.smartMail.enums.SnsEmailAddress;
import com.example.demo.smartMail.mapper.SmartMailMapper;
import com.example.demo.smartMail.service.SmartMailService;
import com.example.demo.spam.enums.KeywordSpam;
import kr.co.shineware.nlp.komoran.constant.DEFAULT_MODEL;
import kr.co.shineware.nlp.komoran.core.Komoran;
import kr.co.shineware.nlp.komoran.model.KomoranResult;
import kr.co.shineware.nlp.komoran.model.Token;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

@Service
public class SmartMailServiceImpl implements SmartMailService {

    private static final Komoran KOMORAN = new Komoran(DEFAULT_MODEL.FULL);
    private static final String KOMORAN_NNG = "NNG";
    private static final String KOMORAN_NNP = "NNP";
    private final SmartMailMapper smartMailMapper;

    public SmartMailServiceImpl(SmartMailMapper smartMailMapper) {
        this.smartMailMapper = smartMailMapper;
    }

    // 스마트 메일함 (프로모션)
    @Override
    public List<ReceiveResponseDTO> getMailListByPromotion(String id) {
        List<ReceiveResponseDTO> receiveResponseDTOList = smartMailMapper.getReceiveMailByNotMember(id);
        receiveResponseDTOList.removeAll(excludeMail(receiveResponseDTOList));
        receiveResponseDTOList.removeAll(getSpamMailListForPromotion(id)); // 추가
        return sortMailListDesc(receiveResponseDTOList.stream()).collect(Collectors.toList());
    }

    // 광고가 아닌 메일 List
    private List<ReceiveResponseDTO> excludeMail(List<ReceiveResponseDTO> receiveResponseDTOList) {
        List<ReceiveResponseDTO> excludedResponseDTOList = new ArrayList<>();

        excludedResponseDTOList.addAll(
                filterMailListBySns(receiveResponseDTOList.stream()).collect(Collectors.toList())
        );

        excludedResponseDTOList.addAll(
                filterMailListByCharge(receiveResponseDTOList.stream()).collect(Collectors.toList())
        );

        excludedResponseDTOList.addAll(
                filterMailListByEmailAddress(receiveResponseDTOList.stream()).collect(Collectors.toList())
        );

        return excludedResponseDTOList;
    }

    // 스마트 메일함 (청구 및 결제)
    @Override
    public List<ReceiveResponseDTO> getMailListByCharge(String id) {
        return sortMailListDesc(filterMailListByCharge(smartMailMapper.getReceiveMailByNotMember(id).stream()))
                .collect(Collectors.toList());
    }

    // 스마트 메일함 (SNS)
    @Override
    public List<ReceiveResponseDTO> getMailListBySns(String id) {
        return sortMailListDesc(filterMailListBySns(smartMailMapper.getReceiveMailByNotMember(id).stream()))
                .collect(Collectors.toList());
    }

    // 필터 및 정렬 (프로모션)
    @Override
    public List<ReceiveResponseDTO> getMailListByPromotionFilteredAndSorted(String id, String filter, String sort) {
        List<ReceiveResponseDTO> receiveResponseDTOList = smartMailMapper.getSmartReceiveMailListFiltered(id, filter);
        receiveResponseDTOList.removeAll(excludeMail(receiveResponseDTOList));
        receiveResponseDTOList.removeAll(getSpamMailListForPromotion(id)); // 추가
        if (sort.equals("0")) {
            return sortMailListDesc(receiveResponseDTOList.stream()).collect(Collectors.toList());
        }
        return sortMailListAsc(receiveResponseDTOList.stream()).collect(Collectors.toList());
    }

    // 필터 및 정렬 (청구 및 결제)
    @Override
    public List<ReceiveResponseDTO> getMailListByChargeFilteredAndSorted(String id, String filter, String sort) {
        if (sort.equals("0")) {
            return sortMailListDesc(filterMailListByCharge(smartMailMapper.getSmartReceiveMailListFiltered(id, filter).stream()))
                    .collect(Collectors.toList());
        }
        return sortMailListAsc(filterMailListByCharge(smartMailMapper.getSmartReceiveMailListFiltered(id, filter).stream()))
                .collect(Collectors.toList());
    }

    // 필터 와 정렬 (sns)
    @Override
    public List<ReceiveResponseDTO> getMailListBySnsFilteredAndSorted(String id, String filter, String sort) {
        if (sort.equals("0")) {
            return sortMailListDesc(filterMailListBySns(smartMailMapper.getSmartReceiveMailListFiltered(id, filter).stream()))
                    .collect(Collectors.toList());
        }
        return sortMailListAsc(filterMailListBySns(smartMailMapper.getSmartReceiveMailListFiltered(id, filter).stream()))
                .collect(Collectors.toList());
    }

    // 스마트 메일함 세부 사항 (프로모션)
    @Override
    public ReceiveResponseDTO getMailDetailByPromotion(String no, String id) {
        List<ReceiveResponseDTO> receiveResponseDTOList = getMailListByPromotion(id);

        ReceiveResponseDTO targetReceiveResponseDTO = null;
        for (ReceiveResponseDTO receiveResponseDTO : receiveResponseDTOList) {
            if(receiveResponseDTO.getNo().equals(no)) {
                targetReceiveResponseDTO = receiveResponseDTO;
                break;
            }
        }
        return targetReceiveResponseDTO;
    }

    // 스마트 메일함 세부 사항 (청구 및 결제)
    @Override
    public ReceiveResponseDTO getMailDetailByCharge(String no, String id) {
        List<ReceiveResponseDTO> receiveResponseDTOList = getMailListByCharge(id);

        ReceiveResponseDTO targetReceiveResponseDTO = null;
        for (ReceiveResponseDTO receiveResponseDTO : receiveResponseDTOList) {
            if(receiveResponseDTO.getNo().equals(no)) {
                targetReceiveResponseDTO = receiveResponseDTO;
                break;
            }
        }
        return targetReceiveResponseDTO;
    }

    // 스마트 메일함 세부 사항 (SNS)
    @Override
    public ReceiveResponseDTO getMailDetailBySns(String no, String id) {
        List<ReceiveResponseDTO> receiveResponseDTOList = getMailListBySns(id);

        ReceiveResponseDTO targetReceiveResponseDTO = null;
        for (ReceiveResponseDTO receiveResponseDTO : receiveResponseDTOList) {
            if(receiveResponseDTO.getNo().equals(no)) {
                targetReceiveResponseDTO = receiveResponseDTO;
                break;
            }
        }
        return targetReceiveResponseDTO;
    }

    // 필터 와 정렬 세부 사항 (프로모션)
    @Override
    public ReceiveResponseDTO getMailDetailByPromotionFilteredAndSorted(String no,
                                                                        String id,
                                                                        String filter,
                                                                        String sort) {
        List<ReceiveResponseDTO> receiveResponseDTOList = getMailListByPromotionFilteredAndSorted(id, filter, sort);

        ReceiveResponseDTO targetReceiveResponseDTO = null;
        for (ReceiveResponseDTO receiveResponseDTO : receiveResponseDTOList) {
            if(receiveResponseDTO.getNo().equals(no)) {
                targetReceiveResponseDTO = receiveResponseDTO;
                break;
            }
        }
        return targetReceiveResponseDTO;
    }

    // 필터 와 정렬 세부 사항 (청구 및 결제)
    @Override
    public ReceiveResponseDTO getMailDetailByChargeFilteredAndSorted(String no,
                                                                     String id,
                                                                     String filter,
                                                                     String sort) {
        List<ReceiveResponseDTO> receiveResponseDTOList = getMailListByChargeFilteredAndSorted(id, filter, sort);

        ReceiveResponseDTO targetReceiveResponseDTO = null;
        for (ReceiveResponseDTO receiveResponseDTO : receiveResponseDTOList) {
            if(receiveResponseDTO.getNo().equals(no)) {
                targetReceiveResponseDTO = receiveResponseDTO;
                break;
            }
        }
        return targetReceiveResponseDTO;
    }

    // 필터 와 정렬 세부 사항 (SNS)
    @Override
    public ReceiveResponseDTO getMailDetailBySnsFilteredAndSorted(String no,
                                                                  String id,
                                                                  String filter,
                                                                  String sort) {
        List<ReceiveResponseDTO> receiveResponseDTOList = getMailListBySnsFilteredAndSorted(id, filter, sort);

        ReceiveResponseDTO targetReceiveResponseDTO = null;
        for (ReceiveResponseDTO receiveResponseDTO : receiveResponseDTOList) {
            if(receiveResponseDTO.getNo().equals(no)) {
                targetReceiveResponseDTO = receiveResponseDTO;
                break;
            }
        }
        return targetReceiveResponseDTO;
    }

    // 필터 : 프로모션 (이메일 필터)
    private Stream<ReceiveResponseDTO> filterMailListByEmailAddress(Stream<ReceiveResponseDTO> stream) {
        return stream.filter(it -> EmailAddress.containsEmailAddress(it.getSendEmail().substring(it.getSendEmail().lastIndexOf("@") + 1)));
    }

    // 필터 : 청구 및 결제
    private Stream<ReceiveResponseDTO> filterMailListByCharge(Stream<ReceiveResponseDTO> stream) {
        return stream.filter(it -> {
            String strToAnalyze = it.getTitle();
            KomoranResult analyzeResultList = KOMORAN.analyze(strToAnalyze);
            List<Token> tokenList = analyzeResultList.getTokenList();
            return tokenList.stream().anyMatch(this::isTitleInKeywordCharge);
        });
    }

    // 필터 : SNS
    private Stream<ReceiveResponseDTO> filterMailListBySns(Stream<ReceiveResponseDTO> stream) {
        return stream.filter(it -> SnsEmailAddress.containsSnsEmailAddress(it.getSendEmail()));
    }

    // 청구 및 결제 키워드 매칭 결과
    private boolean isTitleInKeywordCharge(Token token) {
        return (token.getPos().equals(KOMORAN_NNG) || token.getPos().equals(KOMORAN_NNP)) &&
                KeywordCharge.containsKeywordCharge(token.getMorph());
    }

    // 정렬 : 최신 순
    private Stream<ReceiveResponseDTO> sortMailListDesc(Stream<ReceiveResponseDTO> stream) {
        return stream.sorted(Comparator.comparing(ReceiveResponseDTO::getCreateAtLocalDateTime).reversed());
    }

    // 정렬 : 오래돤 순
    private Stream<ReceiveResponseDTO> sortMailListAsc(Stream<ReceiveResponseDTO> stream) {
        return stream.sorted(Comparator.comparing(ReceiveResponseDTO::getCreateAtLocalDateTime));
    }

    // paging_스마트 메일함 (프로모션)
    @Override
    public List<ReceiveResponseDTO> getMailListPageByPromotion(String id, int firstRow, int lastRow) {
        List<ReceiveResponseDTO> receiveResponseDTOList = getMailListByPromotion(id);
        receiveResponseDTOList.removeAll(getSpamMailListForPromotion(id)); // 추가
        return IntStream.rangeClosed((firstRow - 1), (lastRow - 1))
                .mapToObj(it -> receiveResponseDTOList.get(it))
                .collect(Collectors.toList());
    }

    // paging_스마트 메일함 (청구 및 결제)
    @Override
    public List<ReceiveResponseDTO> getMailListPageByCharge(String id, int firstRow, int lastRow) {
        List<ReceiveResponseDTO> receiveResponseDTOList = getMailListByCharge(id);
        return IntStream.rangeClosed((firstRow - 1), (lastRow - 1))
                .mapToObj(it -> receiveResponseDTOList.get(it))
                .collect(Collectors.toList());
    }

    // paging_스마트 메일함 (sns)
    @Override
    public List<ReceiveResponseDTO> getMailListPageBySns(String id, int firstRow, int lastRow) {
        List<ReceiveResponseDTO> receiveResponseDTOList = getMailListBySns(id);
        return IntStream.rangeClosed((firstRow - 1), (lastRow - 1))
                .mapToObj(it -> receiveResponseDTOList.get(it))
                .collect(Collectors.toList());
    }

    // paging_필터 와 정렬 (프로모션)
    @Override
    public List<ReceiveResponseDTO> getMailListPageByPromotionFilteredAndSorted(String id, String filter, String sort, int firstRow, int lastRow) {
        List<ReceiveResponseDTO> receiveResponseDTOList = getMailListByPromotionFilteredAndSorted(id, filter, sort);
        receiveResponseDTOList.removeAll(getSpamMailListForPromotion(id)); // 추가
        return IntStream.rangeClosed((firstRow - 1), (lastRow - 1))
                .mapToObj(it -> receiveResponseDTOList.get(it))
                .collect(Collectors.toList());
    }

    // paging_필터 와 정렬 (청구 및 결제)
    @Override
    public List<ReceiveResponseDTO> getMailListPageByChargeFilteredAndSorted(String id, String filter, String sort, int firstRow, int lastRow) {
        List<ReceiveResponseDTO> receiveResponseDTOList = getMailListByChargeFilteredAndSorted(id, filter, sort);
        return IntStream.rangeClosed((firstRow - 1), (lastRow - 1))
                .mapToObj(it -> receiveResponseDTOList.get(it))
                .collect(Collectors.toList());
    }

    // paging_필터 와 정렬 (sns)
    @Override
    public List<ReceiveResponseDTO> getMailListPageBySnsFilteredAndSorted(String id, String filter, String sort, int firstRow, int lastRow) {
        List<ReceiveResponseDTO> receiveResponseDTOList = getMailListBySnsFilteredAndSorted(id, filter, sort);
        return IntStream.rangeClosed((firstRow - 1), (lastRow - 1))
                .mapToObj(it -> receiveResponseDTOList.get(it))
                .collect(Collectors.toList());
    }

    // 스팸 메일 추출 !! 추가 !!
    public List<ReceiveResponseDTO> getSpamMailListForPromotion(String id) {
        List<ReceiveResponseDTO> mailList = smartMailMapper.getReceiveMailByNotMember(id);
        mailList.removeAll(excludeMail(mailList));

        List<ReceiveResponseDTO> receiveResponseDTOList = mailList
                .stream().filter(it -> !(it.getTitle().contains("광고")))
                .collect(Collectors.toList());

        return receiveResponseDTOList.stream()
                .filter(this::containsKeywordSpam)
                .collect(Collectors.toList());
    }

    // 스팸 메일 추출 !! 추가 !!
    private boolean containsKeywordSpam(ReceiveResponseDTO receiveResponseDTO) {
        String[] splitArr = receiveResponseDTO.getTitle().split(" ");

        return Arrays.stream(splitArr)
                .anyMatch(this::containsKeywordSpam);
    }

    // 스팸 메일 추출 !! 추가 !!
    private boolean containsKeywordSpam(String data) {
        KomoranResult komoranResult = KOMORAN.analyze(data);
        int lastIndex = komoranResult.getTokenList().size() - 1;

        return IntStream.range(1, lastIndex)
                .anyMatch(index -> {
                    Token token = komoranResult.getTokenList().get(index);
                    return KeywordSpam.containsKeywordSpam(token.getPos());
                });
    }

    // 스팸 메일 추출하기 위한 전처리 !! 추가 !!
    public List<ReceiveResponseDTO> getMailListByPromotionForSpam(String id) {
        List<ReceiveResponseDTO> receiveResponseDTOList = smartMailMapper.getReceiveMailByNotMember(id);
        receiveResponseDTOList.removeAll(excludeMail(receiveResponseDTOList));
        return sortMailListDesc(receiveResponseDTOList.stream()).collect(Collectors.toList());
    }
}
