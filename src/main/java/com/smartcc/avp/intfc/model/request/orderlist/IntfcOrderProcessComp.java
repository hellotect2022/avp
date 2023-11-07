package com.smartcc.avp.intfc.model.request.orderlist;

import com.smartcc.avp.intfc.model.Header;

import lombok.Data;

@Data
public class IntfcOrderProcessComp {

	@Data
	public class Body {
		public int orderListId;
		public int itemId;
	}
	
	public Body body;
	public Header header;
	
}
