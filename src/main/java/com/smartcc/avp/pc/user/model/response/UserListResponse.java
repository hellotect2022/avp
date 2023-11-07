package com.smartcc.avp.pc.user.model.response;

import lombok.Data;
/**
 * <pre>
	private Integer	userId;
	private String	nickName;
	private String	userName;
	private String	phone;
	private String	snsType;
	private String	userType;
	private String	createDate;
	private String	companyShopName;
	
*  </pre>
 */
@Data
public class UserListResponse {
	private Integer	userId;
	private String	nickName;
	private String	userName;
	private String	phone;
	private String	snsType;
	private String	userType;
	private String	createDate;
	private String	companyShopName;
	private String	pushToken;				// *>-- Add. 2018. 10. 11. JBum | 클라이언트 푸쉬 키
	private String	confirmUserId;
	private String 	updateDate;
	private String  companyName;
	private String	secessionDate;
	
}
