package com.smartcc.avp.pc.user.model;

import lombok.Data;
/**
 * <pre>
	private Integer userId;
	private String	userPassword;
	private String	email;
	private String	userName;
	private String	snsId;
	private String	userThumbnailImage;
	private String	snsType;
	private String	userType;
	private String	confirmYn;
	private Integer	companyId;
	private String	gender;
	private Integer	shopId;
	private Integer	confirmUserId;
	private String	memberViewAuth;
	private String	shopUpdateAuth;
	private String	productUpdateAuth;
	private String	sessionId;
	private String	createDate;
	private String	storageSize;
	private String	updateDate;
	
*  </pre>
 */
@Data
public class User {
	private Integer userId;
    private String         name;
    private String        nickName;
    private Integer        companyId;
    private Integer branchId;
    private String        branchName;
    private String        email;
    private String        phone;
    private String        snsType;
    private String        snsId;
    private String        accessToken;
    private String        userType;
    private String        storageSize;
    private Integer        confirmId;
    private String        confirmYn;
    private Integer        delId;
    private String        delYn;
    private String         joinDttm;
    private String         outDttm;
    
    private String        userPassword;
    private String        userName;
    
    private String        companyShopName;
    private String        userThumbnailImage;        
    private String        gender;
    private Integer        shopId;
    private Integer        confirmUserId;
    private String        memberViewAuth;
    private String        shopUpdateAuth;
    private String        productUpdateAuth;
    private String        sessionId;
    private String        createDate;
    
    private String        updateDate;
    
    private String        secessionYn;
    private String        secessionCreateDate;
    
    private String        authApplyYn;
    private String        authCreateDate;
    
    private String         division;
    
    private String        couponOne;
    private String        couponTwo;
    private String        couponThree;
}
