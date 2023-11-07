package com.smartcc.avp.intfc.model.request.zone;

import com.smartcc.avp.intfc.model.Header;

import lombok.Data;

@Data
public class IntfcZoneReco {

	@Data
	public class Body {
		public int companyId;
		public String zone = "";
		public int deviceId;
	}
	
	public Header header;
	public Body body;
	
}
