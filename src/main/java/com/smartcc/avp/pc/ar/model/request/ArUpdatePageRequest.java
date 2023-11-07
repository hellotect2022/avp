package com.smartcc.avp.pc.ar.model.request;

import lombok.Data;
/**
 * <pre>
		private Integer				arId;
	   private Integer			userId;
	   private Integer			shopId;
	   private String 			targetId;
	   private String 			targetName;
	   private String			shopName;
	   
	   
	   private String			preObjectFileName;
	   private String			objectFileName;
	   private String			objectFileUrl;
	   private String			objectFilePath;
	   private Integer			objectFileId;
	   private Integer			preObjectFileId;
	   
	   
	   private String			encodingData;
	   
	   private Integer			targetFileId;
	   private Integer			preTargetFileId;
	   private String			targetFileName;
	   private String			targetFilePath;
	   private String			targetFileUrl;
	   
	   private Integer			targetSize;
	   private Integer			fileType;
	   private String			objectType;
	   private String			metaData;
	   private Integer			createId;
	   private Integer			updateId;
	   private String			useStatus;
*  </pre>
 */
@Data
public class ArUpdatePageRequest {
	   private Integer			userId;
	   private Integer			shopId;
	   private String 			targetName;
	   private String			shopName;
	   
	   
	   private String			preObjectFileName;
	   private String			objectFileName;
	   private String			objectFileUrl;
	   private String			objectFilePath;
	   private Integer			objectFileId;
	   private Integer			preObjectFileId;
	   
	   
	   private String			encodingData;
	   
	   private Integer			targetFileId;
	   private Integer			preTargetFileId;
	   private String			targetFileName;
	   private String			targetFilePath;
	   private String			targetFileUrl;
	   
	   private Integer			targetSize;
	   private Integer			fileType;
	   private String			objectType;
	   private String			useStatus;
	   
	   private Integer	arId;
	   private Integer	companyId;
	   private Integer	branchId;
	   private Integer	itemId;
	   private String	itemName;
	   private String	arName;
	   private String	targetId;
	   private String	metaData;
	   private Integer	preArImgId;
	   private Integer	arImgId;
	   private String	arImgUrl;
	   private Integer	arSize;
	   private Integer	preRecogImgId;
	   private String	preRecogImgName;
	   private Integer	recogImgId;
	   private String	recogImgUrl;
	   private Integer	delId;
	   private String	delYn;
	   private Integer	createId;
	   private String	createUser;
	   private String	createDate;
	   private Integer	updateId;
	   private String	updateUser;
	   private String	updateDate;
}
