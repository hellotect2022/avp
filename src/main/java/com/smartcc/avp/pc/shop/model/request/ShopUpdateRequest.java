package com.smartcc.avp.pc.shop.model.request;

import com.smartcc.avp.pc.shop.model.Shop;

import lombok.Data;
/**
 * <pre>
	private Integer shopId;
	private Integer companyId;
	private Integer userId;
	private String	shopName;
	private String	shopIntro;
	private String	shopAddress;
	private String	shopDesc;
	private String	shopType;
	private String	shopHomepage;
	private String	shopPhone;
	private String	shopXLocation;
	private String	shopYLocation;
	
	private Integer	shopImageId;
	private String	shopImageFileName;
	private String  shopImageFilePath;
	private Integer	preShopImageId;
	
	private Integer	thumbnailImageId;
	private String	thumbnailImageFileName;
	private String  thumbnailImageFilePath;
	private Integer	preThumbnailImageId;
	
	private Integer	voiceFileId;
	private String	voiceFileName;
	private String  voiceFilePath;
	private Integer	preVoiceFileId;
	
	private Integer	vrFileId;
	private String	vrFileName;
	private String  vrFilePath;
	private Integer	preVrFileId;
	
	
	private	Integer	createId;
	private String	createDate;
	private Integer	updateId;
	private String	updateDate;

*  </pre>
 */
@Data
public class ShopUpdateRequest  {
	private Integer branchId;
	private String branchName;
	private String branchAddr;
	
	private Integer shopId;
	private Integer companyId;
	private Integer userId;
	private String	shopName;
	private String	shopIntro;
	private String	shopAddress;
	private String	shopDesc;
	private String	shopType;
	private String	shopHomepage;
	private String	shopPhone;
	private String	shopXLocation;
	private String	shopYLocation;
	
	private Integer	leafletImageId;
	private String	leafletImageName;
	private String	leafletImagePath;
	private Integer	preLeafletImageId;
	
	private String	shopImageId;
	private String	shopImageFileName;
	private String  shopImageFilePath;
	private String	preShopImageId;
	
	private String 	preShopImage;
	private String  preShopImage2;
	private String  preShopImage3;
	private String  preShopImage4;
	private String  preShopImage5;
	private String  preShopImage6;
	private String  preShopImage7;
	private String  preShopImage8;
	private String  preShopImage9;
	private String  preShopImage10;
	
	private String	preLeafletImage;
	private String	preThumbnail;
	private String 	preVoiceFileName;
	private String	preVrPhotoName;
	private String	preVrVideoName;
	
	private Integer	thumbnailImageId;
	private String	thumbnailImageFileName;
	private String  thumbnailImageFilePath;
	private Integer	preThumbnailImageId;
	
	private Integer	voiceFileId;
	private String	voiceFileName;
	private String  voiceFilePath;
	private Integer	preVoiceFileId;
	
	private Integer	vrVideoId;
	private String	vrVideoName;
	private String  vrVideoPath;
	private Integer	preVrVideoId;
	
	private Integer	vrPhotoId;
	private String	vrPhotoName;
	private String	vrPhotoPath;
	private Integer	preVrPhotoId;
		
	private	Integer	createId;
	private String	createDate;
	private Integer	updateId;
	private String	updateDate;

}
