package com.smartcc.avp.common.file.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.smartcc.avp.common.FileData;
import com.smartcc.avp.common.model.ApiException;

public interface FileService {

//	@Transactional
//	int fileCheck(FileData fileData) throws Exception;
//
//	int updateFile(FileData fileData) throws Exception;
	FileData fileUpload(MultipartFile fileData, Integer userId) throws Exception;

	FileData fileUploadNotInsert(MultipartFile fileData, Integer userId) throws Exception;

	FileData additionalUploadNotInsert(MultipartFile fileData, Integer userId) throws Exception;

	int insertFileData(FileData data) throws Exception;

	boolean validImage(MultipartFile fileImage) throws ApiException;

	int deleteFile(Integer fileId) throws Exception;

	FileData getFile(Integer fileId) throws Exception;

	int deleteFileArr(List<Integer> list) throws Exception;

	long getMonthlyUsedSize(String startDay, String endDay) throws Exception;

	long getMyUsedSize(Integer userId) throws Exception;

	FileData getFileByName(String fileName) throws Exception;

}
