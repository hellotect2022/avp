package com.smartcc.avp.intfc.model.request;

import com.smartcc.avp.intfc.model.Header;

import lombok.Data;

@Data
public class StatisticTagData {

	@Data
	public class Body 
	{
		private String dbName;
		private String tagName;
		private String tagType;
	}
	
	private Body body;
	private Header header;
	
}
