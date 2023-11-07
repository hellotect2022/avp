package com.smartcc.avp.intfc.model.request;

import com.smartcc.avp.intfc.model.Header;
import com.smartcc.avp.intfc.model.request.IntfEventListRequest.Body;

import lombok.Data;

/**
 * <pre>
	public class Body
	{
		private Integer	shopId;
		private Integer	userId;
	}
	
	private Body body;
	private Header	header;
 *  </pre>
 */
@Data
public class IntfcShopDetailRequest {
	
	@Data
	public class Body
	{
		private String dbName;
		private Integer	shopId;
		private Integer	userId;
	}
	
	private Body body;
	private Header	header;
}
