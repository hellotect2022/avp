package com.smartcc.avp.intfc.model.request;

import com.smartcc.avp.intfc.model.Header;
import com.smartcc.avp.intfc.model.request.IntfcLoginRequest.Body;

import lombok.Data;
/**
 * <pre>
	public class Body
	{
		private Integer	userId;
		private String	score;
		private Integer	shopId;
	}
	
	private Body body;
	private Header	header;
 *  </pre>
 */
@Data
public class ShopScoreInsertRequest {

	@Data
	public class Body
	{
		private Integer	userId;
		private String	score;
		private Integer	shopId;
		private String dbName;
	}
	
	private Body body;
	private Header	header;
}
