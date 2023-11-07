package com.smartcc.avp.intfc.model.request.location;

import com.smartcc.avp.intfc.model.Header;

import lombok.Data;

@Data
public class IntfcLocationRequest {

	@Data
	public class Body
	{
		private Integer	companyId;
		private Integer branchId;
		private Integer	deviceId;
		private String	beaconIds;
		private String	beaconRssis;
		private String	preLatitude;
		private String	preLongitude;
		private String	dbName;
	}
	
	private Body body;
	private Header	header;
	
}
