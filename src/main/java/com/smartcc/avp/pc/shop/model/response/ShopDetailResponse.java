package com.smartcc.avp.pc.shop.model.response;

import lombok.Data;
/**
 * <pre>
	private Integer shopId;
	private Integer companyId;
	private String	companyName;
	private String	shopName;
	private String	shopAddress;
	private String	score;
	private String	shopIntro;
	private String	shopDesc;
	private String	shopType;
	private String	shopHomepage;
	private String	shopPhone;
	private String	shopXLocation;
	private String	shopYLocation;
	private Integer	shopImageId;
	private String	shopImageUrl;
	private Integer	thumbnailImageId;
	private String	thumbnailImageUrl;
	private Integer	voiceFileId;
	private String	voiceFileName;
	private String	voiceFileUrl;
	private Integer	vrFileId;
	private String	vrFileName;
	private String	vrFileUrl;
	private	Integer	createId;
	private String	createDate;
	private Integer	updateId;
	private String	updateDate;
*  </pre>
 */
@Data
public class ShopDetailResponse {
	
	private String	userName;
	private Integer branchId;
	private String branchName;
	private String branchAddr;
	private int userCount;
	private String delYn;
	
	private Integer shopId;
	private Integer companyId;
	private String	companyName;
	private String	shopName;
	private String	shopAddress;
	private String	score;
	private String	shopIntro;
	private String	shopDesc;
	private String	shopType;
	private String	shopHomepage;
	private String	shopPhone;
	private String	shopXLocation;
	private String	shopYLocation;
	
	private Integer	leafletImageId;
	private String	leafletImageName;
	private String	leafletImageUrl;
	
	private String	shopImageId;
	private String	shopImageUrl;
	private Integer	thumbnailImageId;
	private String 	thumbnailImageName;
	private String	thumbnailImageUrl;
	private Integer	voiceFileId;
	private String	voiceFileName;
	private String	voiceFileUrl;
	
	private String 	shopImage;	
	private String  shopImage2;
	private String  shopImage3;
	private String  shopImage4;
	private String  shopImage5;
	private String  shopImage6;
	private String  shopImage7;
	private String  shopImage8;
	private String  shopImage9;
	private String  shopImage10;
	private Integer	countImage;
		
	private String  shopImageUrl2;
	private String  shopImageUrl3;
	private String  shopImageUrl4;
	private String  shopImageUrl5;
	private String  shopImageUrl6;
	private String  shopImageUrl7;
	private String  shopImageUrl8;
	private String  shopImageUrl9;
	private String  shopImageUrl10;
	
	//private Integer	vrFileId;
	//private String	vrFileName;
	//private String	vrFileUrl;
	
	private Integer vrPhotoId;
	private String 	vrPhotoName;
	private String 	vrPhotoUrl;
	
	private Integer	vrVideoId;
	private String	vrVideoName;
	private String	vrVideoUrl;
	
	private String  vrUrl;							// $>- Add 2017.4.19 . Bum
	private	Integer	createId;
	private String	createDate;
	private Integer	updateId;
	private String	updateDate;
}
