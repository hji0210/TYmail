package com.example.demo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MailMapper {

	void insertMail(HashMap<String, String> mail);
	void insertAddress(HashMap<String, String> address);
	void insertStorageMail(HashMap<String, String> mail);
	
	List<ContactDTO> selectAddress(@Param("send_id") String send_id);
	List<MailDTO> selectMail(@Param("send_id") String send_id);
	MailDTO selectContent(@Param("no") String no);
	List<StorageDTO> selectStorageMail(@Param("send_id") String send_id);
	
	void deleteStorage(@Param("storage_no") String storage_no);
	void deleteMail(Map<String, String> deleteM);
	void likeMail(@Param("no") String no);
	void deleteStorageList(@Param("no") String no);
	void storageAgain(HashMap<String, String> storage);
	
	List<ContactDTO> selectSearchAddress(HashMap<String, String> search);
	List<MailDTO> selectSearchMail(HashMap<String, String> search);
	List<StorageDTO> selectSearchStorage(HashMap<String, String> search);
	void likeMailStatus(HashMap<String, String> likeM);
	void insertReceiveMail(HashMap<String, String> mail);
	//HashMap<String,String> selectContentReceive(@Param("no") String no);
	String selectMaxAddress(@Param("send_id")String send_id);
	void deleteContact(@Param("no") String no);
}
