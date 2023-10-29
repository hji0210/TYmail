package com.example.demo.spam.controller;

import com.example.demo.receive.DTO.ReceiveResponseDTO;
import com.example.demo.spam.service.SpamService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class SpamController {
    private final SpamService spamService;

    public SpamController(SpamService spamService) {
        this.spamService = spamService;
    }

    // 스팸 메일 목록
    @RequestMapping("/spam/list")
    public String getSpamMailList(HttpSession session, Model model) {
        String id = String.valueOf(session.getAttribute("userId"));

        List<ReceiveResponseDTO> receiveResponseDTOList = spamService.getSpamMailList(id);
        model.addAttribute("category", "spam");
        model.addAttribute("receiveResponseDTOList", receiveResponseDTOList);
        model.addAttribute("send_id", id);   
        return "additionalfeatures/additionList";
    }

    // 휴지통으로 이동 (체크박스)
    @RequestMapping("/spam/move")
    public String deleteFromReceiveInSpam(@RequestParam(name="checkbox", defaultValue="NO") String[] no) {
        String url = "redirect:/spam/list";

        // 화면에서 휴지통에 있는 메일을 하나도 선택하지 않은 경우
        if (no.length == 1) {
            if (no[0].equals("NO")) {	// NO : 디폴트 값
                return url;
            }
        }

        // 화면에서 휴지통에 있는 메일을 1개 이상 선택하였을 경우
        spamService.deleteItemsInSpam(no);
        return url;
    }

    // 휴지통으로 이동 (메일 세부 사항)
    @RequestMapping("/spam/move-one")
    public String deleteOneFromReceiveInSpam(@RequestParam(name="no", defaultValue="NO") String no) {
        String url = "redirect:/spam/list";

        // 화면에서 휴지통에 있는 메일을 하나도 선택하지 않은 경우
        if (no.equals("NO")) {	// NO : 디폴트 값
            return url;
        }

        spamService.deleteItemInSpam(no);
        return url;
    }
}
