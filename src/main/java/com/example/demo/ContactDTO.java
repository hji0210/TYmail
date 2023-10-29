package com.example.demo;

public class ContactDTO {

	private String name;
	private String contact_email;
	private String id;
	private int no;
	

	public ContactDTO() {}
	public ContactDTO(String name, String contact_email) {
		this.name = name;
		this.contact_email = contact_email;
	}
	public ContactDTO(String name, String contact_email, String id) {
		this.name = name;
		this.contact_email = contact_email;
		this.id = id;
	}
	public ContactDTO(String name, String contact_email, String id, int no) {
		this.name = name;
		this.contact_email = contact_email;
		this.id = id;
		this.no = no;
	}

	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContact_email() {
		return contact_email;
	}
	public void setContact_email(String contact_email) {
		this.contact_email = contact_email;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
		
}
