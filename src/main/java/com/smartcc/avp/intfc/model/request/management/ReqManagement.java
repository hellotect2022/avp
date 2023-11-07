package com.smartcc.avp.intfc.model.request.management;

import com.smartcc.avp.intfc.model.Header;

import lombok.Data;

@Data
public class ReqManagement {

	@Data
	public class Body 
	{
		private String dbName;
		private int userId;
		private String type;
		private String grade;
		private String name;
		private String phone;
		private String belong;
		private String userType;
	}
	
	private Body body;
	private Header header;
	
}
