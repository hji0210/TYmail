package com.example.demo;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

//@SessionAttributes("userId")
@Controller
public class MailController {
	
	@Autowired
	private MailMapper mailMapper;
	
	// ============ 변수 ============
	//@Autowired
	//HttpSession session;
	
	
	// ============ home ============
	@RequestMapping("/home/index")
	public String index(@SessionAttribute(name = "userId", required=false) String send_id, Model model) {
		
		if(send_id=="") {
			return "/login";
		}	
		else {
			model.addAttribute("send_id", send_id);
		}	
		return "home/index";
	}

	
	// ============ send ============
	@RequestMapping("/send/sendForm")
	public String sendForm(@SessionAttribute(name = "userId", required=false) String send_id, Model model) {
		
		model.addAttribute("send_id", send_id);
		return "send/sendForm";
	}
	
	@RequestMapping("/send/sendCC")
	public String sendCC(@SessionAttribute(name = "userId", required=false) String send_id, @RequestParam("content") String content) {

		String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd.HH:mm:ss"));
		HashMap<String,String> mail = new HashMap<>();
		
		mail.put("date", date);
		mail.put("no", send_id+"."+date);
		mail.put("send_id", send_id);
		mail.put("receive_email", "team2@tymail.com");
		mail.put("title", "Complaints or Compliments from " + send_id);
		mail.put("content", content);
		mail.put("file_path", "");
		
		mailMapper.insertMail(mail);
		mailMapper.insertReceiveMail(mail);	
		
		return "send/sendList";
	}
	
	@RequestMapping("/send/replyForm")
	public String replyForm(@SessionAttribute(name = "userId", required=false) String send_id, @RequestParam(required=false) String receive_email, Model model) {
		
		model.addAttribute("receive_email", receive_email);
		model.addAttribute("send_id", send_id);
		return "send/replyForm";
	}
	
	@RequestMapping("/send/sendMail")
	public String sendMail(@SessionAttribute(name = "userId", required=false) String send_id, @RequestParam HashMap<String, String> mail, Model model) {

		String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd.HH:mm:ss"));
		mail.put("date", date);
		//mail.put("no", send_id+"."+date);
		mail.put("send_id", send_id);
		
		String m = mail.get("receive_email");
		String[] mm = m.split(",");
	
		for(int i = 0 ; i < mm.length ; i++) {
			mail.put("no", send_id+"."+date+i);
			mail.put("receive_email", mm[i]);
			
			mailMapper.insertMail(mail);
			mailMapper.insertReceiveMail(mail);	
		}
		
		model.addAttribute("send_id", send_id);
		return "send/sendCom";
	}
	
	@RequestMapping("/send/openFile")
	public String openFile(Model model) {

		File dir = new File("C:/images");
		String[] files = dir.list();
		model.addAttribute("files", files);

		return "send/openFile";
	}
	
	@RequestMapping("/send/sendStorageMail")
	public String sendStorageMail(@SessionAttribute(name = "userId", required=false) String send_id, 
									@RequestParam HashMap<String, String> mail, 
									@RequestParam("storage_no") String storage_no) {
		
		String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd.HH:mm:ss"));
		mail.put("date", date);
		//mail.put("no", send_id+"."+date);
		mail.put("send_id", send_id);
		
		String m = mail.get("receive_email");
		String[] mm = m.split(",");
	
		for(int i = 0 ; i < mm.length ; i++) {
			mail.put("no", send_id+"."+date+i);
			mail.put("recieve_email", mm[i]);
			mailMapper.insertMail(mail);
			mailMapper.insertReceiveMail(mail);
			mailMapper.deleteStorage(mail.get("storage_no"));
		}
		return "send/sendCom";
	}
	
	@RequestMapping("/send/mailDetail")
	public String mailDetail(@SessionAttribute(name = "userId", required=false) String send_id, 
								@RequestParam("no") String no ,Model model) {	
		
		int pre;
		int next;
		
		List<MailDTO> mailList = new ArrayList<>();
		mailList = mailMapper.selectMail(send_id);
		
		MailDTO detailContent = mailMapper.selectContent(no);
		model.addAttribute("detailContent", detailContent);
		model.addAttribute("send_id", send_id);
		
		for(int i =0; i<mailList.size();i++) {
			if(mailList.get(i).getNo().equals(no)) {	
				if(i==0) {
					next = i+1;
					model.addAttribute("nextContent", mailList.get(next));
				}
				else if(i==mailList.size()-1) {
					pre = i-1;
					model.addAttribute("preContent", mailList.get(pre));
				}
				else {
					pre = i-1;
					next = i+1;
					model.addAttribute("nextContent", mailList.get(next));
					model.addAttribute("preContent", mailList.get(pre));
				}
			}	
		}
		
		return "send/detailContent";
	}
	
