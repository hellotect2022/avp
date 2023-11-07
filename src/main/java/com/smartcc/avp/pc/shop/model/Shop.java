package com.smartcc.avp.pc.shop.model;

import lombok.Data;
/**
 * <pre>
	private Integer shopId;
	private Integer companyId;
	private String	shopName;
	private String	shopIntro;
	private String	shopDesc;
	private String	shopType;
	private String	shopHomepage;
	private String	shopPhone;
	private String	shopXLocation;
	private String	shopAddress;
	private String	shopYLocation;
	private Integer	shopImageId;
	private String	shopImageUrl;
	private String	intfcShopImageUrl;
	private Integer	thumbnailImageId;
	private String	thumbnailImageUrl;
	private String	intfcThumbnailImageUrl;
	private Integer	voiceFileId;
	private String	voiceFileUrl;
	private String	intfcVoiceFileUrl;
	private Integer	vrFileId;
	private String	vrFileUrl;
	private String	intfcVrFileUrl;
	private	Integer	createId;
	private String	createDate;
	private Integer	updateId;
	private String	updateDate;
*  </pre>
 */
@Data
public class Shop {
	private Integer shopId;
	private Integer companyId;
	private String	shopName;
	private String	shopIntro;
	private String	shopDesc;
	private String	shopType;
	private String	shopHomepage;
	private String	shopPhone;
	private String	shopXLocation;
	private String	shopAddress;
	private String	shopYLocation;
	
	private Integer	leafletImageId;
	private String	leafletImageUrl;
	
	private String	shopImageId;
	private String	shopImageUrl;
	private String	intfcShopImageUrl;
	private Integer	thumbnailImageId;
	private String	thumbnailImageUrl;
	private String	intfcThumbnailImageUrl;
	private Integer	voiceFileId;
	private String	voiceFileUrl;
	private String	intfcVoiceFileUrl;
	private Integer	vrVideoId;
	private String	vrVideoUrl;
	private String	intfcVrVideoUrl;
	private Integer vrPhotoId;
	private String	vrPhotoUrl;
	private String	intfcVrPhotoUrl;
	private String	vrUrl;
	private	Integer	createId;
	private String	createDate;
	private Integer	updateId;
	private String	updateDate;

}
