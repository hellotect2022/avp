package com.smartcc.avp.intfc.model.request;

import com.smartcc.avp.intfc.model.Header;

import lombok.Data;

@Data
public class IntfcTokenSubmitRequest {

	@Data
	public class Body
	{
		private Integer	userId;
		private Integer	pageNo;
		private String dbName;
		private Integer dbVersion;
		private String userType;
		private String pushToken;
	}
	
	private Body body;
	private Header	header;
	
}
