package com.smartcc.avp.pc.ar.model.request;

import lombok.Data;

@Data
public class ArInsertRequest {
		private String 			dbName;						// Add 2017. 08. 23 JBum | For managing account
		private Integer				arId;
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
	   
	    private Integer			mtlFileId;
	    private Integer			preMtlFileId;
	    private String			mtlFileName;
	    private String			mtlFilePath;
	    private String			mtlFileUrl;
	    
	    private Integer			textureFileId;
	    private Integer			preTextureFileId;
	    private String			textureFileName;
	    private String			textureFilePath;
	    private String			textureFileUrl;
	    
 	    private Integer			targetSize;
	    private Integer			fileType;
	    private String			objectType;
	    private String			objectPosition;
	    private String			objectAltitude;
	    private String			metaData;
	    private String			modeType;				// Add 2017.08.18 JBum | 모드 변경 추가
	    
	    private Integer			updateId;
	    private String			useStatus;
	    
	    private Integer	companyId;
	    private Integer branchId;
	    private Integer	itemId;
	    private String	arName;
	    private String	targetId;
	    private String	metadata;
	    private Integer	imgSize;
	    private Integer	arImgId;
	    private Integer	recogImgId;
	    private Integer	createId;
	    private String	createDttm;
	    
}
