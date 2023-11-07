package com.smartcc.avp.pc.user.model.response;

import lombok.Data;
/**
 * <pre>
	private Integer	userId;
	private String	nickName;
	private String	userName;
	private String	snsType;
	private String	userType;
	private String	phone;
	private String	storageSize;
	private String	memberViewAuth;
	private String	shopUpdateAuth;
	private String	productUpdateAuth;
	private String	createDate;
	private String	companyShopName;
	
	
	private String	secessionYn;
	private String	secessionCreateDate;
	
	private String	authApplyYn;
	private String	authCreateDate;
*  </pre>
 */
@Data
public class UserDetailResponse {
	private String	email;
	private Integer	userId;
	private String	nickName;
	private String	userName;
	private String	snsType;
	private String	userType;
	private String	phone;
	private String	storageSize;
	private String	memberViewAuth;
	private String	shopUpdateAuth;
	private String	productUpdateAuth;
	private String	createDate;
	private String	createDttm;
	private String	companyShopName;
	
	
	private String	secessionYn;
	private String	secessionCreateDate;
	
	private String	authApplyYn;
	private String	authCreateDate;
	
	private String division;
	
}
