package com.smartcc.avp.pc.login.model.request;

import lombok.Data;
/**
 * <pre>
	private Integer	companyId;
	private Integer	shopId;
	private String	phone;
	private String	userType;
	private Integer	userId;
	private Integer	confirmUserId;
	private String	storageSize;
*  </pre>
 */
@Data
public class LoginSubRequest {
	private String 	groupDbName;
	private Integer	companyId;
	private Integer	branchId;
	private String	phone;
	private String	userType;
	private Integer	userId;
	private Integer	confirmUserId;
	private String	storageSize;
	private String	email;
	private String	companyDirect;
}
