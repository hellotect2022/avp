package com.smartcc.avp.intfc.model.request.orderlist;

import com.smartcc.avp.intfc.model.Header;

import lombok.Data;

@Data
public class IntfcOrderlistRequest {
	
	@Data
	public class Body
	{
		private Integer	companyId;
		private Integer	branchId;
		private String dbName;
	}
	
	private Body body;
	private Header	header;

}
