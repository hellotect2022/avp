package com.smartcc.avp.intfc.model.request.auth;

import com.smartcc.avp.intfc.model.Header;

import lombok.Data;

@Data
public class IntfcAuthUserRequest {

	@Data
	public class Body
	{
		private Integer	itemId;
		private String dbName;
	}
	
	private Body body;
	private Header	header;
	
}
