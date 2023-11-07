package com.smartcc.avp.intfc.model.request.orderlist;

import lombok.Data;

@Data
public class ReqOrderProcessComp {

	public int orderListId;
	public int itemId;
	public String serial;
	
	public ReqOrderProcessComp() {
		
	}
	
	public ReqOrderProcessComp(IntfcOrderProcessComp iopc) {
		this.orderListId = iopc.body.orderListId;
		this.itemId = iopc.body.itemId;
		this.serial = iopc.header.getSerial();
	}
	
}
