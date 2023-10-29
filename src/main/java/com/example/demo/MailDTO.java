package com.example.demo;

public class MailDTO {

	private String no;
	private String send_id;
	private String receive_email;
	private String title;
	private String content;
	private String file_path;
	private char like_checked;
	private char storage;
	private String trash;
	private String send_date;
	
	public MailDTO() {}
	public MailDTO(String no, String receive_email, String title, String send_date, char like_checked) {
		this.no = no;
		this.receive_email = receive_email;
		this.title = title;
		this.send_date = send_date;
		this.like_checked = like_checked;
	}
	public MailDTO(String no, String send_id, String receive_email, String title, String content, String send_date) {
		this.no = no;
		this.send_id = send_id;
		this.receive_email = receive_email;
		this.title = title;
		this.content = content;
		this.send_date = send_date;
	}
	public MailDTO(String no, String send_id, String receive_email, String title, String file_path, char like_checked,
			char storage, String trash, String send_date) {
		this.no = no;
		this.send_id = send_id;
		this.receive_email = receive_email;
		this.title = title;
		this.file_path = file_path;
		this.like_checked = like_checked;
		this.storage = storage;
		this.trash = trash;
		this.send_date = send_date;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getSend_id() {
		return send_id;
	}
	public void setSend_id(String send_id) {
		this.send_id = send_id;
	}
	public String getReceive_email() {
		return receive_email;
	}
	public void setReceive_email(String receive_email) {
		this.receive_email = receive_email;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public char getLike_checked() {
		return like_checked;
	}
	public void setLike_checked(char like_checked) {
		this.like_checked = like_checked;
	}
	public char getStorage() {
		return storage;
	}
	public void setStorage(char storage) {
		this.storage = storage;
	}
	public String getTrash() {
		return trash;
	}
	public void setTrash(String trash) {
		this.trash = trash;
	}
	public String getSend_date() {
		return send_date;
	}
	public void setSend_date(String send_date) {
		this.send_date = send_date;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
