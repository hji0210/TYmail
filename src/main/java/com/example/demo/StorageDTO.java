package com.example.demo;

public class StorageDTO {

	private String storage_no;
	private String send_id;
	private String receive_email;
	private String title;
	private String content;
	private String storage_date;
	private String file_path;
	

	public StorageDTO() {}
	public StorageDTO(String storage_no, String receive_email, String title, String content,
			String storage_date) {
		this.storage_no = storage_no;
		this.receive_email = receive_email;
		this.title = title;
		this.content = content;
		this.storage_date = storage_date;
	}
	public StorageDTO(String storage_no, String send_id, String receive_email, String title, String content,
			String storage_date) {
		this.storage_no = storage_no;
		this.send_id = send_id;
		this.receive_email = receive_email;
		this.title = title;
		this.content = content;
		this.storage_date = storage_date;
	}
	public StorageDTO(String storage_no, String send_id, String receive_email, String title, String content,
			String storage_date, String file_path) {
		this.storage_no = storage_no;
		this.send_id = send_id;
		this.receive_email = receive_email;
		this.title = title;
		this.content = content;
		this.storage_date = storage_date;
		this.file_path = file_path;
	}
	public String getStorage_no() {
		return storage_no;
	}
	public void setStorage_no(String storage_no) {
		this.storage_no = storage_no;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStorage_date() {
		return storage_date;
	}
	public void setStorage_date(String storage_date) {
		this.storage_date = storage_date;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

}
