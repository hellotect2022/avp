package com.smartcc.avp.intfc.model.request.item;

import com.smartcc.avp.intfc.model.Header;

import lombok.Data;

@Data
public class IntfcItemDetailRequest {
	
	@Data
	public class Body
	{
		private String	itemIds;
		private String	quantities;
		private String	dbName;
	}
	
	private Body body;
	private Header	header;

}
