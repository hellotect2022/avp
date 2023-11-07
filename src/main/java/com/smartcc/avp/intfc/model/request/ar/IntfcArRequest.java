package com.smartcc.avp.intfc.model.request.ar;

import com.smartcc.avp.intfc.model.Header;

import lombok.Data;

@Data
public class IntfcArRequest {
	
	@Data
	public class Body
	{
		public Integer companyId;
		public Integer deviceId;
	}
	
	public Body		body	= new Body();
	public Header	header;
	
	public IntfcArRequest() {
		
	}
	
	public IntfcArRequest(int companyId) {
		this.body.companyId = companyId;
	}
	
}