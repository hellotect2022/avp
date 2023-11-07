package com.smartcc.avp.intfc.model.request.emergency;

import lombok.Data;

@Data
public class EmergencyInsert {

	private String reportType;
	private String reportPhone;
	private String reportLatitude;
	private String reportLongitude;
	
}
