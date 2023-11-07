package com.smartcc.avp.pc.beacon.model;

import lombok.Data;

@Data
public class Beacon {

	private Integer companyId;
	private Integer	branchId;
	private Integer beaconId;
	private String	beaconName;
	private String	beaconMac;
	private String	beaconLat;
	private String	beaconLng;
	private Integer	delId;
	private String	delYn;
	private Integer	createId;
	private String	createUser;
	private String	createDttm;
	private Integer	updateId;
	private String	updateUser;
	private String 	updateDttm;
	
}
