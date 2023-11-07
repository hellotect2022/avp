package com.smartcc.avp.intfc.model.request;

import com.smartcc.avp.intfc.model.Header;
import com.smartcc.avp.intfc.model.request.IntfcLoginCheckRequest.Body;

import lombok.Data;
/**
 * <pre>
	public class Body
	{
		private Integer	userId;
		private Integer	pageNo;
	}
	
	private Body body;
	private Header	header;
 *  </pre>
 */
@Data
public class IntfcShopListRequest {

	@Data
	public class Body
	{
		private Integer	userId;
		private Integer	pageNo;
		private String dbName;
		private Integer dbVersion;
	}
	
	private Body body;
	private Header	header;
}
