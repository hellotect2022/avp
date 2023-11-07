package com.smartcc.avp.intfc.model.response.emergency;

import lombok.Data;

@Data
public class EmergencyHist {

	private Integer idx;
	private String reportType;
	private String reportPhone;
	private String reportName;
	private String reportLatitude;
	private String reportLongitude;
	private String reportDate;
	private String responseName;
	private String responsePhone;
	private String responseResult;
	private String responseDate;
	
}
