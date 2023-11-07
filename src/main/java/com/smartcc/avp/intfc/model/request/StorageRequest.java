package com.smartcc.avp.intfc.model.request;

import com.smartcc.avp.intfc.model.Header;

import lombok.Data;
/**
 * <pre>
	public class Body
	{
		private Integer	userId;
		private String	fileSize;
	}
	
	private Body body;
	private Header	header;
 *  </pre>
 */
@Data
public class StorageRequest {

	@Data
	public class Body
	{
		private Integer	userId;
		private String	fileSize;
	}
	
	private Body body;
	private Header	header;
}
