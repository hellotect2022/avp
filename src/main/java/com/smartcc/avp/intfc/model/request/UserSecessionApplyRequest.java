package com.smartcc.avp.intfc.model.request;

import com.smartcc.avp.intfc.model.Header;
import com.smartcc.avp.intfc.model.request.InitRequest.Body;

import lombok.Data;
/**
 * <pre>
	public class Body
	{
		private Integer	userId;
	}
	
	private Body body;
	private Header	header;
 *  </pre>
 */
@Data
public class UserSecessionApplyRequest {
	
	@Data
	public class Body
	{
		private Integer	userId;
	}
	
	private Body body;
	private Header	header;

}
