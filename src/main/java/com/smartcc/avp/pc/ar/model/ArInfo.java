package com.smartcc.avp.pc.ar.model;

import com.smartcc.avp.common.FileData;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

import java.util.List;

/**
 * <pre>
private Integer			arId;
	private Integer			userId;
   private Integer			shopId;
   private String 			targetName;
   private String			shopName;
   private String			encodingData;
   private Integer			targetSize;
   private Integer			targetFileId;
   private String			targetFileName;
   private String			targetFilePath;
   private String			targetFileUrl;
   private Integer			objectFileId;
   private String			objectFileName;
   private String			objectFilePath;
   private String			objectFileUrl;
   private Integer			fileType;
   private String			targetId;
   private String			objectType;
   private String			metaData;
   private Integer			createId;
   private String			useStatus;
*  </pre>
 */
@Data
public class ArInfo {
	private String			dbName;					// Add 2017. 08. 23 JBum | 계정 관리용
	private Integer			userId;
   private Integer			shopId;
   private String 			targetName;
   private String			shopName;
   private String			encodingData;
   private Integer			targetSize;
   private Integer			targetFileId;
   private String			targetFileName;
   private String			targetFilePath;
   private String			targetFileUrl;
   private Integer			objectFileId;
   private String			objectFileName;
   private String			objectFilePath;
   private String			objectFileUrl;
   private Integer			mtlFileId;
   private String			mtlFileName;
   private String			mtlFilePath;
   private String			mtlFileUrl;
   private Integer			textureFileId;
   private String			textureFileName;
   private String			textureFilePath;
   private String			textureFileUrl;
   private Integer			fileType;
   private String			objectType;
   private String			objectPosition;
   private String			objectAltitude;
   private String			modeType;				// Add 2017.08.18 JBum | 모드 변경 추가
   private String			useStatus;
   private String			arScript;
   
   private Integer	arId;
   private Integer	companyId;
   private Integer	branchId;
   private Integer	itemId;
   private String	itemName;
   private String	arName;
   private String	targetId;
   private String	metaData;
   private Integer	arImgId;
   private String	arImgUrl;
   private Integer	arImgSize;
   private Integer	arSize;
   private String	arVideoUrl;
   private Integer	arVideoSize;
   private String	arTtsUrl;
   private Integer	arTtsSize;
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
