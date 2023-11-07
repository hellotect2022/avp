package com.smartcc.avp.intfc.model.request;

import com.smartcc.avp.intfc.model.Header;
import com.smartcc.avp.intfc.model.request.IntfcLoginCheckRequest.Body;

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
public class IntfEventListRequest {

	@Data
	public class Body
	{
		private String dbName;
		private Integer	eventId;
		private Integer	userId;
	}
	
	private Body body;
	private Header	header;
	
}
