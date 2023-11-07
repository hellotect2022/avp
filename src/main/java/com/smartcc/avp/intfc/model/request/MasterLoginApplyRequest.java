package com.smartcc.avp.intfc.model.request;

import com.smartcc.avp.intfc.model.Header;
import com.smartcc.avp.intfc.model.request.UserSecessionApplyRequest.Body;

import lombok.Data;
/**
 * <pre>
	public class Body
	{
		private String	email;
		private String	userPassword;
	}
	
	private Body body;
	private Header	header;
 *  </pre>
 */
@Data
public class MasterLoginApplyRequest {
	@Data
	public class Body
	{
		private String	email;
		private String	userPassword;
	}
	
	private Body body;
	private Header	header;
}
