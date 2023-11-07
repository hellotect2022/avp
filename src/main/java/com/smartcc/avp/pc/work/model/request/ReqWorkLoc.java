package com.smartcc.avp.pc.work.model.request;

import lombok.Data;

@Data
public class ReqWorkLoc {

	public int companyId;
	public int deviceId;
	public String zone;
	
	public ReqWorkLoc() {
		
	}
	
	public ReqWorkLoc(int companyId, int deviceId, String zone) {
		this.companyId = companyId;
		this.deviceId = deviceId;
		this.zone = zone;
	}
	
}
