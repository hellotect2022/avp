package com.smartcc.avp.intfc.model.response.auth;

import lombok.Data;

@Data
public class IntfcAuthUserResponse {

	private Integer companyId;
	private Integer branchId;
	private String	authKey;
	private String	expireDttm;
	private String	arCapacity;
	
}
