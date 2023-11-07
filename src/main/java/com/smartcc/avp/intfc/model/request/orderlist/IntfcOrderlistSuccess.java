package com.smartcc.avp.intfc.model.request.orderlist;

import com.smartcc.avp.intfc.model.Header;
import com.smartcc.avp.intfc.model.request.orderlist.IntfcOrderlistRequest.Body;

import lombok.Data;

@Data
public class IntfcOrderlistSuccess {
	
	@Data
	public class Body
	{
		private Integer companyId;
		private Integer branchId;
		private Integer orderlistId;
		private Integer itemId;
		private String 	dbName;
	}
	
	private Body body;
	private Header	header;
}
