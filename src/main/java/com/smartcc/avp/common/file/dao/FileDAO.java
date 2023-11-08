package com.smartcc.avp.common.file.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.common.FileData;

public interface FileDAO {


	int updateFile(FileData fileData) throws Exception ;
	int checkFile(FileData fileData) throws Exception ;
	int insertFile(FileData fileData) throws Exception ;
	
	int	deleteFile(@Param("fileId")Integer fileId) throws Exception ;
	
	FileData	getFile(@Param("fileId")Integer fileId) throws Exception ;

	int deleteFileArr(@Param("list") List<Integer> list) throws Exception;

	long getMonthlyUsedSize(@Param("startDay") String startDay,@Param("endDay") String endDay) throws Exception ;

	long getMyUsedSize(@Param("userId")Integer userId) throws Exception;

	FileData getFileByName(@Param("fileName")String fileName) throws Exception;

	List<FileData> getFileList() throws Exception;
}
