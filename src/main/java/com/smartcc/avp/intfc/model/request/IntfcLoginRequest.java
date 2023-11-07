package com.smartcc.avp.intfc.model.request;

import com.smartcc.avp.intfc.model.Header;

import lombok.Data;

@Data
public class IntfcLoginRequest {
	
	@Data
	public class Body
	{
		private Integer	userId;
		private Integer	companyId;
		private String	confirmYn = "N";
		
		private String	sessionId;
		//app에서 받는 파라미터
		private String	snsId;
		private String	snsType;
		private String	accessToken;
		private String	email;
		private String	gender;
		private String	nickName;
		private String	phone;
		private String	profileImageUrl;
		private String	thumbnailImageUrl;
		private String	couponOne;
		private String	couponTwo;
		private String  couponThree;
	}
	
	private Body body;
	private Header	header;
	
}
