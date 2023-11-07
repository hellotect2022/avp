package com.smartcc.avp.pc.work.model;

import lombok.Data;

@Data
public class Work {

	public int idx;
	public int companyId;
	public int deviceId;
	public String deviceName = "";
	public double latitude;
	public double longitude;
	public String updateDttm;
	
}
