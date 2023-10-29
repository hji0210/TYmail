package com.example.demo.trash.controller;

import com.example.demo.receive.DTO.ReceiveResponseDTO;
import com.example.demo.receive.DTO.ReceiveUpdateLikeCheckedRequestDTO;
import com.example.demo.receive.DTO.ReceiveUpdateReadStatusRequestDTO;
import com.example.demo.trash.mapper.TrashMapper;
import com.example.demo.trash.service.TrashService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class TrashController {

    @Autowired
    private TrashService trashService;
    @Autowired
    private TrashMapper trashMapper;

    // 휴지통 목록 (받은메일함)
    @RequestMapping("/trash/list")
    public String selectAllByTrash(HttpSession session, Model model) {
        String id = String.valueOf(session.getAttribute("userId"));

        List<ReceiveResponseDTO> receiveResponseDTOList = trashService.selectAll(id);
        model.addAttribute("category", "trash");
        model.addAttribute("receiveResponseDTOList", receiveResponseDTOList);
        model.addAttribute("send_id", id);   
        return "additionalfeatures/additionList";
    }

    // 수동으로 받은메일함 영구 삭제 (체크박스)
    @RequestMapping("/trash/remove")
    public String deleteFromReceive(@RequestParam(name="checkbox", defaultValue="NO") String[] no) {
        String url = "redirect:/trash/list";

        // 화면에서 휴지통에 있는 메일을 하나도 선택하지 않은 경우
        if (no.length == 1) {
            if (no[0].equals("NO")) {	// NO : 디폴트 값
                return url;
            }
        }

        // 화면에서 휴지통에 있는 메일을 1개 이상 선택하였을 경우
        trashService.deleteFromReceive(no);
        return url;
    }

    // 메일 세부 사항 영구 삭제 (수동)
    @RequestMapping("/trash/remove-one")
    public String deleteOneFromReceive(@RequestParam(name="no", defaultValue = "NO") String no) {
        String url = "redirect:/trash/list";

        // 화면에서 휴지통에 있는 메일을 하나도 선택하지 않은 경우
        if (no.equals("NO")) {
                return url;
        }

        // 화면에서 휴지통에 있는 메일을 1개 이상 선택하였을 경우
        trashService.deleteOneFromReceive(no);
        return url;
    }

    // 받은메일함으로 이동
    @RequestMapping("/trash/move")
    public String moveToReceive(@RequestParam(name = "checkbox", defaultValue="NO") String[] no) {
        String url = "redirect:/trash/list";
        if (no.length == 1) {
            if (no[0].equals("NO")) {	// NO : 디폴트 값
                return url;
            }
        }
        trashService.moveToReceive(no);
        return url;
    }

    // 받은메일함으로 이동 (메일 세부 사항)
    @RequestMapping("/trash/move-one")
    public String moveOneToReceive(@RequestParam(name = "no", defaultValue="NO") String no) {
        String url = "redirect:/trash/list";
        if (no.equals("NO")) {
            return url;
        }
        trashService.moveOneToReceive(no);
        return url;
    }

    // 중요 메일 업데이트
    @RequestMapping(value = "/update/mark", method = RequestMethod.POST)
    public String changeLikeChecked(@RequestBody ReceiveUpdateLikeCheckedRequestDTO receiveUpdateLikeCheckedRequestDTO,
                                    @RequestParam("category") String category) {
        trashService.updateLikeChecked(receiveUpdateLikeCheckedRequestDTO.getNo(), receiveUpdateLikeCheckedRequestDTO.getLikeChecked());
        if (category.equals("trash")) {
            return "forward:/trash/list";
        }

        if (category.equals("like")) {
            return "forward:/like/list";
        }

        return "forward:/spam/list";
    }

    // 읽음, 안읽음 상태 업데이트
    @RequestMapping(value = "/update/readStatus", method = RequestMethod.POST)
    public String changeReadStatus(@RequestBody ReceiveUpdateReadStatusRequestDTO receiveUpdateReadStatusRequestDTO,
                                   @RequestParam("category") String category) {
        trashService.updateReadStatus(receiveUpdateReadStatusRequestDTO.getNo(), receiveUpdateReadStatusRequestDTO.getReadStatus());
        if (category.equals("trash")) {
            return "forward:/trash/list";
        }

        if (category.equals("like")) {
            return "forward:/like/list";
        }
        return "forward:/spam/list";
    }

}