	@RequestMapping("/send/sendList")
	public String selectMail(@SessionAttribute(name = "userId", required=false) String send_id, 
								@RequestParam(required=false) HashMap<String, String> search, Model model) {	
		
		List<MailDTO> mailList = new ArrayList<>();

		if(search.isEmpty() || search.get("search_content").isBlank()) {	
			mailList = mailMapper.selectMail(send_id);
			model.addAttribute("mailList", mailList);
			model.addAttribute("send_id", send_id);
		} else {
			search.put("send_id", send_id);
			mailList = mailMapper.selectSearchMail(search);
			model.addAttribute("mailList", mailList);
		}	
		return "send/sendList";
	}
	
	@RequestMapping("/send/sendMyList")
	public String sendMyList(@SessionAttribute(name = "userId", required=false) String send_id, Model model) {	
		
		List<MailDTO> mailList = new ArrayList<>();

		HashMap<String, String> search = new HashMap<>();
		search.put("search_option", "receive_email");
		search.put("search_content", send_id);
		search.put("send_id", send_id);
		mailList = mailMapper.selectSearchMail(search);
		model.addAttribute("mailList", mailList);

		return "send/sendList";
	}
	
	@RequestMapping("/send/replyEmail")
	public String replyEmail(@SessionAttribute(name = "userId", required=false) String send_id, 
								@RequestParam("no") String no, Model model) {	
		MailDTO reply = mailMapper.selectContent(no);
		
		model.addAttribute("reply", reply);		
		model.addAttribute("send_id", send_id);
		
		return "send/replyFormReceive";
	}
	
	@RequestMapping("/send/sendAgain")
	public String sendAgain(@SessionAttribute(name = "userId", required=false) String send_id, 
							@RequestParam("no") String no,Model model) {	
		
		MailDTO again = mailMapper.selectContent(no);
		
		model.addAttribute("reply", again);		
		model.addAttribute("send_id", send_id);
			
		return "send/replyForm";
	}
	
	
	// ============ contact ============
	@RequestMapping("/contact/saveContact")
	public String saveContact() {
		return "contact/saveContact";
	}
	
	@RequestMapping("/contact/showContact")
	public String showContact(@SessionAttribute(name = "userId", required=false) String send_id, 
			@RequestParam(required=false) HashMap<String, String> search,
			Model model) {

		List<ContactDTO> contactList = new ArrayList<>();
		
		if (search.isEmpty() || search.get("search_content").isBlank()) {
			contactList = mailMapper.selectAddress(send_id);
			model.addAttribute("addressList", contactList);
		} else {
			search.put("id", send_id);
			contactList = mailMapper.selectSearchAddress(search);
			model.addAttribute("addressList", contactList);
		}
		
		return "contact/showContact";
	}
	
	@RequestMapping("/contact/saveContactAct")
	public String saveContactAct(@SessionAttribute(name = "userId", required=false) String send_id, @RequestParam HashMap<String, String> address) {	
		
		String contact = mailMapper.selectMaxAddress(send_id);
		int con = Integer.parseInt(contact) + 1;
		
		address.put("id", send_id);
		address.put("no", Integer.toString(con));
		
		mailMapper.insertAddress(address);
		return "contact/saveContact";
	}
	
	@RequestMapping("/contact/selectContact")
	public String selectContact(@SessionAttribute(name = "userId", required=false) String send_id, 
								@RequestParam(required=false) HashMap<String, String> search,
								Model model) {
		
		List<ContactDTO> contactList = new ArrayList<>();
		
		if(search.isEmpty() || search.get("search_content").isBlank()) {	
			contactList = mailMapper.selectAddress(send_id);
			model.addAttribute("addressList", contactList);	
		} else {
			search.put("id", send_id);
			contactList = mailMapper.selectSearchAddress(search);
			model.addAttribute("addressList", contactList);
		}		
		return "contact/selectContact";
	}
	

