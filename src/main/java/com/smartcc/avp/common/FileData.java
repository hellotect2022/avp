package com.smartcc.avp.common;

import java.io.File;

import lombok.Data;

@Data
public class FileData {
	   private Integer	userId;
	   private String   fileName;   //파일명
	   private File		rtnFile;
	   private Integer   fileId;   //파일 아이디
	   private String   originalFileName;   //원본파일명
	   private Long   fileSize;   //파일 사이즈
	   private String   fileSavePath;   //파일 저장 경로
	   private String   fileUrl;   //파일 URL
	   private String   statusCode;   //상태 코드
	   private String   createTime;   //등록일시
	   private Integer	createId;
	   private String   fileSrc; // 파일소스
	public Integer getFileId() {
		return fileId;
	}
	public void setFileId(Integer fileId) {
		this.fileId = fileId;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public Long getFileSize() {
		return fileSize;
	}
	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}
	public String getFileSavePath() {
		return fileSavePath;
	}
	public void setFileSavePath(String fileSavePath) {
		this.fileSavePath = fileSavePath;
	}
	public String getFileUrl() {
		return fileUrl;
	}
	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}
	public String getStatusCode() {
		return statusCode;
	}
	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	   
	   
}
