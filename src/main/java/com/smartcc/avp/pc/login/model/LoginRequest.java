package com.smartcc.avp.pc.login.model;

import lombok.Data;
/**
 * <pre>
	
	private Integer	userId;
	private Integer	companyId;
	private String	confirmYn;
	
	//app에서 받는 파라미터
	private String	snsId;
	private String	snsType;
	private String	accessToken;
	private String	nickName;
	private String	profileImageUrl;
	private String	thumbnailImageUrl;
	private String	phone;
	
	
	//face book 에서 받아온 데이터 
	private String	gender;
	private String	email;
	
	private String	twitterValid;
*  </pre>
 */
@Data
public class LoginRequest{
	
	private Integer	userId;
	private Integer	companyId;
	private String	confirmYn;
	
	//app에서 받는 파라미터
	private String	snsId;
	private String	snsType;
	private String	accessToken;
	private String	nickName;
	private String	profileImageUrl;
	private String	thumbnailImageUrl;
	private String	phone;
	private String	pushToken;				// *>-- Add. 2018. 10. 11. JBum | 클라이언트 푸쉬 키
	
	
	//face book 에서 받아온 데이터 
	private String	gender;
	private String	email;
	
	private String	twitterValid;
}
