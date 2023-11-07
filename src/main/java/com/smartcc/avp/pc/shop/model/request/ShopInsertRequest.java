package com.smartcc.avp.pc.shop.model.request;

import com.smartcc.avp.pc.shop.model.Shop;

import lombok.Data;
/**
 * <pre>
	private Integer shopId;
	private Integer userId;
	private Integer companyId;
	private String	shopName;
	private String	shopIntro;
	private String	shopDesc;
	private String	shopAddress;
	private String	shopType;
	private String	shopHomepage;
	private String	shopPhone;
	private String	shopXLocation;
	private String	shopYLocation;
	
	private Integer	shopImageId;
	private String	shopImageFileName;
	private String	shopImageFilePath;
	private Integer shopImageFileSize;
	
	private Integer	thumbnailImageId;
	private String	thumbnailImageFileName;
	private String	thumbnailImageFilePath;
	private Integer	thumbnailImageFileSize;

	private Integer	voiceFileId;
	private String	voiceFileName;
	private String	voiceFilePath;
	private Integer voiceFileSize;

	private Integer	vrFileId;
	private String	vrFileName;
	private String 	vrFilePath;
	private Integer vrFileSize;
	
	
	
	private	Integer	createId;
	private String	createDate;
	private Integer	updateId;
	private String	updateDate;
*  </pre>
 */
@Data
public class ShopInsertRequest extends Shop{
	private Integer branchId;
	private String branchName;
	private String branchAddr;
	
	private Integer shopId;
	private Integer userId;
	private Integer companyId;
	private String	shopName;
	private String	shopIntro;
	private String	shopDesc;
	private String	shopAddress;
	private String	shopType;
	private String	shopHomepage;
	private String	shopPhone;
	private String	shopXLocation;
	private String	shopYLocation;
	
	private Integer leafletImageId;
	private	String	leafletImageName;
	private String	leafletImagePath;
	private Integer	leafletImageSize;
	
	private String	shopImageId; 
	private String	shopImageFileName;
	private String	shopImageFilePath;
	private Integer shopImageFileSize;
	
	private Integer	thumbnailImageId;
	private String	thumbnailImageFileName;
	private String	thumbnailImageFilePath;
	private Integer	thumbnailImageFileSize;

	private Integer	voiceFileId;
	private String	voiceFileName;
	private String	voiceFilePath;
	private Integer voiceFileSize;

	private Integer	vrPhotoId;
	private String	vrPhotoName;
	private String 	vrPhotoPath;
	private Integer vrPhotoSize;	
	
	private Integer	vrVideoId;
	private String	vrVideoName;
	private String 	vrVideoPath;
	private Integer vrVideoSize;
	
	private	Integer	createId;
	private String	createDate;
	private Integer	updateId;
	private String	updateDate;
}
