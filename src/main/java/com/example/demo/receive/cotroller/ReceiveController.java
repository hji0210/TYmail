package com.example.demo.receive.cotroller;

import com.example.demo.MailDTO;
import com.example.demo.pagination.DTO.PageResponseDTO;
import com.example.demo.receive.DTO.ReceiveResponseDTO;
import com.example.demo.receive.DTO.ReceiveUpdateLikeCheckedRequestDTO;
import com.example.demo.receive.DTO.ReceiveUpdateReadStatusRequestDTO;
import com.example.demo.receive.DTO.ReceiveUpdateTrashRequestDTO;
import com.example.demo.receive.service.ReceiveService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
public class ReceiveController {

    // paging
    private int PAGE_CORRECTION = 1;
    private final int PAGE_LENGTH = 10;

    private final ReceiveService receiveService;

    public ReceiveController(ReceiveService receiveService) {
        this.receiveService = receiveService;
    }

    // paging_받은메일함(내림차순)
    @RequestMapping("/receive/list")
    public String findAllReceiveMailById(Model model, HttpSession session,
                                         @RequestParam("page") Integer page, @RequestParam(value = "size", defaultValue = "5") Integer size) {

        String id = String.valueOf(session.getAttribute("userId"));
        int total = receiveService.count(id);

        page -= PAGE_CORRECTION;

        int firstRow = (page * size) + 1;
        System.out.println(firstRow);
        int lastRow = firstRow + 4;
        if (lastRow > total) {
            lastRow = total;
        }

        List<ReceiveResponseDTO> receiveResponseDTOList = receiveService.getReceiveMailListPageById(id, firstRow, lastRow);
        PageResponseDTO<ReceiveResponseDTO> pageResponseDTO = new PageResponseDTO<>(page, size, PAGE_LENGTH, total, receiveResponseDTOList);

        model.addAttribute("category", "receive");
        model.addAttribute("receiveResponseDTOList", pageResponseDTO.getDtoList());
        model.addAttribute("page", pageResponseDTO.getPage() + 1);
        model.addAttribute("pageTotal", pageResponseDTO.getTotal());
        model.addAttribute("pageStart", pageResponseDTO.getStart());
        model.addAttribute("pageEnd", pageResponseDTO.getEnd());
        model.addAttribute("prev", pageResponseDTO.isPrev());
        model.addAttribute("next", pageResponseDTO.isNext());
        model.addAttribute("send_id", id);

        return "receive/receiveList";
    }

