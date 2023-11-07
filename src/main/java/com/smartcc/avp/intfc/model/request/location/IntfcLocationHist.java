package com.smartcc.avp.intfc.model.request.location;

import lombok.Data;

@Data
public class IntfcLocationHist {

	private Integer idx;
	private Integer	deviceId;
	private Integer	beaconId;
	private Integer	rssi;
	private String	createDttm;
	
}
