package com.smartcc.avp.intfc.model.request.management;

import lombok.Data;

@Data
public class ReqManagementDB {
	private String dbName;
	private int userId;
	private String type;
	private String name;
	private String phone;
	private String belong;
	private String userType;
}
