package com.smartcc.avp.intfc.model.request;

import lombok.Data;

@Data
public class TokenInsertRequest {
	private String phoneNumber;
	private String userType;
	private String pushToken;
	private String dbName;
}
