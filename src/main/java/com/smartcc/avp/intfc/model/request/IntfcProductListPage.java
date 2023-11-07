package com.smartcc.avp.intfc.model.request;

import com.smartcc.avp.intfc.model.Header;
import com.smartcc.avp.intfc.model.request.SeacrhShopRequestList.Body;

import lombok.Data;

@Data
public class IntfcProductListPage {
	@Data
	public class Body
	{
		private Integer	pageNo;
		private Integer	userId;
		private Integer	shopId;
	}
	private Body body;
	private Header	header;
}