	// ============ storage ============
	@RequestMapping("/storage/storageList")
	public String storageList(@SessionAttribute(name = "userId", required=false) String send_id, 
								@RequestParam(required=false) HashMap<String, String> search, Model model) {
		
		List<StorageDTO> storageList = new ArrayList<>();
		
		if(search.isEmpty() || search.get("search_content").isBlank()) {	
			storageList = mailMapper.selectStorageMail(send_id);
			model.addAttribute("storageList", storageList);	
			model.addAttribute("send_id", send_id);
		} else {
			search.put("send_id", send_id);
			storageList = mailMapper.selectSearchStorage(search);
			model.addAttribute("storageList", storageList);
			model.addAttribute("send_id", send_id);
		}	
		return "storage/storageList";
	}
	
	@RequestMapping("/storage/storageMail")
	public String storageMail(@SessionAttribute(name = "userId", required=false) String send_id, 
								@RequestParam(required=false) HashMap<String, String> mail, 
								Model model) {
		
		String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd.HH:mm:ss"));
		mail.put("storage_date", date);
		//mail.put("storage_no", send_id+"."+date);
		mail.put("send_id", send_id);
		
		String m = mail.get("receive_email");
		String[] mm = m.split(",");
	
		for(int i = 0 ; i < mm.length ; i++) {
			mail.put("storage_no", send_id+"."+date+i);
			mail.put("receive_email", mm[i]);
			mailMapper.insertStorageMail(mail);
		}
		
		List<StorageDTO> storageList = new ArrayList<>();
		storageList = mailMapper.selectStorageMail(send_id);
		model.addAttribute("storageList", storageList);
		model.addAttribute("send_id", send_id);
		
		return "storage/storageList";
	}
	
	@RequestMapping("/storage/storageRewrite")
	public String storageRewrite(@SessionAttribute(name = "userId", required=false) String send_id, 
									@RequestParam HashMap<String, String> storage, 
									Model model) {
		model.addAttribute("storage", storage);
		System.out.println(storage.get("file_path"));
		model.addAttribute("send_id", send_id);
		return "storage/storageRewrite";
	}
	
	@RequestMapping("/storage/storageAgain")
	public String storageAgain(@SessionAttribute(name = "userId", required=false) String send_id, 
								@RequestParam HashMap<String, String> storage, 
								@RequestParam("storage_no") String storage_no,
								Model model) {
		
		String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd.HH:mm:ss"));
		storage.put("storage_date", date);	
		storage.put("storage_no", storage_no);	

		mailMapper.storageAgain(storage);
		
		List<StorageDTO> storageList = new ArrayList<>();
		storageList = mailMapper.selectStorageMail(send_id);
		model.addAttribute("storageList", storageList);
		model.addAttribute("send_id", send_id);
		
		return "storage/storageList";
	}
	
	
	// ============ delete ============	
	@RequestMapping(value = "/delete/deleteMail", method = RequestMethod.POST)
	@ResponseBody
	public String deleteMail(@RequestParam(value="arr[]") String[] arr) {	

		String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd.HH:mm:ss"));
		Map<String,String> deleteM= new HashMap<>();
		deleteM.put("trash", date);
		//deleteM.put("send_id", send_id);
		
		for (int i = 0; i < arr.length; i++) {
			String no = arr[i];
			deleteM.put("no", no);
			mailMapper.deleteMail(deleteM);
		}
		return "delete/deleteMail";
	}
	
	@RequestMapping(value = "/delete/deleteStorageList", method = RequestMethod.POST)
	@ResponseBody
	public String deleteStorageList(@RequestParam(value="arr[]") String[] arr) {	
		
		System.out.println(arr[0]);

		for (int i = 0; i < arr.length; i++) {
			String no = arr[i];
			mailMapper.deleteStorageList(no);
		}
		return "delete/deleteStorageList";
	}

	
	@RequestMapping(value = "/delete/deleteContact", method = RequestMethod.POST)
	@ResponseBody
	public String deleteContact(@RequestParam(value="arr[]") String[] arr) {	
		
		System.out.println(arr[0]);		
		for (int i = 0; i < arr.length; i++) {
			String no = arr[i];
			mailMapper.deleteContact(no);
		}
		return "contact/showContact";
	}
	
	
	// ============ like ============	
	@RequestMapping(value = "/like/likeMail", method = RequestMethod.POST)
	@ResponseBody
	public String likeMail(@RequestParam(value="no", required=false) String no,
							@RequestParam(value="like_checked", required=false) String like_checked) {	
		
		System.out.println(no);
		System.out.println(like_checked);
		
		HashMap<String,String> likeM = new HashMap<>();
		likeM.put("no", no);
		likeM.put("like_checked", like_checked);

		mailMapper.likeMailStatus(likeM);
		
		return "like/likeMail";
	}

	
}

