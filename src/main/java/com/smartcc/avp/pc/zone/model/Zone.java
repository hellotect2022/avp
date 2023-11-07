package com.smartcc.avp.pc.zone.model;

import lombok.Data;

@Data
public class Zone {

	public int zoneId;
	public int companyId;
	public int branchId;
	public String zone = "";
	public double zoneLat;
	public double zoneLng;
	public int createId;
	public String createDttm;
	public int updateId;
	public String updateDttm;
	
}
