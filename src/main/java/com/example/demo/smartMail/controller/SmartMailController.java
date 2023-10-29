package com.example.demo.smartMail.controller;

import com.example.demo.pagination.DTO.PageResponseDTO;
import com.example.demo.receive.DTO.ReceiveResponseDTO;
import com.example.demo.receive.service.ReceiveService;
import com.example.demo.smartMail.service.SmartMailService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class SmartMailController {

    // paging
    private int PAGE_CORRECTION = 1;
    private final int PAGE_LENGTH = 10;

    private final ReceiveService receiveService; 
    private final SmartMailService smartMailService;
    
    public SmartMailController(SmartMailService smartMailService, ReceiveService receiveService) {
        this.smartMailService = smartMailService;
        this.receiveService = receiveService;
    }

    // paging_스마트 메일함 (프로모션)
    @RequestMapping("/smart/promotion")
    public String findMailListByPromotion(HttpSession session,
                                          Model model,
                                          @RequestParam("page") Integer page, @RequestParam(value = "size", defaultValue = "5") Integer size) {

        String id = String.valueOf(session.getAttribute("userId"));

        int total = smartMailService.getMailListByPromotion(id).size();
        page -= PAGE_CORRECTION;

        int firstRow = (page * size) + 1;
        int lastRow = firstRow + 4;
        if (lastRow > total) {
            lastRow = total;
        }

        List<ReceiveResponseDTO> receiveResponseDTOList = smartMailService.getMailListPageByPromotion(id, firstRow, lastRow);
        PageResponseDTO<ReceiveResponseDTO> pageResponseDTO = new PageResponseDTO<>(page, size, PAGE_LENGTH, total, receiveResponseDTOList);

        model.addAttribute("category", "promotion");
        model.addAttribute("receiveResponseDTOList", pageResponseDTO.getDtoList());
        model.addAttribute("page", pageResponseDTO.getPage() + 1);
        model.addAttribute("pageTotal", pageResponseDTO.getTotal());
        model.addAttribute("pageStart", pageResponseDTO.getStart());
        model.addAttribute("pageEnd", pageResponseDTO.getEnd());
        model.addAttribute("prev", pageResponseDTO.isPrev());
        model.addAttribute("next", pageResponseDTO.isNext());

        return "receive/receiveList";
    }

    // paging_스마트 메일함 (청구 및 결제)
    @RequestMapping("/smart/charge")
    public String findMailListByCharge(HttpSession session,
                                       Model model,
                                       @RequestParam("page") Integer page, @RequestParam(value = "size", defaultValue = "5") Integer size) {

        String id = String.valueOf(session.getAttribute("userId"));

        int total = smartMailService.getMailListByCharge(id).size();
        page -= PAGE_CORRECTION;

        int firstRow = (page * size) + 1;
        int lastRow = firstRow + 4;
        if (lastRow > total) {
            lastRow = total;
        }

        List<ReceiveResponseDTO> receiveResponseDTOList = smartMailService.getMailListPageByCharge(id, firstRow, lastRow);
        PageResponseDTO<ReceiveResponseDTO> pageResponseDTO = new PageResponseDTO<>(page, size, PAGE_LENGTH, total, receiveResponseDTOList);

        model.addAttribute("category", "charge");
        model.addAttribute("receiveResponseDTOList", pageResponseDTO.getDtoList());
        model.addAttribute("page", pageResponseDTO.getPage() + 1);
        model.addAttribute("pageTotal", pageResponseDTO.getTotal());
        model.addAttribute("pageStart", pageResponseDTO.getStart());
        model.addAttribute("pageEnd", pageResponseDTO.getEnd());
        model.addAttribute("prev", pageResponseDTO.isPrev());
        model.addAttribute("next", pageResponseDTO.isNext());

        return "receive/receiveList";
    }

    // paging_스마트 메일함 (sns)
    @RequestMapping("/smart/sns")
    public String findMailListBySns(HttpSession session, Model model,
                                    @RequestParam("page") Integer page, @RequestParam(value = "size", defaultValue = "5") Integer size) {

        String id = String.valueOf(session.getAttribute("userId"));

        int total = smartMailService.getMailListBySns(id).size();
        page -= PAGE_CORRECTION;

        int firstRow = (page * size) + 1;
        System.out.println(firstRow);
        int lastRow = firstRow + 4;
        if (lastRow > total) {
            lastRow = total;
        }

        List<ReceiveResponseDTO> receiveResponseDTOList = smartMailService.getMailListPageBySns(id, firstRow, lastRow);

        PageResponseDTO<ReceiveResponseDTO> pageResponseDTO = new PageResponseDTO<>(page, size, PAGE_LENGTH, total, receiveResponseDTOList);

        model.addAttribute("category", "sns");
        model.addAttribute("receiveResponseDTOList", pageResponseDTO.getDtoList());
        model.addAttribute("page", pageResponseDTO.getPage() + 1);
        model.addAttribute("pageTotal", pageResponseDTO.getTotal());
        model.addAttribute("pageStart", pageResponseDTO.getStart());
        model.addAttribute("pageEnd", pageResponseDTO.getEnd());
        model.addAttribute("prev", pageResponseDTO.isPrev());
        model.addAttribute("next", pageResponseDTO.isNext());

        return "receive/receiveList";
    }

    /**
     * 필터 와 정렬
     * @param filter (필터) 모든 메일 : all , 안읽은 메일 : unread, 중요 메일 : mark, 첨부 메일 : attach, 나에게 온 메일 : tome
     * @param sort (정렬) 최신 순 : 0, 오래된 순 : 1
     */

    // paging_필터 와 정렬 (프로모션)
    @RequestMapping("/smart/promotion/folder")
    public String findMailListByPromotionFilteredAndSorted(HttpSession session,
                                                           @RequestParam("filter") String filter,
                                                           @RequestParam("sort") String sort,
                                                           Model model,
                                                           @RequestParam("page") Integer page, @RequestParam(value = "size", defaultValue = "5") Integer size) {


        String id = String.valueOf(session.getAttribute("userId"));

        int total = smartMailService.getMailListByPromotionFilteredAndSorted(id, filter, sort).size();
        page -= PAGE_CORRECTION;

        int firstRow = (page * size) + 1;
        int lastRow = firstRow + 4;
        if (lastRow > total) {
            lastRow = total;
        }

        List<ReceiveResponseDTO> receiveResponseDTOList = smartMailService.getMailListPageByPromotionFilteredAndSorted(id, filter, sort, firstRow, lastRow);
        PageResponseDTO<ReceiveResponseDTO> pageResponseDTO = new PageResponseDTO<>(page, size, PAGE_LENGTH, total, receiveResponseDTOList);

        model.addAttribute("category", "promotionFolder");
        model.addAttribute("filter", filter);
        model.addAttribute("sort", sort);

        model.addAttribute("receiveResponseDTOList", pageResponseDTO.getDtoList());
        model.addAttribute("page", pageResponseDTO.getPage() + 1);
        model.addAttribute("pageTotal", pageResponseDTO.getTotal());
        model.addAttribute("pageStart", pageResponseDTO.getStart());
        model.addAttribute("pageEnd", pageResponseDTO.getEnd());
        model.addAttribute("prev", pageResponseDTO.isPrev());
        model.addAttribute("next", pageResponseDTO.isNext());
        return "receive/receiveList";
    }

    // paging_필터 와 정렬 (청구 및 결제)
    @RequestMapping("/smart/charge/folder")
    public String findMailListByChargeFilteredAndSorted(HttpSession session,
                                                        @RequestParam("filter") String filter,
                                                        @RequestParam("sort") String sort,
                                                        Model model,
                                                        @RequestParam("page") Integer page, @RequestParam(value = "size", defaultValue = "5") Integer size) {

        String id = String.valueOf(session.getAttribute("userId"));

        int total = smartMailService.getMailListByChargeFilteredAndSorted(id, filter, sort).size();
        page -= PAGE_CORRECTION;

        int firstRow = (page * size) + 1;
        int lastRow = firstRow + 4;
        if (lastRow > total) {
            lastRow = total;
        }

        List<ReceiveResponseDTO> receiveResponseDTOList = smartMailService.getMailListPageByChargeFilteredAndSorted(id, filter, sort, firstRow, lastRow);
        PageResponseDTO<ReceiveResponseDTO> pageResponseDTO = new PageResponseDTO<>(page, size, PAGE_LENGTH, total, receiveResponseDTOList);

        model.addAttribute("category", "chargeFolder");
        model.addAttribute("filter", filter);
        model.addAttribute("sort", sort);

        model.addAttribute("receiveResponseDTOList", pageResponseDTO.getDtoList());
        model.addAttribute("page", pageResponseDTO.getPage() + 1);
        model.addAttribute("pageTotal", pageResponseDTO.getTotal());
        model.addAttribute("pageStart", pageResponseDTO.getStart());
        model.addAttribute("pageEnd", pageResponseDTO.getEnd());
        model.addAttribute("prev", pageResponseDTO.isPrev());
        model.addAttribute("next", pageResponseDTO.isNext());
        return "receive/receiveList";
    }

    // paging_필터 와 정렬 (sns)
    @RequestMapping("/smart/sns/folder")
    public String findMailListBySnsFilteredAndSorted(HttpSession session,
                                                    @RequestParam("filter") String filter,
                                                    @RequestParam("sort") String sort,
                                                    Model model,
                                                     @RequestParam("page") Integer page, @RequestParam(value = "size", defaultValue = "5") Integer size) {

        String id = String.valueOf(session.getAttribute("userId"));

        int total = smartMailService.getMailListBySnsFilteredAndSorted(id, filter, sort).size();
        page -= PAGE_CORRECTION;

        int firstRow = (page * size) + 1;
        int lastRow = firstRow + 4;
        if (lastRow > total) {
            lastRow = total;
        }

        List<ReceiveResponseDTO> receiveResponseDTOList = smartMailService.getMailListPageBySnsFilteredAndSorted(id, filter, sort, firstRow, lastRow);
        PageResponseDTO<ReceiveResponseDTO> pageResponseDTO = new PageResponseDTO<>(page, size, PAGE_LENGTH, total, receiveResponseDTOList);

        model.addAttribute("category", "snsFolder");
        model.addAttribute("filter", filter);
        model.addAttribute("sort", sort);

        model.addAttribute("receiveResponseDTOList", pageResponseDTO.getDtoList());
        model.addAttribute("page", pageResponseDTO.getPage() + 1);
        model.addAttribute("pageTotal", pageResponseDTO.getTotal());
        model.addAttribute("pageStart", pageResponseDTO.getStart());
        model.addAttribute("pageEnd", pageResponseDTO.getEnd());
        model.addAttribute("prev", pageResponseDTO.isPrev());
        model.addAttribute("next", pageResponseDTO.isNext());

        return "receive/receiveList";
    }

    // 스마트 메일함 세부 사항 (프로모션)
    @RequestMapping("/smart/promotion/detail")
    public String mailDetailByPromotion(HttpSession session,
                                        @RequestParam("no") String no,
                                        @RequestParam("filter") String filter,
                                        @RequestParam("sort") String sort,
                                        @RequestParam("page") Integer page,
                                        Model model) {

        String id = String.valueOf(session.getAttribute("userId"));

        ReceiveResponseDTO receiveResponseDTO;
        if (filter.isEmpty() && sort.isEmpty()) {
            receiveResponseDTO = smartMailService.getMailDetailByPromotion(no, id);
        } else {
            receiveResponseDTO = smartMailService.getMailDetailByPromotionFilteredAndSorted(no, id, filter, sort);
        }

        List<ReceiveResponseDTO> receiveResponseDTOList;
        if (filter.isEmpty() && sort.isEmpty()) {
            receiveResponseDTOList = smartMailService.getMailListByPromotion(id);
        } else {
            receiveResponseDTOList = smartMailService.getMailListByPromotionFilteredAndSorted(id, filter, sort);
        }

        int preIndex = 0;
        int nextIndex = 0;
        int index = 0;

        for (int i = 0; i < receiveResponseDTOList.size(); i++) {
            if (receiveResponseDTOList.get(i).getNo().equals(no)) {
                preIndex = i > 0 ? i - 1 : 0;
                nextIndex = i < receiveResponseDTOList.size() - 1 ? i + 1 : receiveResponseDTOList.size() - 1;
                index = i;
                break;
            }
        }

        ReceiveResponseDTO preReceiveResponseDTO;
        ReceiveResponseDTO nextReceiveResponseDTO;

        if (index == 0 && preIndex == 0) {
            nextReceiveResponseDTO = receiveResponseDTOList.get(nextIndex);
            model.addAttribute("nextReceiveResponseDTO", nextReceiveResponseDTO);
        } else if (index == receiveResponseDTOList.size() - 1 && nextIndex == receiveResponseDTOList.size() - 1) {
            preReceiveResponseDTO = receiveResponseDTOList.get(preIndex);
            model.addAttribute("preReceiveResponseDTO", preReceiveResponseDTO);
        } else {
            preReceiveResponseDTO = receiveResponseDTOList.get(preIndex);
            nextReceiveResponseDTO = receiveResponseDTOList.get(nextIndex);
            model.addAttribute("preReceiveResponseDTO", preReceiveResponseDTO);
            model.addAttribute("nextReceiveResponseDTO", nextReceiveResponseDTO);
        }
        model.addAttribute("category", "promotionDetail");
        model.addAttribute("filter", filter);
        model.addAttribute("sort", sort);
        model.addAttribute("page", page);
        model.addAttribute("receiveResponseDTO", receiveResponseDTO);
        receiveService.updateReadStatus(no, "Y");
        return "receive/receiveDetail";
    }

    // 스마트 메일함 세부 사항 (청구 및 결제)
    @RequestMapping("/smart/charge/detail")
    public String mailDetailByCharge(HttpSession session,
                                    @RequestParam("no") String no,
                                    @RequestParam("filter") String filter,
                                    @RequestParam("sort") String sort,
                                    @RequestParam("page") Integer page,
                                    Model model) {

        String id = String.valueOf(session.getAttribute("userId"));
        

        ReceiveResponseDTO receiveResponseDTO;
        if (filter.isEmpty() && sort.isEmpty()) {
            receiveResponseDTO = smartMailService.getMailDetailByCharge(no, id);
        } else {
            receiveResponseDTO = smartMailService.getMailDetailByChargeFilteredAndSorted(no, id, filter, sort);
        }

        List<ReceiveResponseDTO> receiveResponseDTOList;
        if (filter.isEmpty() && sort.isEmpty()) {
            receiveResponseDTOList = smartMailService.getMailListByCharge(id);
        } else {
            receiveResponseDTOList = smartMailService.getMailListByChargeFilteredAndSorted(id, filter, sort);
        }

        int preIndex = 0;
        int nextIndex = 0;
        int index = 0;

        for (int i = 0; i < receiveResponseDTOList.size(); i++) {
            if (receiveResponseDTOList.get(i).getNo().equals(no)) {
                preIndex = i > 0 ? i - 1 : 0;
                nextIndex = i < receiveResponseDTOList.size() - 1 ? i + 1 : receiveResponseDTOList.size() - 1;
                index = i;
                break;
            }
        }

        ReceiveResponseDTO preReceiveResponseDTO;
        ReceiveResponseDTO nextReceiveResponseDTO;

        if (index == 0 && preIndex == 0) {
            nextReceiveResponseDTO = receiveResponseDTOList.get(nextIndex);
            model.addAttribute("nextReceiveResponseDTO", nextReceiveResponseDTO);
        } else if (index == receiveResponseDTOList.size() - 1 && nextIndex == receiveResponseDTOList.size() - 1) {
            preReceiveResponseDTO = receiveResponseDTOList.get(preIndex);
            model.addAttribute("preReceiveResponseDTO", preReceiveResponseDTO);
        } else {
            preReceiveResponseDTO = receiveResponseDTOList.get(preIndex);
            nextReceiveResponseDTO = receiveResponseDTOList.get(nextIndex);
            model.addAttribute("preReceiveResponseDTO", preReceiveResponseDTO);
            model.addAttribute("nextReceiveResponseDTO", nextReceiveResponseDTO);
        }
        model.addAttribute("category", "chargeDetail");
        model.addAttribute("filter", filter);
        model.addAttribute("sort", sort);
        model.addAttribute("page", page);
        model.addAttribute("receiveResponseDTO", receiveResponseDTO);
        receiveService.updateReadStatus(no, "Y");
        return "receive/receiveDetail";
    }

    // 스마트 메일함 세부 사항 (sns)
    @RequestMapping("/smart/sns/detail")
    public String mailDetailBySns(HttpSession session,
                                 @RequestParam("no") String no,
                                 @RequestParam("filter") String filter,
                                 @RequestParam("sort") String sort,
                                 @RequestParam("page") Integer page,
                                 Model model) {

        String id = String.valueOf(session.getAttribute("userId"));
        
        ReceiveResponseDTO receiveResponseDTO;
        if (filter.isEmpty() && sort.isEmpty()) {
            receiveResponseDTO = smartMailService.getMailDetailBySns(no, id);
        } else {
            receiveResponseDTO = smartMailService.getMailDetailBySnsFilteredAndSorted(no, id, filter, sort);
        }

        List<ReceiveResponseDTO> receiveResponseDTOList;
        if (filter.isEmpty() && sort.isEmpty()) {
            receiveResponseDTOList = smartMailService.getMailListBySns(id);
        } else {
            receiveResponseDTOList = smartMailService.getMailListBySnsFilteredAndSorted(id, filter, sort);
        }

        int preIndex = 0;
        int nextIndex = 0;
        int index = 0;

        for (int i = 0; i < receiveResponseDTOList.size(); i++) {
            if (receiveResponseDTOList.get(i).getNo().equals(no)) {
                preIndex = i > 0 ? i - 1 : 0;
                nextIndex = i < receiveResponseDTOList.size() - 1 ? i + 1 : receiveResponseDTOList.size() - 1;
                index = i;
                break;
            }
        }

        ReceiveResponseDTO preReceiveResponseDTO;
        ReceiveResponseDTO nextReceiveResponseDTO;

        if (index == 0 && preIndex == 0) {
            nextReceiveResponseDTO = receiveResponseDTOList.get(nextIndex);
            model.addAttribute("nextReceiveResponseDTO", nextReceiveResponseDTO);
        } else if (index == receiveResponseDTOList.size() - 1 && nextIndex == receiveResponseDTOList.size() - 1) {
            preReceiveResponseDTO = receiveResponseDTOList.get(preIndex);
            model.addAttribute("preReceiveResponseDTO", preReceiveResponseDTO);
        } else {
            preReceiveResponseDTO = receiveResponseDTOList.get(preIndex);
            nextReceiveResponseDTO = receiveResponseDTOList.get(nextIndex);
            model.addAttribute("preReceiveResponseDTO", preReceiveResponseDTO);
            model.addAttribute("nextReceiveResponseDTO", nextReceiveResponseDTO);
        }
        model.addAttribute("category", "snsDetail");
        model.addAttribute("filter", filter);
        model.addAttribute("sort", sort);
        model.addAttribute("page", page);
        model.addAttribute("receiveResponseDTO", receiveResponseDTO);
        receiveService.updateReadStatus(no, "Y");
        return "receive/receiveDetail";
    }
}
