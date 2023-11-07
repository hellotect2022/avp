package com.smartcc.avp.intfc.model.request;

import com.smartcc.avp.intfc.model.Header;
import com.smartcc.avp.intfc.model.request.IntfEventListRequest.Body;

import lombok.Data;
/**
 * <pre>
	public class Body
	{
		private String	searchName;
		private Integer	userId;
		private Integer	pageNo;
	}
	
	private Body body;
	private Header	header;
 *  </pre>
 */
@Data
public class SeacrhShopRequestList {
	@Data
	public class Body
	{
		private String	searchName;
		private Integer	userId;
		private Integer	pageNo;
		private String 	dbName;
	}
	private Body body;
	private Header	header;
}
