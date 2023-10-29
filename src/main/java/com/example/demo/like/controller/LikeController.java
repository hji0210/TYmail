package com.example.demo.like.controller;

import com.example.demo.like.service.LikeService;
import com.example.demo.receive.DTO.ReceiveResponseDTO;
import com.example.demo.spam.service.SpamService;
import com.example.demo.trash.service.TrashService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class LikeController {
    @Autowired
    private LikeService likeService;

    @Autowired
    private TrashService trashService;

    @Autowired
    private SpamService spamService;

    // 즐겨찾기 목록 (받은메일함)
    @RequestMapping("/like/list")
    public String selectAllByLike(HttpSession session, Model model) {
        String id = String.valueOf(session.getAttribute("userId"));

        List<ReceiveResponseDTO> receiveResponseDTOList = likeService.selectAllByLike(id);
        model.addAttribute("category", "like");
        model.addAttribute("receiveResponseDTOList", receiveResponseDTOList);
        model.addAttribute("send_id", id);        
        
        return "additionalfeatures/additionList";
    }

    // 휴지통으로 이동 (체크박스)
    @RequestMapping("/like/move")
    public String deleteFromReceiveInLike(@RequestParam(name="checkbox", defaultValue="NO") String[] no) {
        String url = "redirect:/like/list";

        // 화면에서 휴지통에 있는 메일을 하나도 선택하지 않은 경우
        if (no.length == 1) {
            if (no[0].equals("NO")) {	// NO : 디폴트 값
                return url;
            }
        }

        // 화면에서 휴지통에 있는 메일을 1개 이상 선택하였을 경우
        likeService.deleteItemsInLike(no);
        return url;
    }

    // 휴지통으로 이동 (메일 세부 사항)
    @RequestMapping("/like/move-one")
    public String deleteOneFromReceiveInLike(@RequestParam(name="no", defaultValue="NO") String no) {
        String url = "redirect:/like/list";

        // 화면에서 휴지통에 있는 메일을 하나도 선택하지 않은 경우
            if (no.equals("NO")) {	// NO : 디폴트 값
                return url;
            }

        likeService.deleteItemInLike(no);
        return url;
    }

    // 휴지통, 즐겨찾기, 스팸메일 세부 사항
    @RequestMapping("/addition/detail")
    public String getAdditionDetail(@RequestParam("no") String no,
                                    @RequestParam("category") String category,
                                    Model model, HttpSession session) {

        String id = String.valueOf(session.getAttribute("userId"));
        trashService.updateReadStatus(no, "Y"); 

        // 카테고리 별 전체 목록 가져오기
        List<ReceiveResponseDTO> receiveResponseDTOList = getAllList(id, category);

        int preIndex = 0;
        int nextIndex = 0;
        int index = 0;

        // 이전글, 다음글
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

        ReceiveResponseDTO receiveResponseDTO = likeService.getAdditionDetail(no);
        if (category.equals("trash")) {
            model.addAttribute("category", "trash");
        }
        if (category.equals("like")) {
            model.addAttribute("category", "like");
        }
        if (category.equals("spam")) {
            model.addAttribute("category", "spam");
        }
        model.addAttribute("receiveResponseDTO", receiveResponseDTO);

        return "additionalfeatures/additionDetail";
    }

    // 카테고리 별 전체 목록 가져오기
    private List<ReceiveResponseDTO> getAllList(String id, String category) {

        List<ReceiveResponseDTO> receiveResponseDTOList = null;

        if (category.equals("trash")) {
            receiveResponseDTOList = trashService.selectAll(id);
        }
        if (category.equals("like")) {
            receiveResponseDTOList = likeService.selectAllByLike(id);
        }
        if (category.equals("spam")) {
            receiveResponseDTOList =spamService.getSpamMailList(id);
        }
        return receiveResponseDTOList;
    }
}
