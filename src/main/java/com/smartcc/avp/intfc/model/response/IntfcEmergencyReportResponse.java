package com.smartcc.avp.intfc.model.response;

import com.smartcc.avp.intfc.model.Header;
import com.smartcc.avp.intfc.model.request.IntfcEmergencyReportRequest;
import com.smartcc.avp.intfc.model.request.IntfcEmergencyReportRequest.Body;

import lombok.Data;

@Data
public class IntfcEmergencyReportResponse {
	@Data
	public class Body
	{
		private Integer	userId;
		private Integer	pageNo;
		private String dbName;
		private Integer dbVersion;
		private String reportType;
		private String result;
		private Integer idx;
	}
	
	private Body body;
	private Header	header;
}