    /**
     * @param id (아이디)
     * @param filter (필터) 모든 메일 : all , 안읽은 메일 : unread, 중요 메일 : mark, 첨부 메일 : attach, 나에게 온 메일 : tome
     * @param sort (정렬) 최신 순 : 0, 오래된 순 : 1
     */
    @RequestMapping("/receive/list/folder")
    public String findAllReceiveMailByFilterAndSort(HttpSession session,
                                                    @RequestParam("filter") String filter,
                                                    @RequestParam("sort") String sort,
                                                    Model model,
                                                    @RequestParam("page") Integer page, @RequestParam(value = "size", defaultValue = "5") Integer size) {

        String id = String.valueOf(session.getAttribute("userId"));
        int total = receiveService.getReceiveMailListByFilterAndSort(id, filter, sort).size();
        page -= PAGE_CORRECTION;

        int firstRow = (page * size) + 1;
        int lastRow = firstRow + 4;
        if (lastRow > total) {
            lastRow = total;
        }

        List<ReceiveResponseDTO> receiveResponseDTOList = receiveService.getReceiveMailListPageByFilterAndSort(id, filter, sort, firstRow, lastRow);
        PageResponseDTO<ReceiveResponseDTO> pageResponseDTO = new PageResponseDTO<>(page, size, PAGE_LENGTH, total, receiveResponseDTOList);

        model.addAttribute("category", "receiveFolder");
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

    // 중요 메일 업데이트
    @RequestMapping(value = "/receive/update/mark", method = RequestMethod.POST)
    public String changeLikeChecked(@RequestBody ReceiveUpdateLikeCheckedRequestDTO receiveUpdateLikeCheckedRequestDTO) {
        receiveService.updateLikeChecked(receiveUpdateLikeCheckedRequestDTO.getNo(), receiveUpdateLikeCheckedRequestDTO.getLikeChecked());
        return "forward:/receive/list";
    }

    // 읽음, 안읽음 상태 업데이트
    @RequestMapping(value = "/receive/update/readStatus", method = RequestMethod.POST)
    public String changeReadStatus(@RequestBody ReceiveUpdateReadStatusRequestDTO receiveUpdateReadStatusRequestDTO) {
        receiveService.updateReadStatus(receiveUpdateReadStatusRequestDTO.getNo(), receiveUpdateReadStatusRequestDTO.getReadStatus());
        return "forward:/receive/list";
    }

    // 삭제 (휴지통으로 이동 / checkbox)
    @RequestMapping(value = "/receive/update/trashes", method = RequestMethod.POST)
    public String deleteItems(@RequestBody ReceiveUpdateTrashRequestDTO receiveUpdateTrashRequestDTO) {
        receiveService.updateTrash(receiveUpdateTrashRequestDTO);
        return "forward:/receive/list";

    }

    // 삭제 (휴지통으로 이동 / 메일 세부 사항)
    @RequestMapping(value = "/receive/update/trash", method = RequestMethod.POST)
    public String deleteItem(@RequestParam("no") String no,
                             @RequestParam("filter") String filter,
                             @RequestParam("sort") String sort,
                             @RequestParam("category") String category) {
        receiveService.updateTrashOne(no);
        if (category.equals("receive")) {
            if (filter.isEmpty() && sort.isEmpty()) {
                return "redirect:/receive/list?page=1";
            } else {
                return "redirect:/receive/list/folder?filter=" + filter + "&sort=" + sort + "&page=1";
            }
        }

        if (category.equals("promotionDetail")) {
            if (filter.isEmpty() && sort.isEmpty()) {
                return "redirect:/smart/promotion?page=1";
            } else {
                return "redirect:/smart/promotion/folder?filter=" + filter + "&sort=" + sort + "&page=1";
            }
        }

        if (category.equals("chargeDetail")) {
            if (filter.isEmpty() && sort.isEmpty()) {
                return "redirect:/smart/charge?page=1";
            } else {
                return "redirect:/smart/charge/folder?filter=" + filter + "&sort=" + sort + "&page=1";
            }
        }

        if (category.equals("snsDetail")) {
            if (filter.isEmpty() && sort.isEmpty()) {
                return "redirect:/smart/sns?page=1";
            } else {
                return "redirect:/smart/sns/folder?filter=" + filter + "&sort=" + sort + "&page=1";
            }
        }

        return "redirect:/receive/list?page=1";
    }


    // 메일 세부 사항 (받은메일함)
    @RequestMapping("/receive/detail")
    public String receiveMailDetail(HttpSession session,
                                    @RequestParam("no") String no,
                                    @RequestParam("filter") String filter,
                                    @RequestParam("sort") String sort,
                                    @RequestParam("page") Integer page,
                                    Model model) {

        String id = String.valueOf(session.getAttribute("userId"));
        

        ReceiveResponseDTO receiveResponseDTO = receiveService.getReceiveMailDetail(no);

        List<ReceiveResponseDTO> receiveResponseDTOList;
        if (filter.isEmpty() && sort.isEmpty()) {
            receiveResponseDTOList = receiveService.getReceiveMailListById(id);
        } else {
            receiveResponseDTOList = receiveService.getReceiveMailListByFilterAndSort(id, filter, sort);
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

        model.addAttribute("category", "receive");
        model.addAttribute("filter", filter);
        model.addAttribute("sort", sort);
        model.addAttribute("page", page);
        model.addAttribute("receiveResponseDTO", receiveResponseDTO);
        receiveService.updateReadStatus(no, "Y");
        return "receive/receiveDetail";
    }
    
    @RequestMapping("/receive/receiveSearch")
    public String receiveSearch(@RequestParam(required=false) HashMap<String, String> search, Model model, HttpSession session) {   

       String id = String.valueOf(session.getAttribute("userId"));
       List<ReceiveResponseDTO> receiveResponseDTOList = new ArrayList<>();
       

       if(search.isEmpty() || search.get("search_content").isBlank()) {   
          receiveResponseDTOList = receiveService.getReceiveMailListById(id);
          model.addAttribute("receiveResponseDTOList", receiveResponseDTOList);
       } else {
          search.put("id", id);
          receiveResponseDTOList = receiveService.selectSearchMail(search);
          model.addAttribute("receiveResponseDTOList", receiveResponseDTOList);
       }   
        model.addAttribute("category", "search");
        return "receive/receiveList";
    }
}
