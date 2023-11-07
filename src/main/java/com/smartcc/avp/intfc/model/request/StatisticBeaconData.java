package com.smartcc.avp.intfc.model.request;

import com.smartcc.avp.intfc.model.Header;

import lombok.Data;

@Data
public class StatisticBeaconData {
	@Data
	public class Body 
	{
		private String dbName;
		private String tagName;
		private String tagType;
		private String distance;
	}
	
	private Body body;
	private Header header;
}
