package com.smartcc.avp.intfc.model.request;

import com.smartcc.avp.intfc.model.Header;
import com.smartcc.avp.intfc.model.request.IntfcLoginCheckRequest.Body;

import lombok.Data;


/**
 * 
 * <pre>
	public class Body
	{
		private String	countType;
		private Integer	userId;
	}
	
	private Body body;
	private Header	header;
*  </pre>
 */
@Data
public class CountStatisticRequest {

	@Data
	public class Body
	{
		private String	countType;
		private Integer	userId;
	}
	
	private Body body;
	private Header	header;
}
